// event_client_registroEventfimaste.mqh
// Módulo adaptado para o EA Fimaster
// - Função pública principal: registroEventfimaste(eventType, payloadJson)
// - Inicie com registroEventfimaste_init(gatewayUrl, secretKey, timeout_ms)
// - Chame registroEventfimaste_flush() periodicamente (ex.: OnTimer)
// - Persistência local: arquivo newline-delimited JSON na pasta Files do terminal
//
// Atenção:
// - NÃO coloque secrets no código; use variáveis de input ou mecanismo seguro.
// - Adicione a URL do gateway em Tools -> Options -> Expert Advisors -> Allow WebRequest for listed URL
// - Teste em staging antes de produção
#property strict

#include <stdlib.mqh>

// Configuráveis (padrões; altere em tempo de execução via registroEventfimaste_init)
string REFEC_gateway_url        = "";               // ex: "https://meu-gateway.example.com/events"
string REFEC_secret_key        = "";               // segredo HMAC (não commite)
int    REFEC_timeout_ms        = 8000;             // timeout WebRequest
string REFEC_queue_filename    = "registro_event_queue.jsonl"; // arquivo na pasta Files (comum)
int    REFEC_max_retry         = 5;                // tentativas antes de arquivar

// Estrutura de evento
struct REFECEvent
{
  string id;
  string event_type;
  string payload; // JSON string (já serializado)
  datetime ts;
  int attempts;
};

// ---------- utilitários ----------
string REFEC_MakeEventId()
{
  // timestamp + nonce para simplicidade
  return IntegerToString((long)TimeCurrent()) + "-" + IntegerToString(MathRand());
}

string REFEC_JsonEscape(const string s)
{
  string r = s;
  StringReplace(r, "\\", "\\\\");
  StringReplace(r, "\"", "\\\"");
  StringReplace(r, "\n", "\\n");
  StringReplace(r, "\r", "\\r");
  return r;
}

// HMAC-SHA256 simples (usa CryptEncode se disponível). Se CryptEncode falhar, tenta SHA256 (fallback - menos seguro para HMAC)
string REFEC_HmacSha256(string key, string message)
{
  uchar data[], k[], out[];
  StringToCharArray(message, data, 0, StringLen(message));
  StringToCharArray(key, k, 0, StringLen(key));
  // Tentar HMAC via CryptEncode
  int res = CryptEncode(CRYPT_HMAC_SHA256, data, k, out);
  if(res <= 0)
  {
    // fallback: apenas hash SHA256 (TESTE) - preferir HMAC em produção
    CryptEncode(CRYPT_HASH_SHA256, data, k, out);
  }
  string hex = "";
  for(int i=0;i<ArraySize(out);i++) hex += StringFormat("%02x", out[i]);
  return hex;
}

// ---------- fila local (arquivo JSONL) ----------
// Abre/Cria arquivo no modo append; usa FILE_COMMON para localizar em pasta Files comum do terminal
bool REFEC_AppendLineToFile(const string filename, const string line)
{
  int handle = FileOpen(filename, FILE_WRITE|FILE_READ|FILE_TXT|FILE_COMMON);
  if(handle == INVALID_HANDLE)
  {
    Print("REFEC: Falha abrir arquivo append: ", filename, " Err:", GetLastError());
    return false;
  }
  FileSeek(handle, 0, SEEK_END);
  FileWriteString(handle, line + "\n");
  FileClose(handle);
  return true;
}

bool REFEC_SaveEventToLocal(const REFECEvent &e)
{
  string line = "{\"event_id\":\"" + e.id + "\",\"event\":\"" + e.event_type + "\",\"payload\":" + e.payload + ",\"timestamp\":" + IntegerToString((long)e.ts) + ",\"attempts\":" + IntegerToString(e.attempts) + "}";
  return REFEC_AppendLineToFile(REFEC_queue_filename, line);
}

// Carrega pendentes (parsing simples)
int REFEC_LoadPendingEvents(REFECEvent &out_events[])
{
  ArrayResize(out_events,0);
  int handle = FileOpen(REFEC_queue_filename, FILE_READ|FILE_TXT|FILE_COMMON);
  if(handle == INVALID_HANDLE) return 0;
  while(!FileIsEnding(handle))
  {
    string line = FileReadString(handle);
    if(StringLen(StringTrim(line))==0) continue;
    REFECEvent e;
    e.id = REFEC_ExtractJsonString(line, "event_id");
    e.event_type = REFEC_ExtractJsonString(line, "event");
    e.payload = REFEC_ExtractJsonObject(line, "payload");
    string ts_s = REFEC_ExtractJsonValue(line, "timestamp");
    e.ts = (ts_s==""?TimeCurrent():(datetime)StringToInteger(ts_s));
    string att_s = REFEC_ExtractJsonValue(line, "attempts");
    e.attempts = (att_s==""?0:StringToInteger(att_s));
    ArrayResize(out_events, ArraySize(out_events)+1);
    out_events[ArraySize(out_events)-1] = e;
  }
  FileClose(handle);
  return ArraySize(out_events);
}

// Remove evento da fila (reescreve sem o event_id removido)
bool REFEC_RemoveEventFromLocal(string event_id)
{
  int handle = FileOpen(REFEC_queue_filename, FILE_READ|FILE_TXT|FILE_COMMON);
  if(handle == INVALID_HANDLE) return false;
  string temp = "";
  while(!FileIsEnding(handle))
  {
    string line = FileReadString(handle);
    if(StringLen(StringTrim(line))==0) continue;
    string id = REFEC_ExtractJsonString(line, "event_id");
    if(id == event_id) continue;
    temp += line + "\n";
  }
  FileClose(handle);
  int h2 = FileOpen(REFEC_queue_filename, FILE_WRITE|FILE_TXT|FILE_COMMON);
  if(h2 == INVALID_HANDLE) return false;
  FileWriteString(h2, temp);
  FileClose(h2);
  return true;
}

// ---------- extração JSON mínima ----------
string REFEC_ExtractJsonString(string json, string key)
{
  int pos = StringFind(json, "\"" + key + "\"");
  if(pos < 0) return "";
  int colon = StringFind(json, ":", pos);
  if(colon < 0) return "";
  int quote = StringFind(json, "\"", colon);
  if(quote < 0) return "";
  int endq = StringFind(json, "\"", quote+1);
  if(endq < 0) return "";
  return StringSubstr(json, quote+1, endq-quote-1);
}

string REFEC_ExtractJsonValue(string json, string key)
{
  int pos = StringFind(json, "\"" + key + "\"");
  if(pos < 0) return "";
  int colon = StringFind(json, ":", pos);
  if(colon < 0) return "";
  int i = colon+1;
  while(i < StringLen(json) && (StringSubstr(json,i,1) == " " || StringSubstr(json,i,1) == "\t")) i++;
  int j = i;
  while(j < StringLen(json) && StringSubstr(json,j,1) != "," && StringSubstr(json,j,1) != "}" && StringSubstr(json,j,1) != "\n") j++;
  string val = StringSubstr(json, i, j-i);
  val = StringTrim(val);
  return val;
}

string REFEC_ExtractJsonObject(string json, string key)
{
  int pos = StringFind(json, "\"" + key + "\"");
  if(pos < 0) return "{}";
  int colon = StringFind(json, ":", pos);
  if(colon < 0) return "{}";
  int brace = StringFind(json, "{", colon);
  if(brace < 0) return "{}";
  int depth = 0;
  int i = brace;
  for(; i < StringLen(json); i++)
  {
    string ch = StringSubstr(json,i,1);
    if(ch == "{") depth++;
    else if(ch == "}") depth--;
    if(depth == 0) break;
  }
  if(i >= StringLen(json)) return "{}";
  return StringSubstr(json, brace, i-brace+1);
}

// ---------- API pública adaptada ----------

// Inicialização (chame em OnInit). Ex: registroEventfimaste_init(InpServerUrl, "SEU_SECRET");
void registroEventfimaste_init(string gateway_url, string secret_key, int timeout_ms = 8000)
{
  REFEC_gateway_url = gateway_url;
  REFEC_secret_key = secret_key;
  REFEC_timeout_ms = timeout_ms;
  // garante existência do arquivo
  int h = FileOpen(REFEC_queue_filename, FILE_READ|FILE_WRITE|FILE_TXT|FILE_COMMON);
  if(h != INVALID_HANDLE) FileClose(h);
  Print("registroEventfimaste: init gateway=", REFEC_gateway_url);
}

// Enfileira evento para envio assíncrono (principal função de uso)
// eventType: ex. "ordem_executada", "ping", "inicializacao"
// payloadJson: JSON já serializado (sem quotes). Ex: "{\"symbol\":\"EURUSD\",\"ticket\":123}"
void registroEventfimaste(string eventType, string payloadJson)
{
  REFECEvent e;
  e.id = REFEC_MakeEventId();
  e.event_type = eventType;
  e.payload = payloadJson;
  e.ts = TimeCurrent();
  e.attempts = 0;
  if(!REFEC_SaveEventToLocal(e))
    Print("registroEventfimaste: falha ao salvar evento localmente: ", e.id);
  else
    Print("registroEventfimaste: evento enfileirado: ", e.id, " tipo:", eventType);
}

// Envia eventos pendentes; chame em OnTimer() ou via loop não crítico
void registroEventfimaste_flush()
{
  REFECEvent pending[];
  int n = REFEC_LoadPendingEvents(pending);
  if(n == 0) return;
  Print("registroEventfimaste_flush: ", n, " eventos pendentes");
  for(int i=0;i<n;i++)
  {
    REFECEvent e = pending[i];
    string body = "{\"event_id\":\"" + e.id + "\",\"event\":\"" + e.event_type + "\",\"payload\":" + e.payload + ",\"timestamp\":" + IntegerToString((long)e.ts) + "}";
    string signature = REFEC_HmacSha256(REFEC_secret_key, body);
    string headers = "Content-Type: application/json\r\nX-Signature: " + signature + "\r\n";
    char data[];
    StringToCharArray(body, data, 0, StringLen(body));
    char result[];
    string result_headers;
    ResetLastError();
    int res = WebRequest("POST", REFEC_gateway_url, headers, REFEC_timeout_ms, data, result, result_headers);
    if(res >= 200 && res < 300)
    {
      Print("registroEventfimaste_flush: enviado com sucesso ", e.id, " status:", res);
      REFEC_RemoveEventFromLocal(e.id);
    }
    else
    {
      Print("registroEventfimaste_flush: falha envio ", e.id, " status:", res, " err:", GetLastError());
      e.attempts++;
      if(e.attempts >= REFEC_max_retry)
      {
        Print("registroEventfimaste_flush: excedeu retries, removendo evento ", e.id);
        REFEC_RemoveEventFromLocal(e.id);
        // opcional: gravar em dead-letter (arquivo separado)
      }
      else
      {
        // atualizar attempts: remove e reappend com attempts incrementado
        REFEC_RemoveEventFromLocal(e.id);
        // reappend com tentativas atualizadas
        int oldAttempts = e.attempts;
        e.attempts = oldAttempts; // já incrementado
        REFEC_SaveEventToLocal(e);
      }
    }
  }
}

// Envio imediato (usar com cautela — bloqueante)
bool registroEventfimaste_send_now(string eventType, string payloadJson)
{
  string id = REFEC_MakeEventId();
  datetime ts = TimeCurrent();
  string body = "{\"event_id\":\"" + id + "\",\"event\":\"" + eventType + "\",\"payload\":" + payloadJson + ",\"timestamp\":" + IntegerToString((long)ts) + "}";
  string signature = REFEC_HmacSha256(REFEC_secret_key, body);
  string headers = "Content-Type: application/json\r\nX-Signature: " + signature + "\r\n";
  char data[];
  StringToCharArray(body, data, 0, StringLen(body));
  char result[];
  string result_headers;
  int res = WebRequest("POST", REFEC_gateway_url, headers, REFEC_timeout_ms, data, result, result_headers);
  if(res >=200 && res <300) return true;
  return false;
}

// ---------- exemplos de uso (comente/descomente no EA) ----------
/*
Exemplo de integração no EA:

// no topo do EA
#include <event_client_registroEventfimaste.mqh>

// OnInit()
int OnInit()
{
  // inicializar (não coloque secret em repo)
  registroEventfimaste_init(InpServerUrl, "SEU_SECRET_GATEWAY", 8000);
  // configurar timer para flush a cada 10 segundos
  EventSetTimer(10);
  return(INIT_SUCCEEDED);
}

// OnTimer()
void OnTimer()
{
  // envia pendentes - operação não crítica
  registroEventfimaste_flush();
}

// Em qualquer ponto onde antes chamava RegistrarEventoNotificacaoApp, substitua/encapsule:
void ExemploGerarEvento()
{
  string payload = "{\"symbol\":\"EURUSD\",\"msg\":\"Teste\",\"login\":\"" + ObterContaMt5Login() + "\"}";
  // enfileira para envio assíncrono
  registroEventfimaste("notificacao_mql5", payload);
}

// OnDeinit()
void OnDeinit(const int reason)
{
  EventKillTimer();
  // opcional: tentar enviar pendentes finais
  registroEventfimaste_flush();
}
*/

// ---------- fim do módulo ----------
