//+------------------------------------------------------------------+
//|                                                      ProjectName |
//|                                      Copyright 2020, CompanyName |
//|                                       http://www.companyname.net |
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//| EA FIMASTER                                                      |
//|                                                                  |
//| Sistema avançado de negociação algorítmica baseado na análise    |
//| estrutural do mercado através da construção dinâmica de canais,  |
//| identificação de expansões de preço, suportes, resistências e    |
//| rompimentos operacionais.                                        |
//|                                                                  |
//| O EA organiza continuamente os preços em ciclos estruturados,    |
//| monitorizando a formação de novos ranges, ajustando canais e     |
//| validando  condicoes de mercado antes de autorizar qualquer       |
//| execução.                                                        |
//|                                                                  |
//| A estratégia opera através de uma máquina de estados composta    |
//| por três módulos principais:                                     |
//|                                                                  |
//| 1. Organização de Preços                                         |
//|    Responsável pela criação, validação e distribuição das        |
//|    estruturas de mercado utilizadas pelo sistema.                |
//|                                                                  |
//| 2. Ciclo Operacional do Canal                                    |
//|    Responsável pelo acompanhamento completo do comportamento      |
//|    do preço após a identificação de rompimentos válidos.         |
//|                                                                  |
//| 3. Motor de Execução                                              |
//|    Responsável pela abertura, gestão, modificação e encerramento |
//|    das posições de compra e venda.                               |
//|                                                                  |
//| Principais Funcionalidades:                                      |
//|                                                                  |
//| • Construção automática de canais operacionais.                  |
//| • Identificação de expansões de mercado.                         |
//| • Análise de suporte e resistência.                              |
//| • Deteção de rompimentos compradores e vendedores.               |
//| • Gestão automática de posições.                                 |
//| • Proteção por Break Even.                                       |
//| • Gestão diária e semanal de risco.                              |
//| • Operação manual ou totalmente automática.                      |
//| • Sistema de notificações por Email e Push.                      |
//| • Relatórios inteligentes de estados e execução.                 |
//| • Monitorização contínua da estrutura do mercado.                |
//|                                                                  |
//| O objetivo do FIMASTER é transformar a leitura estrutural do     |
//| mercado num processo disciplinado, consistente e automatizado,   |
//| reduzindo a influência emocional e aumentando a eficiência da    |
//| tomada de decisão operacional.                                   |
//|                                                                  |
//| Desenvolvido por: Jossias Macucul                                |
//| Versão: 1.0                                                      |
//+------------------------------------------------------------------+
// ===============================================================
// FiMaster Expert Advisor - Documentação do Sistema
// ===============================================================
//
// Este Expert Advisor foi desenvolvido para automação de trading
// no MetaTrader 5, com foco em disciplina, gestão de risco e
// execução objetiva de estratégias baseadas em regras.
//
// ===============================================================
// 🔧 ESTRUTURA PRINCIPAL DO SISTEMA
// ===============================================================
//
// 1. OnInit()
// ---------------------------------------------------------------
// - Inicializa o sistema
// - Valida parâmetros do usuário
// - Define variáveis globais
// - Prepara buffers e estados iniciais
// - Ativa proteções de segurança do EA
//
// ---------------------------------------------------------------
//
// 2. OnTick()
// ---------------------------------------------------------------
// - Motor principal do EA
// - Executa a cada novo tick do mercado
// - Verifica condições de entrada
// - Valida filtros de mercado
// - Evita operações duplicadas
// - Chama funções de sinal e execução
//
// ---------------------------------------------------------------
//
// 3. GerarSinal()
// ---------------------------------------------------------------
// - Analisa o mercado com base na estratégia definida
// - Detecta condições de compra ou venda
// - Confirma alinhamento de indicadores
// - Retorna sinal válido ou nulo
//
// ---------------------------------------------------------------
//
// 4. ExecutarCompra()
// ---------------------------------------------------------------
// - Abre posição de compra no mercado
// - Calcula lote baseado no risco definido
// - Define Stop Loss e Take Profit automaticamente
// - Registra operação no sistema de logs
//
// ---------------------------------------------------------------
//
// 5. ExecutarVenda()
// ---------------------------------------------------------------
// - Abre posição de venda no mercado
// - Aplica gestão de risco idêntica ao módulo de compra
// - Garante consistência de execução
// - Registra operação no sistema
//
// ---------------------------------------------------------------
//
// 6. GerenciamentoDeRisco()
// ---------------------------------------------------------------
// - Calcula tamanho do lote com base no saldo
// - Limita perda máxima por operação
// - Protege capital contra exposição excessiva
// - Controla drawdown operacional
//
// ---------------------------------------------------------------
//
// 7. FiltroDeHorario()
// ---------------------------------------------------------------
// - Permite operações apenas em horários definidos
// - Evita períodos de baixa liquidez
// - Bloqueia operações em notícias (se ativado)
// - Melhora qualidade dos sinais
//
// ---------------------------------------------------------------
//
// 8. AntiReentrada()
// ---------------------------------------------------------------
// - Evita múltiplas entradas no mesmo movimento
// - Bloqueia sinais repetidos consecutivos
// - Protege contra overtrading
//
// ---------------------------------------------------------------
//
// 9. ControleDeSessao()
// ---------------------------------------------------------------
// - Identifica sessões do mercado (Londres, NY, Ásia)
// - Ajusta comportamento do EA conforme volatilidade
// - Otimiza entradas por contexto de mercado
//
// ---------------------------------------------------------------
//
// 10. RegistroDeOperacoes()
// ---------------------------------------------------------------
// - Salva todas as operações executadas
// - Permite auditoria da estratégia
// - Facilita análise no diário de trading
//
// ---------------------------------------------------------------
//
// ===============================================================
// 🧠 MANOBRAS INTELIGENTES DO SISTEMA
// ===============================================================
//
// - Execução apenas quando há confirmação de sinal
// - Bloqueio de operações em mercado lateral (se configurado)
// - Proteção contra execução em excesso (anti-overtrade)
// - Ajuste dinâmico de risco por volatilidade
// - Filtro de qualidade de entrada antes de operar
// - Evita operar em condições emocionais do mercado
//
// ===============================================================
// ⚠️ SEGURANÇA E RESTRIÇÕES
// ===============================================================
//
// - EA pode ser limitado por conta ou ID
// - Sistema pode bloquear execução fora de condições válidas
// - Proteção contra duplicação de ordens
// - Controle para evitar perdas excessivas
//
// ===============================================================
// © FiMaster Expert Advisor
// ===============================================================

#property link "https://bit.ly/4jJQJsl"

#property copyright "Criado por: jossias macucul"
#property version "12.3"
#property description "🅰Permitir função WebRequest. (Obrigatório)\nhttps://api.github.com\nhttps://raw.githubusercontent.com\n"

#property description "EA FIMASTER"
#property description "Tecnologia avancada de automacao para MetaTrader 5."
#property description "Desenvolvido para executar operacoes com precisao."
#property description "• Construção automática de canais operacionais"
#property description "• Identificação de expansões de preço"
#property description "• Análise dinâmica de suporte e resistência"
#property description "• Deteção de rompimentos compradores e vendedores"
#property description "• Gestão automática de posições"
#property description "• Proteção automática"
#property description "• Relatórios inteligente por Email e Push"
#property description "© Jossias Macucul"

//+------------------------------------------------------------------+
//| Expert initialization function |
//+------------------------------------------------------------------
#include <trade\trade.mqh>
CTrade trade;
#include <Indicators\Indicator.mqh>
#define SESSION_INDEX 0
#property strict

#include <JAson.mqh>
//+------------------------------------------------------------------+
//| Robô TEMA 9 x TEMA 21 - Compra na cruzamento para cima e venda  |
//+------------------------------------------------------------------+
#define PAINEL_STATUS_NOME "Fimaster_Status_Panel"

int FastPeriod = 9;
int SlowPeriod = 21;
#property indicator_chart_window
#property indicator_buffers 2

color CorTEMA9  = clrBlue;
color CorTEMA21 = clrRed;

int handleTEMAfast;
int handleTEMAslow;
double temaFastBuffer[3];
double   temaSlowBuffer[3];
ulong BilheteDeVenda = 0; // Inicializado com 0 para indicar que não há ordem de venda aberta
ulong BilheteDeCompra = 0;// Inicializado com 0 para indicar que não há ordem de compra aberta
string ultimoPainelTexto = "";

enum tendencia
{  TENDENCIA_DE_ALTA, TENDENCIA_DE_BAIXA };

enum Estrategia
{  FIMATHE, F_SURFADA };
enum AUTO_PERIODO
{  MANUAL, SESSOES, SEMANAL, DIARIO, HORAS_8, HORA_1 };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool IndicatorIsReady(int handle)
{
   double temp[1];
   return (CopyBuffer(handle, 0, 0, 1, temp) == 1 && temp[0] != 0.0);
}
//+----------------------------------------------------------------+
//|                                                                  |
//+-----------------------------------------------------------------

input string lJJ  ;                                    // ⬛⬛⬛⬛⬛⬛⬛[ AUTENTICAÇÃO ]⬛⬛⬛⬛⬛⬛⬛
//input string xFF ;                                   // DATA DE EXPIRAÇÃO: 3 MESES
input string SENHA;                                    // SENHA 🔒
input string  aYY;                                     // ⬛⬛⬛⬛⬛⬛⬛⬛⬛⬛⬛[ COR ]⬛⬛⬛⬛⬛⬛⬛⬛⬛⬛⬛
input color cor_de_canal ;                             // COR DE PRIMEIRO CANAL
input color cor_de_linhas ;                            // COR DE CANÁIS
input color corr_de_equador ;                          // COR DE EQUADOR
input string  sJJ ;                                    // ⬛⬛⬛⬛⬛⬛⬛⬛⬛[ TENDÊNCIA ]⬛⬛⬛⬛⬛⬛⬛⬛⬛
input bool  LINHAS_DE_EQUADOR = false;                 // LINHAS_DE_EQUADOR
input  tendencia TENDENCIA ;                           // TENDENCIA
input double M_equador_alta ;                          // LINHA DE EQUADOR MAXIMA
input double M_equador_baixa;                          // LINHA DE EQUADOR MINIMA
input string xxx ;                                     // ⬛⬛⬛⬛⬛⬛⬛⬛[ ESTRATÉGIA ]⬛⬛⬛⬛⬛⬛⬛⬛⬛
input bool TEMA = false;                               // TRI_EXP_MOVING AVERAGE 9 / 21
input Estrategia ESTRATEGIA ;                          // ESTRATÉGIA
input bool virada_de_jogo = false;                     // VIRADA_DE_JOGO
input double Nives = 1;                                // QUANTOS NIVES
input bool Costurar = true;                            // COSTURADA
input ENUM_TIMEFRAMES PeriodoOperacional = PERIOD_M15 ;// PERIODO OPERACIONAL
input double lot = 0.01;                               // LOTE
string input dS ;                                      // ⬛⬛⬛⬛⬛⬛⬛⬛⬛[ AUTOMATICO ]⬛⬛⬛⬛⬛⬛⬛⬛
input bool EA_AUTO = false;                            // AUTO_TRADING
input AUTO_PERIODO  PERIODO_AUTO ;                     // AUTO_PERIODO
input bool AUTO_SURFADA = false;                       // PCM
input bool SESSAO_ASIA_TOQUIO = false;                 // SESSÃO_ASIA_TOQUIO
input bool  SESSAO_LONDRES = false;                    // SESSÃO_LONDRES
input bool  SESSAO_NOVA_YORQUI = false;                // SESSÃO_NOVA_YORQUI
input int EXPANSAO_MINIMA = 0;                         // AUTO EXPANSÃO MINIMA
input int EXPANSAO_MAXIMA = 0 ;                        // AUTO EXPANSÃO MAXIMA
input string  dSS ;                                    // ⬛⬛⬛⬛⬛⬛⬛[ POSIC: DE ORDEM ]⬛⬛⬛⬛⬛⬛⬛
input double compra = 0 ;                              // PREÇO DE COMPRA
input double venda = 0;                                // PREÇO DE VENDA
input double santo = 0 ;                               // PTS: PARA FORA DA CAIXA & SANTO
input int dedo = 0;                                    // PTS: PARA ABERTURA DE ORDEM
input bool posicaoTake = false ;                       // POSICIONAMENTO_DE_TAKE
input double buy_take = 0.0;                           // TAKE_PARA_COMPRA
input double sell_take = 0.0;                          // TAKE_PARA_VENDA
input string  fDD ;                                    // ⬛⬛⬛⬛⬛⬛[ GERENC: DE CAPITAL ]⬛⬛⬛⬛⬛⬛
input double SALDO ;                                   // SALDO_DEMO
input bool GERENCIAMENTO_DE_RISCO_DIARIO = true;       // GERENCIAMENTO_DE_RISCO_DIARIO
input double porcentos = 1.0 ;                         // LIMITE DE PERDA DIáRIA EM %
input double poercentosg = 1.0 ;                       // LIMITE DE GANHO DIáRIO EM %
input bool GERENCIAMENTO_DE_RISCO_SEMANAL = false;     // GERENCIAMENTO_DE_RISCO_SEMANAL
input double PORCENTOO = 2.0 ;                         // LIMITE DE PERDA SEMANAL EM %
input double PORCENTOSS = 2.0 ;                        // LIMITE DE GANHO SEMANAL EM %
input string  gG ;                                     // ⬛⬛⬛⬛⬛[ PARÂM: OPERACIONAIS ]⬛⬛⬛⬛⬛
input bool GMAIL = true;                               // E-MAIL
input bool notific = true ;                            // NOTIFICAÇÃO
input bool ativar_ou_desativar_venda = true;           // ATIVAR/DESA: ORDENS DE VENDA
input bool ativar_ou_desativar_compra = true;          // ATIVAR/DESA: ORDENS DE COMPRA
input bool Modificar_Sl_Para_OxO = true;               // MODIF: SL PARA 0.0 / SUPOR & RESIS
input bool condicao_De_rompimento_c = true;            // COND: DE ROMPIMENTO PARA COMPRA
input bool condicao_De_rompimento_v = true;            // COND: DE ROMPIMENTO PARA VENDA
input string  hFF ;                                    // ⬛⬛⬛⬛⬛⬛⬛⬛⬛[ RESULTDO ]⬛⬛⬛⬛⬛⬛⬛⬛⬛
input string mony  = " Meticais ";                     // MOEDA
input double CAMBIO = 64;                              // CAMBIO USD
bool Costura = true;
double fora ;                    // variavel para santo
double pc;                       // preço de compra pra linha
double pv;                       // preço de venda pra linha
double PrecoDeCompra;            // preço de compra pra ordem
double PrecoDeVenda;             // preço de venda pra ordem
double var1;                     // possível preço de compra
double var2;                     // possível preço de venda
double Pontos;                   // pontos para linhas
double divisao;                  // divisão
double Buytake;                  // take de compra
double Buystop ;                 // estop de compra
double Selltake ;                // teke de venda
double Sellestop ;               //estop de venda
double SellModif ;               // modificar estop sell
double Buymodif;                 // modificar estop buy
double Buysubsicul;              // subsicol de compra
double Sellsubsicul ;            // subsicol de venda
double preco_de_abertura_de_venda ;    // preço de abertura de veda
double preco_de_abertura_de_compra ;   // preço de abertura de compra
double nivelzerobuy;             //preco sem perda para compra
double nivelzerosell ;           // preço sem perda para venda
double nivelstoplos_sell;        // preço de stop loss de venda
double nivelstoplos_buy;         // preco de stop loss de compra
double linhasell;                // criar linha de venda para linha
double linhabuy;                 // criar linha de compra para linha
double linhasubsiculv;           // criar linha de subsicol de venda
double linhasubsiculc;           //criar linha de subsicol de compra
double pontosf;                  // pontos para ordem
double takbuy ;                  // nivel de take buy
double taksell;                  // nivel de take sell
double tamanho_DA_vela_para_compra = 0.0; // tamanho de vela de compra
double tamanho_DA_vela_para_venda = 0.0;  //  tamano de  velha de venda
double equador_semanal_baixa;
double equador_semanal_alta;
double expansao;
double meio;
double equador_diario_centro;
double de;
double resulporcentoss;
double resulporcentos;
double calcol;
double calcll;
string mostraw ;
int MagicNumber;
string mostra ;
double dedoc;
double dedov;
//+------------------------------------------------------------------+
//| |
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+

// Variáveis globais dos parâmetros operacionais
// 1. Conexão e Licença
string       g_param_senha         = SENHA;

// 2. Painel & Moeda / Câmbio
double       g_param_cambio        = CAMBIO;
string       g_param_moeda         = mony;

// 3. Canais de Tendência
tendencia    g_param_tendencia     = TENDENCIA;
bool         g_param_linhas_eq     = LINHAS_DE_EQUADOR;
double       g_param_equador_alta  = M_equador_alta;
double       g_param_equador_baixa = M_equador_baixa;

// 4. Estratégia Principal
Estrategia   g_param_estrategia    = ESTRATEGIA;
string       g_param_timeframe     = "PERIOD_M15";
double       g_param_lote          = lot;
double       g_param_niveis        = Nives;
bool         g_param_costurar      = Costurar;
bool         g_param_virada_jogo   = virada_de_jogo;

// 5. Posicionamento de Ordem
double       g_param_compra        = compra;
double       g_param_venda         = venda;
double       g_param_santo         = santo;
double       g_param_dedo          = dedo;
bool         g_param_posicao_take  = posicaoTake;
double       g_param_buy_take      = buy_take;
double       g_param_sell_take     = sell_take;

// 6. Gestão de Capital e Risco
double       g_param_saldo         = SALDO;
bool         g_param_gerenc_diario = GERENCIAMENTO_DE_RISCO_DIARIO;
double       g_param_porcentos     = porcentos;
double       g_param_porcentosg    = poercentosg;
bool         g_param_gerenc_semanal = GERENCIAMENTO_DE_RISCO_SEMANAL;
double       g_param_porcentoo     = PORCENTOO;
double       g_param_porcentoss    = PORCENTOSS;

// 7. Automação e Sessões
bool         g_param_ea_auto       = EA_AUTO;
AUTO_PERIODO g_param_auto_periodo  = PERIODO_AUTO;
bool         g_param_auto_surfada  = AUTO_SURFADA;
bool         g_param_sessao_asia   = SESSAO_ASIA_TOQUIO;
bool         g_param_sessao_londres = SESSAO_LONDRES;
bool         g_param_sessao_ny     = SESSAO_NOVA_YORQUI;
int          g_param_expansao_min  = EXPANSAO_MINIMA;
int          g_param_expansao_max  = EXPANSAO_MAXIMA;

// 8. Resultados e Notificações (Parâmetros Operacionais)
bool         g_param_gmail         = GMAIL;
bool         g_param_notific       = notific;
bool         g_param_ativar_venda  = ativar_ou_desativar_venda;
bool         g_param_ativar_compra = ativar_ou_desativar_compra;
bool         g_param_modify_sl     = Modificar_Sl_Para_OxO;
bool         g_param_rompimento_c  = condicao_De_rompimento_c;
bool         g_param_rompimento_v  = condicao_De_rompimento_v;


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
//---

double precosArray [];                    // armazenamentos  de preços de linha
double listaequador [];                   // armazenamentos  de preços de linha de equador
bool controlbuy = false;                  // control de ordem de compra
bool controlsell = false;                 // control de ordem de venda
bool controlbuymdf = false;               // control de modificaçao de ordem de compra
bool controlsellmdf = false;              // control de modificaçao de ordem de venda
bool segundo_control_de_taksell = false;
bool segundo_control_de_takbuy = false ;
bool control_de_venda = false;            // segundo control para venda  na surfada
bool control_de_compra = false;           // segundo control para compra  na surfada
bool contol_de_gerenciamento = true;      // contol_de_gerenciamento
bool contol_de_gerenciamento_semanal = true;
bool comando_venda = true;
bool comando_compra = true;
bool inib = true;
bool tmp_placar = true;                 //tmp_placar = true exibe no //Comment o resultado das negociações do dia
bool tmp_placarx = true ;               //tmp_placarx = true exibe no //Comment o resultado das negciações do dia
bool tmp_placarw = true ;               //tmp_placarw = true exibe no //Comment o resultado das negociações do dia
bool tmp_placarfw = true ;              //tmp_placarfw = true exibe no //Comment o resultado das negociações do dia
bool tmp_placarfl = true ;              //tmp_placarfl = true exibe no //Comment o resultado das negociações do dia
bool permitir = true;
bool negar = true;                      //negar = true exibe no //Comment o resultado das negociações do dia
bool placar = true;                     //placar = true exibe no //Comment o resultado das negociações do dia
bool placarx = true ;                   //placarx = true exibe no //Comment o resultado das negociações do dia
bool placarw = true ;                   //placarw = true exibe no //Comment o resultado das negociações do dia
bool placarfw = true ;                  //placarfw = true exibe no //Comment o resultado das negociações do dia
bool placarfl = true ;                  //placarfl = true exibe no //Comment o resultado das negociações do dia
bool mostrarobjetos = true ;            // MOSTRAR OBJETOS
datetime lastHourProcessed = 0;         // HORA PROCESSADO
double closeprice;                      // FEIXAMENTO DE VELA

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+

double RANGE;       // EXPANSÃO EM PONTOS EA
double div;           // DIVISAO DE EXPANSÃO EA
double compraa;         // PRIMERO PREÇO DE COMPRA EA
double vendaa;        // PRIMERO PREÇO DE VENDA EA
double buy;                         // ULTIMO  PREÇO DE COMPRA EA
double sell;                        // ULTIMO PREÇO DE VENDA EA
double pontos ;                     // PONTOS EA
datetime currentHour;               // HORA CORRENTE EA
datetime future ;                   // HORA FUTURO PARA CRIAR LINHA EA
double sasa ;                       // PONTOS PARA SANTO EA
double santinho;                    // CONFIGURAÇÃO  DE SANTO EA
int  ddd;                           // DIGITOS EA
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+

// Variáveis globais para controle de bloqueios
long failedAttempts = 0;           // CONTADOR DE TENTATIVAS FALHAS
int maxAttempts = 5;               // MáXIMO DE TENTATIVAS PERMITIDAS
datetime lockUntil = 0;            // TIMESTAMP INDICANDO QUANDO O BLOQUEIO EXPIRA (0 = NãO BLOQUEADO)
long userAccountNumber ;           // NUMERO DA CONTA
long user;                         // USUARIO PARA IDENTIFICAÇÃO DE TENTATIVAS
string filename = "bloqueio_data.txt";// CAMINHO PARA O ARQUIVO DE PERSISTêNCIA
string hashRecalculado;            // SENHA TRASFORMDA
int interar = 1000 ;              // INTERAÇOES
string pepper = "if(ctrl + zxcv = but) return true ;";
string salte ;                     // RECEBE O NUMERO DA CONTA PARA GERAR SENHA
string inputHash;                  // RECEB CODIFICAÇÃO COLOCADO
string hashString;                 // RECEBE A CODIFICAÇÃO DA SENHA
datetime current_time;             // HORA DO MEU COMPUTADOR
datetime current;                  //HORA DO MEU COMPUTADOR
bool showFloatingProfit = true;    // CONTROLA EXIBIçãO DO LUCRO
double alertThreshold = 100.0;     // LIMITE PARA ALERTA DE LUCRO
bool alertTriggered = false;       // EVITA MúLTIPLOS ALERTAS
string logFileName = "Lucro_Historico.csv"; // NOME DO ARQUIVO DE HISTóRICO
int decimal;                       // RECEBE CASAS DECIMAS DO PREÇO
double contrat;                    //TAMANHO DO CONTRATO DE NEGOCIAçãO
double pontt;                      // VALOR DE UM PONTO DO ATIVO
string AccountNumber ;

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+

string motivationalMessages[] =
{
   "A cada decisão disciplinada, eu construo minha consistência.",
   "O dinheiro arriscado já não me pertence, só me resta seguir o plano.",
   "Ganhar ou perder faz parte. O que importa é a disciplina ao longo do tempo.",
   "Não controlo o mercado, mas controlo minhas reações a ele.",
   "Se aceitei o risco antes da entrada, não há motivo para medo depois dela.",
   "Meu único trabalho agora é confiar na decisão que tomei.",
   "A consistência não vem da emoção, vem da execução disciplinada.",
   "Uma única operação não define meu sucesso, mas minha disciplina sim.",
   "Se eu seguir minha estratégia, o resultado será apenas uma consequência.",
   "Cada vez que respeito meu plano, fico mais próximo da consistência.",
   "Minha estratégia foi testada, minha ansiedade não precisa ser.",
   "Observar o gráfico a cada segundo não muda o resultado, só muda meu emocional.",
   "Uma boa operação se desenvolve sozinha, sem a minha interferência.",
   "Se configurei tudo certo, agora é hora de deixar o mercado trabalhar.",
   "O segredo do trader vencedor é saber quando agir e quando esperar.",
   "A paciência paga mais do que a pressa no mercado.",
   "Meu estado mental é mais valioso que qualquer trade.",
   "Um trader calmo vê oportunidades que um trader ansioso jamais enxergaria.",
   "Respirar fundo me fortalece mais do que qualquer setup.",
   "A paz interna me torna mais forte do que qualquer oscilação no gráfico.",
   "O mercado sempre vai tentar me testar. Minha calma é minha resposta.",
   "Cada vez que sigo meu plano, eu venço, independentemente do resultado.",
   "O verdadeiro sucesso é a disciplina, e não um único trade.",
   "Minha evolução está no meu controle emocional, não na sorte do mercado.",
   "Hoje, escolho me orgulhar da minha disciplina e não apenas do meu lucro.",
   "Respeitar meu plano é o maior investimento que posso fazer em mim mesmo."
};
string emotionalControlSecrets[] =
{

   "Eu não preciso prever o mercado, só preciso me controlar.",
   "respeita  suas decisões.",
   "Sua emoção não é a verdade, apenas uma reação do cérebro.",
   "O controle está na resposta, não no impulso.",
   "O mercado não é seu inimigo, sua impaciência sim.",
   "Emoção mal controlada é um loop sem fim.",
   "O jogo é de longo prazo, não de um dia só.",
   "Se você quer controle, crie rotinas.",
   "O corpo influencia a mente. Cuide de sua saúde.",
   "A consistência está no controle, não no lucro.",
   "Respire fundo e espere antes de agir.",
   "Cada decisão disciplinada constrói sua consistência.",
   "A ansiedade é apenas um teste da sua paciência.",
   "A calma é uma habilidade treinável, pratique diariamente.",
   "O mercado sempre testará seu emocional, esteja preparado.",
   "Aceitar a incerteza é parte do jogo, não um obstáculo.",
   "Disciplina é escolher entre o que você quer agora e o que quer mais.",
   "Focar no processo é mais importante que focar no resultado.",
   "Se sentir emoção forte, faça uma pausa antes de agir.",
   "Perder faz parte, mas aprender com a perda faz você crescer.",
   "A paciência sempre será mais lucrativa do que a pressa.",
   "O medo e a ganância são seus maiores adversários, não o mercado.",
   "Ter um plano é metade do caminho para o sucesso, segui-lo é a outra metade.",
   "Quando estiver tentado a sair do plano, releia sua estratégia.",
   "Sua confiança deve vir da sua disciplina, não do resultado imediato.",
   "O tempo no mercado é mais importante do que acertar todas as operações.",
   "A emoção exagerada nublará seu julgamento, mantenha-se racional."
};
// LogMessage("Erro: Nenhum modo de preenchimento disponível.");
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int SorteiaNumero()
{
   return MathRand() % 26 + 1;
}
string motiva ;           // RECEBE MENSAGENS D MOTIVAÇÃO
double cv ;               // RECEBE O VALOR DE STOP LOSS
double cb ;               // RECEBE O VOLOR DE TAKE PROFT
double Alvo;              // RECEBE O VOLOR DE TAKE PROFT
double Protecao;          // RECEBE O VALOR DE STOP LOSS
double lucro;             // RECEBE O VALOR DE PORCENTAGEM DE GANHOS
double perdas;            // RECEBE O VALOR DE PORCENTAGEM DE PERDAS

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double precocurrentecB ;     // PREçO CORRENTE DE BEAT
double precocurrentevA;      // PREçO CORRENTE DE ASK
double precodiferentev ;     // PONTOS DE VELA PARA ENTRADA  DE VENDA
double precodiferentec ;     // PONTOS DE VELA PARA ENTRADA DE COMPRA
string symboll;              // simbolo
datetime  currentTime ;      // RETORNA O VALOR DO TEMPO DE ABERTURA DA BARRA (INDICADO PELO PARâMETRO SHIFT) DO GRáFICO CORRESPONDENTE.
int totalPositions  ;        // TOTAL DE POSIçOES
int bingala_de_alta ;        // BENGALA DE ALTA
int bingala_de_baixa ;       // BENGALA DE ALTA
int espassao;                // ESPANÇAO DE CANAL EM PONTOS
double espas;
bool condicao2 ;             // condiçao para rompimento da vela de compra
bool condicao ;              // condiçao para rompimento da vela de compr
int startIndex;       // RECEBE O valor INDEX  REFERIDO
datetime semm;       // RECEBE O INDEX DE PRIMEIRA VELA DE DATETIME DA SEMANA
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double suub ;            // CRIA UMA LINHA DE SUBSICOL SO NO INICIO
double canaisv;             // QUANTOS CANAS FORAM PASSADO POR BINGALA DE VENDA
double canais ;             // QUANTOS CANAS FORAM PASSADO POR BINGALA DE COMPRA
bool reg = true;         // CONTROL DE CANAL SE FOR MAIOR DE EXPANSÃO MAXIMA DIVIDE DO MEIO UMA VEZ
double pptt;             // RECEBE O VALORE DA EXPANSÃO QUE FOI DIVIDIDO POR 4 POR SER MAIOR QUE EXPANSÃO MAXIMA
bool ger = true;         // CONTROL DE CANAL SE FOR MAIOR DE EXPANSÃO MAXIMA DIVIDO POR 4 VEZ
string verifica  ;       // RETORNA A MENSAGEM DE ERRO NA ENTRADA DOS PARAMETOS
bool caneta = true;      // CONTROL DE CRIAÇÃO DE LINHAS SE O TEMPO FOR DIFERENTE
datetime tempoInicioCiclo = 0;

string JnomesLinhas[];
double JprecosArray[];
bool Jativa[];
string notifica ;
bool JcicloAtivo = false;
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//| Parâmetros de Entrada do Robô (Inputs)                          |
//+------------------------------------------------------------------+ group "=== CONFIGURAÇÃO DO SERVIDOR ==="
enum ENUM_SYNC_MODE
{
   MODE_FASTAPI = 0,   // FastAPI / Servidor Web Próprio
   MODE_FIREBASE = 1,  // Firebase Realtime Database (REST API)
   MODE_GITHUB = 2     // GitHub Repository (Raw Files)
};

ENUM_SYNC_MODE InpSyncMode = MODE_FIREBASE; // Modo de Sincronização
string InpServerUrl = "https://fimaster-sms-gateway-default-rtdb.firebaseio.com"; // URL do Servidor / Firebase / Base GitHub
string InpGitHubRepo = "Macucul/fimaster"; // GitHub: Dono/Repositorio (Ex: admin/my-repo)
string InpGitHubBranch = "contents"; // GitHub: Nome da Branch (Ex: main ou master)
string InpGitHubToken = "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"; // GitHub: Token de Acesso Pessoal (Opcional se repositório público)
// ====================================================================
// ⚙️ VARIÁVEIS GLOBAIS DE ESTADO E CONFIGURAÇÃO
// ====================================================================
bool enviar_http = true;    // Ativar envio de notificações via HTTP POST (Firebase)?
string server_url = "https://fimaster-sms-gateway-default-rtdb.firebaseio.com"; // URL Base HTTP do Firebase Realtime DB
string user_id = "";        // ID do Usuário no App Firebase (ex: USR00001)
string conta_id = "";       // ID da Conta / Sub-Usuário no Firebase (opcional, ex: usuario_1 ou 887766)
string auth_key = "";       // Chave de Autenticação Firebase (opcional)

string InpEaPassword = g_param_senha ; // Senha de Ativação do EA

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool g_ea_ativo = true;           // Estado de execução do EA (Ativado = true, Desativado = false)
datetime g_last_config_check = 0; // Timestamp da última verificação de parâmetros do App

//+------------------------------------------------------------------+
//| Função de Inicialização do Expert Advisor                       |
//+------------------------------------------------------------------+


//+------------------------------------------------------------------+
//| Função principal que executa o fluxo sequencial de login         |
//+------------------------------------------------------------------+
bool ExecutarAutenticacaoMql5(string mt5Id, string passwordSent)
{
   Print("🔍 [PASSO 1] Buscando conta MT5 '", mt5Id, "' no índice remoto...");
   string pathIndex = "dados/indices/mt5.json";
   string indexJson = BuscarConteudoRemoto(pathIndex);
   if(StringLen(indexJson) == 0)
      {
         Print("❌ [FALHA] Não foi possível obter o índice de contas MT5 do servidor.");
         return false;
      }
// Extrai o ID do utilizador correspondente ao mt5Id a partir do JSON do índice
   string userId = ExtrairValorJson(indexJson, mt5Id, "usuario");
   if(StringLen(userId) == 0)
      {
         Print("❌ [FALHA] Conta MT5 '", mt5Id, "' não encontrada no índice remoto.");
         return false;
      }
   Print("✅ [ÍNDICE] Conta MT5 localizada. Associada ao Utilizador ID: '", userId, "'");
   Print("🔍 [PASSO 2] Carregando dados cadastrais do utilizador remoto...");
   string pathUser = "dados/usuarios/" + userId + ".json";
   string userJson = BuscarConteudoRemoto(pathUser);
   if(StringLen(userJson) == 0)
      {
         Print("❌ [FALHA] Não foi possível ler o registro do utilizador '", userId, "' no servidor.");
         return false;
      }
// Extrai os campos de segurança: hash da senha e o sal (salt)
   string senhaHashCompleta = ExtrairValorJson(userJson, "", "senha_hash");
   string salt = ExtrairValorJson(userJson, "", "salt");
   string validadeLicenca = ExtrairValorJson(userJson, "", "validade");
   string statusLicenca = ExtrairValorJson(userJson, "", "status");
   if(StringLen(senhaHashCompleta) == 0)
      {
         Print("❌ [FALHA] Registro do utilizador está incompleto ou corrompido.");
         return false;
      }
// Extrai apenas a primeira parte do hash (antes de ":") caso venha no formato "hash:salt"
   string hashEsperado = senhaHashCompleta;
   int colonPos = StringFind(senhaHashCompleta, ":");
   if(colonPos >= 0)
      {
         hashEsperado = StringSubstr(senhaHashCompleta, 0, colonPos);
      }
// Se o sal do banco estiver vazio, tenta extrair a segunda parte do hash de senhaHash
   if(StringLen(salt) == 0 && colonPos >= 0)
      {
         salt = StringSubstr(senhaHashCompleta, colonPos + 1);
      }
   Print("📊 [DADOS] Validade da licença: ", validadeLicenca, " | Status: ", statusLicenca);
// Verifica se a licença expirou ou está inativa
   if(statusLicenca == "EXPIRADO" || statusLicenca == "INATIVO")
      {
         Print("❌ [BLOQUEADO] Licença com status inválido: '", statusLicenca, "'");
         return false;
      }
   Print("🔐 [PASSO 3] Calculando assinatura digital com SHA-256...");
// Realiza a criptografia com o salt igual ao gerado no Android (senha + salt)
   string hashGerado = CalcularHashSha256(passwordSent, salt);
   Print("ℹ️ [CONSOLA] Salt extraído: '", salt, "'");
   Print("🔑 [CONSOLA] Hash Gerado:   '", hashGerado, "'");
   Print("🔒 [CONSOLA] Hash Esperado: '", hashEsperado, "'");
   if(hashGerado == hashEsperado)
      {
         Print("✅ [CONEXÃO] Assinatura verificada! Acesso autorizado.");
         return true;
      }
   Print("❌ [FALHA] Senha de ativação incorreta para a conta MT5.");
   return false;
}

//+------------------------------------------------------------------+
//| Função para buscar dados remotos através de requisição HTTP      |
//+------------------------------------------------------------------+
string BuscarConteudoRemoto(string path)
{
   string url = "";
   string headers = "User-Agent: MetaTrader 5\r\n";
   char post[], result[];
   string result_headers;
   int timeout = 5000; // 5 segundos de timeout
// Constrói a URL final de acordo com o modo de sincronização selecionado
   if(InpSyncMode == MODE_FASTAPI)
      {
         url = InpServerUrl;
         // Remove barra final se houver
         if(StringSubstr(url, StringLen(url) - 1, 1) == "/")
            {
               url = StringSubstr(url, 0, StringLen(url) - 1);
            }
         url = url + "/" + path;
      }
   else if(InpSyncMode == MODE_FIREBASE)
      {
         url = InpServerUrl;
         if(StringSubstr(url, StringLen(url) - 1, 1) == "/")
            {
               url = StringSubstr(url, 0, StringLen(url) - 1);
            }
         // O Firebase Realtime Database expõe JSON diretamente adicionando .json no fim
         url = url + "/" + path;
      }
   else if(InpSyncMode == MODE_GITHUB)
      {
         url = "https://api.github.com/repos/" + InpGitHubRepo + "/" + InpGitHubBranch + "/" + path;
         if(StringLen(InpGitHubToken) > 0)
            {
               headers += "Authorization: token " + InpGitHubToken + "\r\n"
                          "Accept: application/vnd.github.v3+json\r\n"
                          "User-Agent: MetaTrader\r\n";
            }
      }
   ResetLastError();
// Executa o WebRequest do MetaTrader 5
// ATENÇÃO: Adicione a URL base no menu do MT5: Ferramentas -> Opções -> Experts -> Permitir WebRequest para as URLs listadas
   int res = WebRequest("GET", url, headers, timeout, post, result, result_headers);
   if(res == -1)
      {
         Print("❌ [ERRO HTTP] Falha no WebRequest para a URL: ", url);
         Print("👉 Verifique se adicionou esta URL em: Ferramentas -> Opções -> Experts -> Permitir WebRequest");
         Print("Erro código do terminal: ", GetLastError());
         return "";
      }
   if(res >= 200 && res < 300)
      {
         // Transforma o array de bytes em string UTF-8
         string responseStr = CharArrayToString(result, 0, WHOLE_ARRAY, CP_UTF8);
         return responseStr;
      }
   Print("❌ [ERRO HTTP] Código de resposta inválido: ", res, " para a URL: ", url);
   return "";
}

//+------------------------------------------------------------------+
//| Função auxiliar para extrair valores de chaves JSON simples      |
//+------------------------------------------------------------------+
string ExtrairValorJson(string json, string chavePai, string chaveDesejada)
{
   string jsonTratado = json;
// Se o índice for aninhado (Ex: mt5.json onde a chave pai é o número da conta)
   if(StringLen(chavePai) > 0)
      {
         int posPai = StringFind(json, "\"" + chavePai + "\"");
         if(posPai < 0)
            {
               return "";
            }
         // Delimita a busca apenas para o bloco da chave pai
         int blocoInicio = StringFind(json, "{", posPai);
         int blocoFim = StringFind(json, "}", blocoInicio);
         if(blocoInicio >= 0 && blocoFim > blocoInicio)
            {
               jsonTratado = StringSubstr(json, blocoInicio, blocoFim - blocoInicio + 1);
            }
      }
// Busca a chave desejada no formato: "chave":"valor" ou "chave":valor ou "chave" : "valor"
   string busca = "\"" + chaveDesejada + "\"";
   int posChave = StringFind(jsonTratado, busca);
   if(posChave < 0)
      {
         return "";
      }
   int posDoisPontos = StringFind(jsonTratado, ":", posChave + StringLen(busca));
   if(posDoisPontos < 0)
      {
         return "";
      }
// Encontra o valor (seja ele string entre aspas ou numérico/booleano)
   int posInicioValor = posDoisPontos + 1;
   while(posInicioValor < StringLen(jsonTratado))
      {
         string charAt = StringSubstr(jsonTratado, posInicioValor, 1);
         if(charAt != " " && charAt != "\t" && charAt != "\r" && charAt != "\n")
            {
               break;
            }
         posInicioValor++;
      }
   string primeiroChar = StringSubstr(jsonTratado, posInicioValor, 1);
   string resultado = "";
   if(primeiroChar == "\"")
      {
         // É uma string entre aspas duplas, lê até fechar aspas
         int posFimAspas = StringFind(jsonTratado, "\"", posInicioValor + 1);
         if(posFimAspas > posInicioValor)
            {
               resultado = StringSubstr(jsonTratado, posInicioValor + 1, posFimAspas - posInicioValor - 1);
            }
      }
   else
      {
         // É um valor numérico ou booleano, lê até uma vírgula ou fecho de chave ou quebra de linha
         int i = posInicioValor;
         while(i < StringLen(jsonTratado))
            {
               string charAt = StringSubstr(jsonTratado, i, 1);
               if(charAt == "," || charAt == "}" || charAt == "]" || charAt == "\r" || charAt == "\n")
                  {
                     break;
                  }
               resultado += charAt;
               i++;
            }
         resultado = StringTrim(resultado);
      }
   return resultado;
}

//+------------------------------------------------------------------+
//| Função que calcula o Hash SHA-256 equivalente ao Java/Kotlin      |
//+------------------------------------------------------------------+
string CalcularHashSha256(string password, string salt)
{
   string saltedInput = password + salt;
   uchar data[];
   uchar key[];
   uchar result[];
   StringToCharArray(saltedInput, data, 0, StringLen(saltedInput));
// Codifica o hash com algoritmo SHA-256 nativo do MetaTrader 5
   int res = CryptEncode(CRYPT_HASH_SHA256, data, key, result);
   if(res <= 0)
      {
         Print("❌ [ERRO] Falha ao codificar Hash SHA-256!");
         return "";
      }
// Converte os bytes em formato hexadecimal legível
   string hex = "";
   for(int i = 0; i < ArraySize(result); i++)
      {
         hex += StringFormat("%02x", result[i]);
      }
   return hex;
}

//+------------------------------------------------------------------+
//| Função Auxiliar para remover espaços adicionais                  |
//+------------------------------------------------------------------+
string StringTrim(string text)
{
   string t = text;
   while(StringLen(t) > 0 && (StringSubstr(t, 0, 1) == " " || StringSubstr(t, 0, 1) == "\t"))
      {
         t = StringSubstr(t, 1);
      }
   while(StringLen(t) > 0 && (StringSubstr(t, StringLen(t) - 1, 1) == " " || StringSubstr(t, StringLen(t) - 1, 1) == "\t"))
      {
         t = StringSubstr(t, 0, StringLen(t) - 1);
      }
   return t;
}

//+------------------------------------------------------------------+
//| Fim do Script                                                   |


//+------------------------------------------------------------------+
//| Função para enviar dados via HTTP (POST/PUT) (ex: Firebase ou Backend) |
//+------------------------------------------------------------------+
int EnviarRequisicaoHTTP(string metodo, string endpoint, string payload)
{
   if(!enviar_http)
      {
         return 0;
      }
   string headers = "Content-Type: application/json\r\n";
   char data[];
   char result[];
   string result_headers;
// Convert string payload to char array
   StringToCharArray(payload, data, 0, StringLen(payload));
// WebRequest requires enabling permissions in MT5 terminal.
// Go to: Tools -> Options -> Expert Advisors -> Allow WebRequest for listed URL.
   int res = WebRequest(metodo, endpoint, headers, 5000, data, result, result_headers);
   if(res == -1)
      {
         Print("❌ WebRequest Error: ", GetLastError());
         if(GetLastError() == 4014)
            {
               Print("⚠️ Erro 4014: URL não permitida nas configurações do MetaTrader. Por favor, adicione: ", endpoint, " em Ferramentas -> Opções -> Expert Advisors.");
            }
      }
   else
      {
         string responseStr = CharArrayToString(result);
         Print("🔹 Resposta do Servidor (Método: ", metodo, ", Status: ", res, "): ", responseStr);
      }
   return res;
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int EnviarPostHTTP(string endpoint, string payload)
{
   return EnviarRequisicaoHTTP("POST", endpoint, payload);
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int EnviarPutHTTP(string endpoint, string payload)
{
   return EnviarRequisicaoHTTP("PUT", endpoint, payload);
}

//+------------------------------------------------------------------+
string ObterContaMt5Login()
{
// Obtém o número da conta no MetaTrader 5
   long login = AccountInfoInteger(ACCOUNT_LOGIN);
// Converte o identificador numérico da conta MT5 em formato texto
   return IntegerToString(login);
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool BuyMarkt()
{
   MqlTradeRequest request = { };
   MqlTradeResult result = { };
   ZeroMemory(request);
   request.action = TRADE_ACTION_DEAL;
   request.volume = g_param_lote;
   request.symbol = Symbol();
   request.type = ORDER_TYPE_BUY;
   request.price = SymbolInfoDouble(Symbol(), SYMBOL_ASK);
   request.deviation = 10;
   request.magic = MagicNumber;
   request.type_time = ORDER_TIME_GTC;
// filling mode correto (bitmask)
   int filling = (int)SymbolInfoInteger(symboll, SYMBOL_FILLING_MODE);
   if((filling & SYMBOL_FILLING_FOK) != 0)
      {
         request.type_filling = ORDER_FILLING_FOK;
      }
   else if((filling & SYMBOL_FILLING_IOC) != 0)
      {
         request.type_filling = ORDER_FILLING_IOC;
      }
   else
      {
         request.type_filling = ORDER_FILLING_RETURN;
      }
   if(g_param_estrategia == F_SURFADA)
      {
         request.sl = Buystop - fora ;
         if(g_param_posicao_take)
            {
               if(g_param_buy_take  == 0.0) {}
               else
                  {
                     request.tp = g_param_buy_take ;
                  }
            }
      }
   if(g_param_estrategia == FIMATHE)
      {
         if(g_param_buy_take == 0.0)
            {
               request.sl = Buystop - fora ;
               if(!TEMA)
                  {
                     request.tp = Buytake - fora ;
                  }
            }
         else
            {
               request.tp =  g_param_posicao_take ? g_param_buy_take : Buytake - fora ;
               request.sl = Buystop - fora ;
            }
      }
   takbuy = request.tp;
   nivelstoplos_buy = request.sl;
   if(OrderSend(request, result))
      {
         // Sorteia um número e imprime no log
         // Sorteia uma frase motivacional
         double saldotl = AccountInfoDouble(ACCOUNT_BALANCE);
         double open_price = (double) result.price;
         double Profit = (((takbuy - open_price) / pontt) *  contrat * g_param_lote / contrat) ;
         double loss = (((nivelstoplos_buy - open_price) / pontt) *  contrat * g_param_lote / contrat)  ;
         cb = NormalizeDouble(Profit, 2) * g_param_cambio;
         cv = NormalizeDouble(loss, 2) * g_param_cambio;
         Alvo = NormalizeDouble(Profit, 2);
         Protecao = NormalizeDouble(loss, 2);
         if(SALDO == 0)
            {
               lucro = Alvo * 100 / saldotl;
               perdas = Protecao * -100 / saldotl;
            }
         else
            {
               lucro = Alvo * 100 / SALDO;
               perdas = Protecao * -100 / SALDO;
            };
         int index = MathRand() % ArraySize(motivationalMessages);
         motiva =  motivationalMessages[index];
         BilheteDeCompra = result.order;
         preco_de_abertura_de_compra = result.price;
         Print("ordem de compra emviada -Bilhete : ", BilheteDeCompra);
         string payloadEvent = StringFormat(
                                  "{\"event\":\"ordem_executada\",\"tipo\":\"COMPRA\",\"symbol\":\"%s\",\"ticket\":%d,\"price\":%.5f,\"volume\":%.2f,\"sl\":%.5f,\"tp\":%.5f,\"alvo_mt\":%.2f,\"protecao_mt\":%.2f,\"lucro_pct\":%.2f,\"perda_pct\":%.2f,\"login\":%s,\"timestamp\":%d,\"msg\":\"📈 Ordem de Compra executada! Bilhete #%d\"}",
                                  Symbol(), (long)BilheteDeCompra, preco_de_abertura_de_compra, g_param_lote, nivelstoplos_buy, takbuy, cb, cv, lucro, perdas, ObterContaMt5Login(), (int)TimeCurrent(), (long)BilheteDeCompra
                               );
         EnviarPutHTTP(ObterEventosEndpointFirebase("ordem_executada"), payloadEvent);
         VerificarEEnviarHistoricoFinanceiro();
         CapturarGraficoComObjetos();
         // 📨 Função para enviar um e-mail notificando o envio de uma ordem de venda*
         SendMailMQL5(
            "📈 Ordem de Compra emviada",  // 🏷️ Assunto do e-mail
            "<html>"
            "<body style='font-family: Times New Roman, serif; font-size: 12px; color: #222; background-color: #f7f7f7; '>"
            "<div style='background-color: #eaeaea;border-radius: 20px;padding: 20px; box-shadow: 0px 0px 5px rgba(0.4,0.4,0.4,0.4);'>"
            "<h2 style='color: #333; text-align: center; border-bottom: 2px solid #666; padding-bottom: 10px;'>EA fimaster</h2>"
            "<div style='background-color: #f2f2f2; padding: 15px; border-radius: 5px; margin-bottom: 10px; border: 1px solid #bbb;'>"
            "<h3 style='text-align: center;'>🏆 Dica de Ouro</h3>"
            "<p style='text-align: center; font-weight: bold;'>" + motiva + "</p>"
            "</div>"
            "<div style='background-color: #dcdcdc; padding: 15px; border-radius: 5px; margin-bottom: 10px; border: 1px solid #bbb;'>"
            "<h3 style='text-align: center;'>📌 Detalhes da Ordem</h3>"
            "<ul style='list-style: none; padding: 0;'>"
            "<li style='border-bottom: 1px solid #bbb; padding: 10px;'><b></b></span></li>"
            "<li style='border-bottom: 1px solid #bbb; padding: 10px;'><b>📅 Dia da Semana:</b> <span style='float: right;'>" + DayOfWeek(current) + " " + (string)current_time + "</span></li>"
            "<li style='border-bottom: 1px solid #bbb; padding: 10px;'><b>💱 Ativo:</b> <span style='float: right;'>" + symboll + "</span></li>"
            "<li style='border-bottom: 1px solid #bbb; padding: 10px;'><b>🏷️ Bilhete Gerado:</b> <span style='float: right;'>" + DoubleToString(BilheteDeCompra, 0) + "</span></li>"
            "</ul>"
            "</div>"
            "<div style='background-color: #f2f2f2; padding: 15px; border-radius: 5px; margin-bottom: 10px; border: 1px solid #bbb;'>"
            "<h3 style='text-align: center;'>📈 Estratégia de Entrada</h3>"
            "<ul style='list-style: none; padding: 0;'>"
            "<li style='border-bottom: 1px solid #bbb; padding: 3px;'><b></b></span></li>"
            "<li style='border-bottom: 1px solid #bbb; padding: 3px;'><b>📈 Resistência Rompida:</b> <span style='float: right;'>" + DoubleToString(PrecoDeCompra, decimal) + "</span></li>"
            "<li style='border-bottom: 1px solid #bbb; padding: 3px;'><b>📊 Vela de Confirmação:</b> <span style='float: right;'>" + EnumToString(PeriodoOperacional) + "</span></li>"
            "</ul>"
            "</div>"
            "<div style='background-color: #dcdcdc; padding: 15px; border-radius: 5px; margin-bottom: 10px; border: 1px solid #bbb;'>"
            "<h3 style='text-align: center;'>🎯 Parâmetros de Risco & Recompensa </h3>"
            "<ul style='list-style: none; padding: 0;'>"
            "<li style='border-bottom: 1px solid #bbb; padding: 3px;'><b></b></span></li>"
            "<li style='border-bottom: 1px solid #bbb; padding: 3px;'><b>💰 Alvo de Lucro:</b> <span style='float: right;'>" + DoubleToString(NormalizeDouble(cb, 2), decimal) + " " + g_param_moeda + " (" + DoubleToString(lucro, 2) + "%)</span></li>"
            "<li style='border-bottom: 1px solid #bbb; padding: 3px;'><b>💲 Proteção contra Perdas:</b> <span style='float: right;'>" + DoubleToString(NormalizeDouble(cv, 2), decimal) + " " + g_param_moeda + " (" + DoubleToString(perdas, 2) + "%)</span></li>"
            "</ul>"
            "</div>"
            "<div style='background-color: #f2f2f2; padding: 15px; border-radius: 5px; margin-bottom: 10px; border: 1px solid #bbb;'>"
            "<h3 style='text-align: center;'>💱 Informações de Entrada</h3>"
            "<ul style='list-style: none; padding: 0;'>"
            "<li style='border-bottom: 1px solid #bbb; padding: 3px;'><b></b></span></li>"
            "<li style='border-bottom: 1px solid #bbb; padding: 3px;'><b>📍 Entrada:</b> <span style='float: right;'>" + DoubleToString(preco_de_abertura_de_compra, decimal) + "</span></li>"
            "<li style='border-bottom: 1px solid #bbb; padding: 3px;'><b>🎯 Take Profit:</b> <span style='float: right;'>" + DoubleToString(takbuy, decimal) + "</span></li>"
            "<li style='border-bottom: 1px solid #bbb; padding: 3px;'><b>🛑 Stop Loss:</b> <span style='float: right;'>" + DoubleToString(nivelstoplos_buy, decimal) + "</span></li>"
            "<li style='border-bottom: 1px solid #bbb; padding: 3px;'><b>☂ Subciclo:</b> <span style='float: right;'>" + DoubleToString(Buysubsicul, decimal) + "</span></li>"
            "</ul>"
            "</div>"
            "<div style='background-color: #dcdcdc; padding: 15px; border-radius: 5px; border: 1px solid #bbb;'>"
            "<h3 style='text-align: center;'>📢 Resumo Final</h3>"
            "<p style='text-align: center;'>A ordem foi enviada conforme os parâmetros estabelecidos, garantindo um gerenciamento equilibrado de risco e retorno.</p>"
            "<p style='text-align: center;'>📊 <b>Acompanhe o mercado e gerencie sua posição.</b></p>"
            "</div>"
            "<h3 style='color: green; text-align: center; border-top: 2px solid #666; padding-top: 10px;'>✅ Bons Trades! 🚀</h3>"
            "</div>"
            "</div>"
            "<div style='margin-top: 20px; text-align: center; border-top: 1px solid #bbb; padding-top: 10px; font-size: 14px; color: #555;'>"
            "<p>Atenciosamente</p>"
            "<p><b>jossias Macucul</b></p>"
            "<img src='https://scontent.fmpm1-1.fna.fbcdn.net/v/t39.30808-6/491938161_2507846312884992_8093885575213355777_n.jpg?stp=dst-jpg_p526x296_tt6&_nc_cat=109&ccb=1-7&_nc_sid=833d8c&_nc_eui2=AeFaUXxHomop_5plv_dU571rgcvTQfIUGm-By9NB8hQab6GWoLSk5w_LkpI_i21bHgzj9nblk1VuaB2zyAJHdqCv&_nc_ohc=qbXLUyP6vvkQ7kNvwH4B0ZV&_nc_oc=AdncZn_ien4k3aNn-ybH4Emnmd5CI4rDx6auDyOAY_pjgVYvR8_pUxi3leZs4BwKUgc&_nc_pt=5&_nc_zt=23&_nc_ht=scontent.fmpm1-1.fna&_nc_gid=SQpVoEHFfm4kjhoh5PpiVg&oh=00_AfHt3opt4pL2tPVHzkgAQupSyxBa08n129SIAldVhH9nYA&oe=680874C6'alt='Logo' style='width: 100px; margin-top: 10px;'>"
            "</div>"
            "</body></html>"
         );
         return true;
      }
   else
      {
         string payloadError = StringFormat(
                                  "{\"event\":\"erro_ordem\",\"tipo\":\"COMPRA\",\"symbol\":\"%s\",\"erro_code\":%d,\"login\":%s,\"timestamp\":%d,\"msg\":\"❌ Falha ao enviar ordem de compra. Erro: %d\"}",
                                  Symbol(), GetLastError(), ObterContaMt5Login(), (int)TimeCurrent(), GetLastError()
                               );
         EnviarPutHTTP(ObterEventosEndpointFirebase("erro_ordem"), payloadError);
         Print("Erro ao enviar a ordem de compra -erro :", GetLastError());
         return false;
      }
}
//+------------------------------------------------------------------+
bool SellMarkt()
{
   MqlTradeRequest request = { };
   MqlTradeResult result = { };
   ZeroMemory(request);
   request.action = TRADE_ACTION_DEAL;
   request.volume = g_param_lote;
   request.symbol = Symbol();
   request.type = ORDER_TYPE_SELL;
   request.price = SymbolInfoDouble(Symbol(), SYMBOL_BID);
   request.deviation  = 10;
   request.comment = "Venda Mercado";
   request.magic = MagicNumber;
   request.type_time = ORDER_TIME_GTC;
// filling mode correto (bitmask)
   int filling = (int)SymbolInfoInteger(symboll, SYMBOL_FILLING_MODE);
   if((filling & SYMBOL_FILLING_FOK) != 0)
      {
         request.type_filling = ORDER_FILLING_FOK;
      }
   else if((filling & SYMBOL_FILLING_IOC) != 0)
      {
         request.type_filling = ORDER_FILLING_IOC;
      }
   else
      {
         request.type_filling = ORDER_FILLING_RETURN;
      }
   if(g_param_estrategia == F_SURFADA)
      {
         if(g_param_posicao_take)
            {
               if(g_param_sell_take == 0.0) {}
               else
                  {
                     request.tp = g_param_sell_take ;
                  }
            }
         request.sl = Sellestop + fora ;
      }
   if(g_param_estrategia == FIMATHE)
      {
         if(g_param_sell_take == 0.0)
            {
               if(!TEMA)
                  {
                     request.tp = Selltake + fora ;
                  }
               request.sl = Sellestop + fora ;
            }
         else
            {
               request.tp = g_param_posicao_take ? g_param_sell_take : Selltake + fora ;
               request.sl = Sellestop + fora ;
            }
      }
   taksell = request.tp;
   nivelstoplos_sell = request.sl;
   if(OrderSend(request, result))
      {
         double saldotl = AccountInfoDouble(ACCOUNT_BALANCE);
         double open_price = (double) result.price;
         double Profit = (((open_price - taksell) / pontt) *  contrat * g_param_lote / contrat) ;
         double loss = (((open_price - nivelstoplos_sell) / pontt) *  contrat * g_param_lote / contrat)  ;
         cb = NormalizeDouble(Profit, 2) * g_param_cambio;
         cv = NormalizeDouble(loss, 2) * g_param_cambio;
         Alvo = NormalizeDouble(Profit, 2);
         Protecao = NormalizeDouble(loss, 2);
         if(SALDO == 0)
            {
               lucro = Alvo * 100 / saldotl;
               perdas = Protecao * -100 / saldotl;
            }
         else
            {
               lucro = Alvo * 100 / SALDO;
               perdas = Protecao * -100 / SALDO;
            };
         // Sorteia uma frase motivacional
         int index = MathRand() % ArraySize(motivationalMessages);
         motiva =  motivationalMessages[index];
         BilheteDeVenda = result.order;
         preco_de_abertura_de_venda = result.price;
         Print("ordem de venda emviada -Bilhete : ", BilheteDeVenda);
         string payloadEvent = StringFormat(
                                  "{\"event\":\"ordem_executada\",\"tipo\":\"VENDA\",\"symbol\":\"%s\",\"ticket\":%d,\"price\":%.5f,\"volume\":%.2f,\"sl\":%.5f,\"tp\":%.5f,\"alvo_mt\":%.2f,\"protecao_mt\":%.2f,\"lucro_pct\":%.2f,\"perda_pct\":%.2f,\"login\":%s,\"timestamp\":%d,\"msg\":\"📉 Ordem de Venda executada! Bilhete #%d\"}",
                                  Symbol(), (long)BilheteDeVenda, preco_de_abertura_de_venda, g_param_lote, nivelstoplos_sell, taksell, cb, cv, lucro, perdas, ObterContaMt5Login(), (int)TimeCurrent(), (long)BilheteDeVenda
                               );
         EnviarPutHTTP(ObterEventosEndpointFirebase("ordem_executada"), payloadEvent);
         VerificarEEnviarHistoricoFinanceiro();
         CapturarGraficoComObjetos();
         // 📨 Função para enviar um e-mail notificando o envio de uma ordem de venda
         SendMailMQL5(
            "📉 Ordem de Venda emviada",  // 🏷️ Assunto do e-mail
            "<html>"
            "<body style='font-family: Times New Roman, serif; font-size: 12px; color: #222; background-color: #f7f7f7;'>"
            "<div style='background-color: #eaeaea;border-radius: 20px;padding: 20px; box-shadow: 0px 0px 5px rgba(0.4,0.4,0.4,0.4);'>"
            "<h2 style='color: #333; text-align: center; border-bottom: 2px solid #666; padding-bottom: 10px;'>EA fimaster</h2>"
            "<div style='background-color: #f2f2f2; padding: 15px; border-radius: 5px; margin-bottom: 10px; border: 1px solid #bbb;'>"
            "<h3 style='text-align: center;'>🏆 Dica de Ouro</h3>"
            "<p style='text-align: center; font-weight: bold;'>" + motiva + "</p>"
            "</div>"
            "<div style='background-color: #dcdcdc; padding: 15px; border-radius: 5px; margin-bottom: 10px; border: 1px solid #bbb;'>"
            "<h3 style='text-align: center;'>📌 Detalhes da Ordem</h3>"
            "<ul style='list-style: none; padding: 0;'>"
            "<li style='border-bottom: 1px solid #bbb; padding: 3px;'><b></b></span></li>"
            "<li style='border-bottom: 1px solid #bbb; padding: 3px;'><b>📅 Dia da Semana:</b> <span style='float: right;'>" + DayOfWeek(current) + " " + (string)current_time + "</span></li>"
            "<li style='border-bottom: 1px solid #bbb; padding: 3px;'><b>💱 Ativo:</b> <span style='float: right;'>" + symboll + "</span></li>"
            "<li style='border-bottom: 1px solid #bbb; padding: 3px;'><b>🏷️ Bilhete Gerado:</b> <span style='float: right;'>" + DoubleToString(BilheteDeVenda, 0) + "</span></li>"
            "</ul>"
            "</div>"
            "<div style='background-color: #f2f2f2; padding: 15px; border-radius: 5px; margin-bottom: 10px; border: 1px solid #bbb;'>"
            "<h3 style='text-align: center;'>📉 Estratégia de Entrada</h3>"
            "<ul style='list-style: none; padding: 0;'>"
            "<li style='border-bottom: 1px solid #bbb; padding: 3px;'><b></b></span></li>"
            "<li style='border-bottom: 1px solid #bbb; padding: 3px;'><b>📉 Resistência Rompida:</b> <span style='float: right;'>" + DoubleToString(PrecoDeVenda, decimal) + "</span></li>"
            "<li style='border-bottom: 1px solid #bbb; padding: 3px;'><b>📊 Vela de Confirmação:</b> <span style='float: right;'>" + EnumToString(PeriodoOperacional) + "</span></li>"
            "</ul>"
            "</div>"
            "<div style='background-color: #dcdcdc; padding: 15px; border-radius: 5px; margin-bottom: 10px; border: 1px solid #bbb;'>"
            "<h3 style='text-align: center;'>🎯 Parâmetros de Risco & Recompensa</h3>"
            "<ul style='list-style: none; padding: 0;'>"
            "<li style='border-bottom: 1px solid #bbb; padding: 3px;'><b></b></span></li>"
            "<li style='border-bottom: 1px solid #bbb; padding: 3px;'><b>💰 Alvo de Lucro:</b> <span style='float: right;'>" + DoubleToString(NormalizeDouble(cb, 2), decimal) + " " + g_param_moeda + " (" + DoubleToString(lucro, 2) + "%)</span></li>"
            "<li style='border-bottom: 1px solid #bbb; padding: 3px;'><b>💲 Proteção contra Perdas:</b> <span style='float: right;'>" + DoubleToString(NormalizeDouble(cv, 2), decimal) + " " + g_param_moeda + " (" + DoubleToString(perdas, 2) + "%)</span></li>"
            "</ul>"
            "</div>"
            "<div style='background-color: #f2f2f2; padding: 15px; border-radius: 5px; margin-bottom: 10px; border: 1px solid #bbb;'>"
            "<h3 style='text-align: center;'>💱 Informações de Entrada</h3>"
            "<ul style='list-style: none; padding: 0;'>"
            "<li style='border-bottom: 1px solid #bbb; padding: 3px;'><b></b></span></li>"
            "<li style='border-bottom: 1px solid #bbb; padding: 3px;'><b>📍 Entrada:</b> <span style='float: right;'>" + DoubleToString(preco_de_abertura_de_venda, decimal) + "</span></li>"
            "<li style='border-bottom: 1px solid #bbb; padding: 3px;'><b>🎯 Take Profit:</b> <span style='float: right;'>" + DoubleToString(taksell, decimal) + "</span></li>"
            "<li style='border-bottom: 1px solid #bbb; padding: 3px;'><b>🛑 Stop Loss:</b> <span style='float: right;'>" + DoubleToString(nivelstoplos_sell, decimal) + "</span></li>"
            "<li style='border-bottom: 1px solid #bbb; padding: 3px;'><b>☂ Subciclo:</b> <span style='float: right;'>" + DoubleToString(Sellsubsicul, decimal) + "</span></li>"
            "</ul>"
            "</div>"
            "<div style='background-color: #dcdcdc; padding: 15px; border-radius: 5px; border: 1px solid #bbb;'>"
            "<h3 style='text-align: center;'>📢 Resumo Final</h3>"
            "<p style='text-align: center;'>A ordem foi enviada conforme os parâmetros estabelecidos, garantindo um gerenciamento equilibrado de risco e retorno.</p>"
            "<p style='text-align: center;'>📊 <b>Acompanhe o mercado e gerencie sua posição.</b></p>"
            "</div>"
            "<h3 style='color: green; text-align: center; border-top: 2px solid #666; padding-top: 10px;'>✅ Bons Trades! 🚀</h3>"
            "</div>"
            "</div>"
            "<div style='margin-top: 20px; text-align: center; border-top: 1px solid #bbb; padding-top: 10px; font-size: 14px; color: #555;'>"
            "<p>Atenciosamente</p>"
            "<p><b>jossias Macucul</b></p>"
            "<img src='https://scontent.fmpm1-1.fna.fbcdn.net/v/t39.30808-6/491938161_2507846312884992_8093885575213355777_n.jpg?stp=dst-jpg_p526x296_tt6&_nc_cat=109&ccb=1-7&_nc_sid=833d8c&_nc_eui2=AeFaUXxHomop_5plv_dU571rgcvTQfIUGm-By9NB8hQab6GWoLSk5w_LkpI_i21bHgzj9nblk1VuaB2zyAJHdqCv&_nc_ohc=qbXLUyP6vvkQ7kNvwH4B0ZV&_nc_oc=AdncZn_ien4k3aNn-ybH4Emnmd5CI4rDx6auDyOAY_pjgVYvR8_pUxi3leZs4BwKUgc&_nc_pt=5&_nc_zt=23&_nc_ht=scontent.fmpm1-1.fna&_nc_gid=SQpVoEHFfm4kjhoh5PpiVg&oh=00_AfHt3opt4pL2tPVHzkgAQupSyxBa08n129SIAldVhH9nYA&oe=680874C6'alt='Logo' style='width: 100px; margin-top: 10px;'>"
            "</div>"
            "</body></html>"
         );
         return true;
      }
   else
      {
         Print("Erro ao enviar a ordem de venda -erro :", GetLastError());
         string payloadError = StringFormat(
                                  "{\"event\":\"erro_ordem\",\"tipo\":\"VENDA\",\"symbol\":\"%s\",\"erro_code\":%d,\"login\":%s,\"timestamp\":%d,\"msg\":\"❌ Falha ao enviar ordem de venda. Erro: %d\"}",
                                  Symbol(), GetLastError(), ObterContaMt5Login(), (int)TimeCurrent(), GetLastError()
                               );
         EnviarPutHTTP(ObterEventosEndpointFirebase("erro_ordem"), payloadError);
         return false;
      }
   return true;
}
//+------------------------------------------------------------------+
bool ModifySellOrder()
{
   if(PositionSelectByTicket(BilheteDeVenda))
      {
         {
            MqlTradeRequest request = { };
            MqlTradeResult result = { };
            request.action = TRADE_ACTION_SLTP;
            request.symbol = Symbol();
            request.magic = MagicNumber;
            if(g_param_estrategia == F_SURFADA)
               {
                  if(g_param_posicao_take)
                     {
                        if(g_param_sell_take == 0.0) {}
                        else
                           {
                              request.tp = g_param_sell_take;
                           }
                     }
                  request.sl = SellModif ;
               }
            if(g_param_estrategia ==  FIMATHE)
               {
                  if(g_param_sell_take == 0.0)
                     {
                        if(!TEMA)
                           {
                              request.tp = Selltake + fora;
                           }
                        request.sl = g_param_modify_sl ?  preco_de_abertura_de_venda : SellModif ;
                     }
                  else
                     {
                        request.tp =   g_param_posicao_take ? g_param_sell_take :  Selltake + fora;
                        request.sl = g_param_modify_sl ?  preco_de_abertura_de_venda : SellModif ;
                     }
               }
            request.position = BilheteDeVenda;
            nivelzerosell = request.sl;
            taksell = request.tp;
            if(OrderSend(request, result))
               {
                  int index = MathRand() % ArraySize(emotionalControlSecrets);
                  motiva =  emotionalControlSecrets[index];
                  Print("Ordem de venda modificada - Bilhete: ", BilheteDeVenda, " Novo SL: ", SellModif);
                  string payloadEvent = StringFormat(
                                           "{\"event\":\"ordem_modificada\",\"tipo\":\"VENDA\",\"symbol\":\"%s\",\"ticket\":%d,\"novo_sl\":%.5f,\"novo_tp\":%.5f,\"login\":%s,\"timestamp\":%d,\"msg\":\"✅ Ordem Venda #%d modificada! Novo SL: %.5f\"}",
                                           Symbol(), (long)BilheteDeVenda, nivelzerosell, taksell, ObterContaMt5Login(), (int)TimeCurrent(), (long)BilheteDeVenda, nivelzerosell
                                        );
                  EnviarPutHTTP(ObterEventosEndpointFirebase("ordem_modificada"), payloadEvent);
                  CapturarGraficoComObjetos();
                  SendMailMQL5(
                     "✅ Ordem de Venda Modificada ",  // 🏷️ Assunto do e-mail
                     "<html>"
                     "<body style='font-family: Times New Roman, serif; font-size: 12px; color: #222; background-color: #f7f7f7;'>"
                     "<div style='background-color: #eaeaea;border-radius: 20px; padding: 20px; box-shadow: 0px 0px 5px rgba(0.4,0.4,0.4,0.4);'>"
                     "<h2 style='text-align: center; border-bottom: 2px solid #666; padding-bottom: 10px;'>EA fimaster</h2>"
                     "<div style='background-color: #f2f2f2; padding: 15px; border-radius: 5px; margin-bottom: 10px; border: 1px solid #bbb;'>"
                     "<h3 style='text-align: center;'>🏆 Dica de Ouro</h3>"
                     "<p style='text-align: center; font-weight: bold;'>" + motiva + "</p>"
                     "</div>"
                     "<div style='background-color: #dcdcdc; padding: 15px; border-radius: 5px; margin-bottom: 10px; border: 1px solid #bbb;'>"
                     "<h3 style='text-align: center;'>📌 Detalhes da Modificação</h3>"
                     "<ul style='list-style: none; padding: 0;'>"
                     "<li style='border-bottom: 1px solid #bbb; padding: 3px;'><b></b></span></li>"
                     "<li style='border-bottom: 1px solid #bbb; padding: 3px;'><b>📅 Dia da Semana:</b> <span style='float: right;'>" + DayOfWeek(current) + " " + (string)current_time + "</span></li>"
                     "<li style='border-bottom: 1px solid #bbb; padding: 3px;'><b>💱 Ativo:</b> <span style='float: right;'>" + symboll + "</span></li>"
                     "<li style='border-bottom: 1px solid #bbb; padding: 3px;'><b>🏷️ Bilhete Copiado:</b> <span style='float: right;'>" + DoubleToString(BilheteDeVenda, 0) + "</span></li>"
                     "</ul>"
                     "</div>"
                     "<div style='background-color: #f2f2f2; padding: 15px; border-radius: 5px; margin-bottom: 10px; border: 1px solid #bbb;'>"
                     "<h3 style='text-align: center;'>📉 Estratégia de Modificação</h3>"
                     "<ul style='list-style: none; padding: 0;'>"
                     "<li style='border-bottom: 1px solid #bbb; padding: 3px;'><b></b></span></li>"
                     "<li style='border-bottom: 1px solid #bbb; padding: 3px;'><b>📉 Subciclo Rompido:</b> <span style='float: right;'>" + DoubleToString(Sellsubsicul, decimal) + "</span></li>"
                     "<li style='border-bottom: 1px solid #bbb; padding: 3px;'><b>📊 Vela de Confirmação:</b> <span style='float: right;'>" + EnumToString(PeriodoOperacional) + "</span></li>"
                     "</ul>"
                     "</div>"
                     "<div style='background-color: #dcdcdc; padding: 15px; border-radius: 5px; margin-bottom: 10px; border: 1px solid #bbb;'>"
                     "<h3 style='text-align: center;'>🎯 Ajustes de Parâmetros</h3>"
                     "<ul style='list-style: none; padding: 0;'>"
                     "<li style='border-bottom: 1px solid #bbb; padding: 3px;'><b></b></span></li>"
                     "<li style='border-bottom: 1px solid #bbb; padding: 3px;'><b>💰 Alvo de Lucro:</b> <span style='float: right;'>" + DoubleToString(NormalizeDouble(cb, 2), decimal) + " " + g_param_moeda + " (" + DoubleToString(lucro, 2) + "%)</span></li>"
                     "<li style='border-bottom: 1px solid #bbb; padding: 3px;'><b>⚖️ Status:</b> <span style='float: right;'>"" sem prejuízo"" </span></li>"
                     "</ul>"
                     "</div>"
                     "<div style='background-color: #f2f2f2; padding: 15px; border-radius: 5px; margin-bottom: 10px; border: 1px solid #bbb;'>"
                     "<h3 style='text-align: center;'>💱 Informações Atualizadas</h3>"
                     "<ul style='list-style: none; padding: 0;'>"
                     "<li style='border-bottom: 1px solid #bbb; padding: 3px;'><b></b></span></li>"
                     "<li style='border-bottom: 1px solid #bbb; padding: 3px;'><b>🎯 Take Profit:</b> <span style='float: right;'>" + DoubleToString(taksell, decimal) + "</span></li>"
                     "<li style='border-bottom: 1px solid #bbb; padding: 3px;'><b>☂ Novo Stop Loss:</b> <span style='float: right;'>" + DoubleToString(SellModif, decimal) + "</span></li>"
                     "</ul>"
                     "</div>"
                     "<div style='background-color: #dcdcdc; padding: 15px; border-radius: 5px; border: 1px solid #bbb;'>"
                     "<h3 style='text-align: center;'>📢 Resumo Final</h3>"
                     "<p style='text-align: center;'>A ordem foi ajustada para um nível seguro, protegendo o capital e permitindo potenciais ganhos sem risco de prejuízo.</p>"
                     "<p style='text-align: center;'>🔎 Continue acompanhando seus resultados pelo e-mail.</p>"
                     "</div>"
                     "<h3 style='text-align: center; border-top: 2px solid #666; padding-top: 10px;'>✅ Mantenha-se atento às notificações.</h3>"
                     "</div>"
                     "</div>"
                     "<div style='margin-top: 20px; text-align: center; border-top: 1px solid #bbb; padding-top: 10px; font-size: 14px; color: #555;'>"
                     "<p>Atenciosamente</p>"
                     "<p><b>jossias Macucul</b></p>"
                     "<img src='https://scontent.fmpm1-1.fna.fbcdn.net/v/t39.30808-6/491938161_2507846312884992_8093885575213355777_n.jpg?stp=dst-jpg_p526x296_tt6&_nc_cat=109&ccb=1-7&_nc_sid=833d8c&_nc_eui2=AeFaUXxHomop_5plv_dU571rgcvTQfIUGm-By9NB8hQab6GWoLSk5w_LkpI_i21bHgzj9nblk1VuaB2zyAJHdqCv&_nc_ohc=qbXLUyP6vvkQ7kNvwH4B0ZV&_nc_oc=AdncZn_ien4k3aNn-ybH4Emnmd5CI4rDx6auDyOAY_pjgVYvR8_pUxi3leZs4BwKUgc&_nc_pt=5&_nc_zt=23&_nc_ht=scontent.fmpm1-1.fna&_nc_gid=SQpVoEHFfm4kjhoh5PpiVg&oh=00_AfHt3opt4pL2tPVHzkgAQupSyxBa08n129SIAldVhH9nYA&oe=680874C6'alt='Logo' style='width: 100px; margin-top: 10px;'>"
                     "</div>"
                     "</body></html>"
                  );
                  return true;
               }
            else
               {
                  Print("Erro ao modificar a ordem de venda - Bilhete: ", BilheteDeVenda);
                  return false;
               }
         }
      }
   return true;
}
//+------------------------------------------------------------------+
//| |
//+------------------------------------------------------------------+
bool ModifyBuyOrder()
{
   if(PositionSelectByTicket(BilheteDeCompra))
      {
         {
            MqlTradeRequest request = { };
            MqlTradeResult result = { };
            request.action = TRADE_ACTION_SLTP;
            request.symbol = Symbol();
            request.magic = MagicNumber;
            if(g_param_estrategia == F_SURFADA)
               {
                  if(g_param_posicao_take)
                     {
                        if(g_param_buy_take == 0.0) {}
                        else
                           {
                              request.tp = g_param_buy_take;
                           }
                     }
                  request.sl = Buymodif;
               }
            if(g_param_estrategia ==  FIMATHE)
               {
                  if(g_param_buy_take == 0.0)
                     {
                        if(!TEMA)
                           {
                              request.tp = Buytake - fora;
                           }
                        request.sl =    g_param_modify_sl ? preco_de_abertura_de_compra : Buymodif;
                     }
                  else
                     {
                        request.tp =  g_param_posicao_take ?  g_param_buy_take : Buytake - fora;
                        request.sl =    g_param_modify_sl ? preco_de_abertura_de_compra : Buymodif;
                     }
               }
            request.position = BilheteDeCompra;
            nivelzerobuy = request.sl;
            takbuy = request.tp;
            if(OrderSend(request, result))
               {
                  int index = MathRand() % ArraySize(emotionalControlSecrets);
                  motiva =  emotionalControlSecrets[index];
                  Print("Ordem de compra modificada - Bilhete: ", BilheteDeCompra, " Novo SL: ", Buymodif);
                  string payloadEvent = StringFormat(
                                           "{\"event\":\"ordem_modificada\",\"tipo\":\"COMPRA\",\"symbol\":\"%s\",\"ticket\":%d,\"novo_sl\":%.5f,\"novo_tp\":%.5f,\"login\":%s,\"timestamp\":%d,\"msg\":\"✅ Ordem Compra #%d modificada! Novo SL: %.5f\"}",
                                           Symbol(), (long)BilheteDeCompra, nivelzerobuy, takbuy, ObterContaMt5Login(), (int)TimeCurrent(), (long)BilheteDeCompra, nivelzerobuy
                                        );
                  EnviarPutHTTP(ObterEventosEndpointFirebase("ordem_modificada"), payloadEvent);
                  CapturarGraficoComObjetos();
                  SendMailMQL5(
                     "✅ Ordem de Compra Modificada ",  // 🏷️ Assunto do e-mail
                     "<html>"
                     "<body style='font-family: Times New Roman, serif; font-size: 12px; color: #222; background-color: #f7f7f7;'>"
                     "<div style='background-color: #eaeaea;border-radius: 20px;padding: 20px; box-shadow: 0px 0px 5px rgba(0.4,0.4,0.4,0.4);'>"
                     "<h2 style='text-align: center; border-bottom: 2px solid #666; padding-bottom: 10px;'>EA fimaster</h2>"
                     "<div style='background-color: #f2f2f2; padding: 15px; border-radius: 5px; margin-bottom: 10px; border: 1px solid #bbb;'>"
                     "<h3 style='text-align: center;'>🏆 Dica de Ouro</h3>"
                     "<p style='text-align: center; font-weight: bold;'>" + motiva + "</p>"
                     "</div>"
                     "<div style='background-color: #dcdcdc; padding: 15px; border-radius: 5px; margin-bottom: 10px; border: 1px solid #bbb;'>"
                     "<h3 style='text-align: center;'>📌 Detalhes da Modificação</h3>"
                     "<ul style='list-style: none; padding: 0;'>"
                     "<li style='border-bottom: 1px solid #bbb; padding: 3px;'><b></b></span></li>"
                     "<li style='border-bottom: 1px solid #bbb; padding: 3px;'><b>📅 Dia da Semana:</b> <span style='float: right;'>" + DayOfWeek(current) + " " + (string)current_time + "</span></li>"
                     "<li style='border-bottom: 1px solid #bbb; padding: 3px;'><b>💱 Ativo:</b> <span style='float: right;'>" + symboll + "</span></li>"
                     "<li style='border-bottom: 1px solid #bbb; padding: 3px;'><b>🏷️ Bilhete Copiado:</b> <span style='float: right;'>" + DoubleToString(BilheteDeCompra, 0) + "</span></li>"
                     "</ul>"
                     "</div>"
                     "<div style='background-color: #f2f2f2; padding: 15px; border-radius: 5px; margin-bottom: 10px; border: 1px solid #bbb;'>"
                     "<h3 style='text-align: center;'>📈 Estratégia de Modificação</h3>"
                     "<ul style='list-style: none; padding: 0;'>"
                     "<li style='border-bottom: 1px solid #bbb; padding: 3px;'><b></b></span></li>"
                     "<li style='border-bottom: 1px solid #bbb; padding: 3px;'><b>📈 Subciclo Rompido:</b> <span style='float: right;'>" + DoubleToString(Buysubsicul, decimal) + "</span></li>"
                     "<li style='border-bottom: 1px solid #bbb; padding: 3px;'><b>📊 Vela de Confirmação:</b> <span style='float: right;'>" + EnumToString(PeriodoOperacional) + "</span></li>"
                     "</ul>"
                     "</div>"
                     "<div style='background-color: #dcdcdc; padding: 15px; border-radius: 5px; margin-bottom: 10px; border: 1px solid #bbb;'>"
                     "<h3 style='text-align: center;'>🎯 Ajustes de Parâmetros</h3>"
                     "<ul style='list-style: none; padding: 0;'>"
                     "<li style='border-bottom: 1px solid #bbb; padding: 3px;'><b></b></span></li>"
                     "<li style='border-bottom: 1px solid #bbb; padding: 3px;'><b>💰 Alvo de Lucro:</b> <span style='float: right;'>" + DoubleToString(NormalizeDouble(cb, 2), decimal) + " " + g_param_moeda + " (" + DoubleToString(lucro, 2) + "%)</span></li>"
                     "<li style='border-bottom: 1px solid #bbb; padding: 3px;'><b>⚖️ Status:</b> <span style='float: right;'>"" sem prejuízo ""</span></li>"
                     "</ul>"
                     "</div>"
                     "<div style='background-color: #f2f2f2; padding: 15px; border-radius: 5px; margin-bottom: 10px; border: 1px solid #bbb;'>"
                     "<h3 style='text-align: center;'>💱 Informações Atualizadas</h3>"
                     "<ul style='list-style: none; padding: 0;'>"
                     "<li style='border-bottom: 1px solid #bbb; padding: 3px;'><b></b></span></li>"
                     "<li style='border-bottom: 1px solid #bbb; padding: 3px;'><b>🎯 Take Profit:</b> <span style='float: right;'>" + DoubleToString(takbuy, decimal) + "</span></li>"
                     "<li style='border-bottom: 1px solid #bbb; padding: 3px;'><b>☂ Novo Stop Loss:</b> <span style='float: right;'>" + DoubleToString(Buymodif, decimal) + "</span></li>"
                     "</ul>"
                     "</div>"
                     "<div style='background-color: #dcdcdc; padding: 15px; border-radius: 5px; border: 1px solid #bbb;'>"
                     "<h3 style='text-align: center;'>📢 Resumo Final</h3>"
                     "<p style='text-align: center;'>A ordem foi ajustada para um nível seguro, protegendo o capital e permitindo potenciais ganhos sem risco de prejuízo.</p>"
                     "<p style='text-align: center;'>🔎 Continue acompanhando seus resultados pelo e-mail.</p>"
                     "</div>"
                     "<h3 style='text-align: center; border-top: 2px solid #666; padding-top: 10px;'>✅ Mantenha-se atento às notificações.</h3>"
                     "</div>"
                     "</div>"
                     "<div style='margin-top: 20px; text-align: center; border-top: 1px solid #bbb; padding-top: 10px; font-size: 14px; color: #555;'>"
                     "<p>Atenciosamente</p>"
                     "<p><b>jossias Macucul</b></p>"
                     "<img src='https://scontent.fmpm1-1.fna.fbcdn.net/v/t39.30808-6/491938161_2507846312884992_8093885575213355777_n.jpg?stp=dst-jpg_p526x296_tt6&_nc_cat=109&ccb=1-7&_nc_sid=833d8c&_nc_eui2=AeFaUXxHomop_5plv_dU571rgcvTQfIUGm-By9NB8hQab6GWoLSk5w_LkpI_i21bHgzj9nblk1VuaB2zyAJHdqCv&_nc_ohc=qbXLUyP6vvkQ7kNvwH4B0ZV&_nc_oc=AdncZn_ien4k3aNn-ybH4Emnmd5CI4rDx6auDyOAY_pjgVYvR8_pUxi3leZs4BwKUgc&_nc_pt=5&_nc_zt=23&_nc_ht=scontent.fmpm1-1.fna&_nc_gid=SQpVoEHFfm4kjhoh5PpiVg&oh=00_AfHt3opt4pL2tPVHzkgAQupSyxBa08n129SIAldVhH9nYA&oe=680874C6'alt='Logo' style='width: 100px; margin-top: 10px;'>"
                     "</div>"
                     "</body></html>"
                  );
                  return true;
               }
            else
               {
                  Print("Erro ao modificar a ordem de compra - Bilhete: ", BilheteDeCompra);
               }
            return false;
         }
      }
   return false;
}



//+------------------------------------------------------------------+
void criar_linha_subsicol1(double valor)
{
   if(!mostrarobjetos)
      {
         return ;
      }
   string subsicul = "SUBSICOL_" + DoubleToString(valor, ddd);
   bool unica3 = true;
   for(int i = 0; i < ArraySize(precosArray); i++)
      {
         if(precosArray[i] == valor)
            {
               unica3 = false ;
               break;
            }
      }
   if(unica3)
      {
         int currentSize = ArraySize(precosArray);
         ArrayResize(precosArray, currentSize + 1);
         precosArray[currentSize] = valor;
         if(g_param_ea_auto == true)
            {
               ObjectCreate(0, subsicul, OBJ_TREND, 0, currentHour, valor, future, valor);
               ObjectSetInteger(0, subsicul, OBJPROP_WIDTH, 2);
               ObjectSetInteger(0, subsicul, OBJPROP_STYLE, STYLE_DASHDOTDOT);
               ObjectCreate(0, subsicul, OBJ_ARROW_LEFT_PRICE, 0, currentHour, valor);
               ObjectSetInteger(0, subsicul, OBJPROP_COLOR, cor_de_canal);
            }
         else
            {
               ObjectCreate(0, subsicul, OBJ_HLINE, 0, 0, valor);
               ObjectSetInteger(0, subsicul, OBJPROP_WIDTH, 2);
               ObjectSetInteger(0, subsicul, OBJPROP_STYLE, STYLE_DASHDOTDOT);
               ObjectSetInteger(0, subsicul, OBJPROP_COLOR, cor_de_canal);
            }
      }
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void criar_linha_venda1(double valor)
{
   if(!mostrarobjetos)
      {
         return ;
      }
   string linha_de_venda = "LINHA_DE_VENDA_" + DoubleToString(valor, ddd);
   bool unica2 = true;
   for(int i = 0; i < ArraySize(precosArray); i++)
      {
         if(precosArray[i] == valor)
            {
               unica2 = false ;
               break;
            }
      }
   if(unica2)
      {
         int currentSize = ArraySize(precosArray);
         ArrayResize(precosArray, currentSize + 1);
         precosArray[currentSize] = valor;
         if(g_param_ea_auto == true)
            {
               ObjectCreate(0, linha_de_venda, OBJ_TREND, 0, currentHour, valor, future, valor);
               ObjectCreate(0, linha_de_venda, OBJ_ARROW_LEFT_PRICE, 0, currentHour, valor);
               ObjectSetInteger(0, linha_de_venda, OBJPROP_WIDTH, 2);
               ObjectSetInteger(0, linha_de_venda, OBJPROP_STYLE, STYLE_SOLID);
               ObjectSetInteger(0, linha_de_venda, OBJPROP_COLOR, cor_de_canal);
            }
         else
            {
               ObjectCreate(0, linha_de_venda, OBJ_HLINE, 0, 0, valor);
               ObjectSetInteger(0, linha_de_venda, OBJPROP_WIDTH, 2);
               ObjectSetInteger(0, linha_de_venda, OBJPROP_STYLE, STYLE_SOLID);
               ObjectSetInteger(0, linha_de_venda, OBJPROP_COLOR, cor_de_canal);
            }
      }
}

//+------------------------------------------------------------------+
//| // criar linha de compra vermelho |
//+------------------------------------------------------------------+


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void criar_linha_de_compra1(double valor)
{
   if(!mostrarobjetos)
      {
         return ;
      }
   string precobuy = "LINHA_DE_COMPRA_" + DoubleToString(valor, ddd);
   bool unica = true;
   for(int i = 0; i < ArraySize(precosArray); i++)
      {
         if(precosArray[i] ==  valor)
            {
               unica = false ;
               break;
            }
      }
   if(unica)
      {
         int currentSize = ArraySize(precosArray);
         ArrayResize(precosArray, currentSize + 1);
         precosArray[currentSize] = valor;
         if(g_param_ea_auto == true)
            {
               ObjectCreate(0, precobuy, OBJ_TREND, 0, currentHour, valor, future, valor);
               ObjectCreate(0, precobuy, OBJ_ARROW_LEFT_PRICE, 0, currentHour, valor);
               ObjectSetInteger(0, precobuy, OBJPROP_WIDTH, 2);
               ObjectSetInteger(0, precobuy, OBJPROP_STYLE, STYLE_SOLID);
               ObjectSetInteger(0, precobuy, OBJPROP_COLOR, cor_de_canal);
            }
         else
            {
               ObjectCreate(0, precobuy, OBJ_HLINE, 0, 0, valor);
               ObjectSetInteger(0, precobuy, OBJPROP_WIDTH, 2);
               ObjectSetInteger(0, precobuy, OBJPROP_STYLE, STYLE_SOLID);
               ObjectSetInteger(0, precobuy, OBJPROP_COLOR, cor_de_canal);
            }
      }
}


//+------------------------------------------------------------------+
void criar_linha_subsicol(double valor)
{
   if(!mostrarobjetos)
      {
         return ;
      }
   string subsicul = "SUBSICOL_" + DoubleToString(valor, ddd);
   bool unica3 = true;
   for(int i = 0; i < ArraySize(precosArray); i++)
      {
         if(precosArray[i] == valor)
            {
               unica3 = false ;
               break;
            }
      }
   if(unica3)
      {
         int currentSize = ArraySize(precosArray);
         ArrayResize(precosArray, currentSize + 1);
         precosArray[currentSize] = valor;
         if(g_param_ea_auto == true)
            {
               ObjectCreate(0, subsicul, OBJ_TREND, 0, currentHour, valor, future, valor);
               ObjectSetInteger(0, subsicul, OBJPROP_WIDTH, 2);
               ObjectSetInteger(0, subsicul, OBJPROP_STYLE, STYLE_DASHDOTDOT);
               ObjectCreate(0, subsicul, OBJ_ARROW_LEFT_PRICE, 0, currentHour, valor);
               ObjectSetInteger(0, subsicul, OBJPROP_COLOR, cor_de_linhas);
            }
         else
            {
               ObjectCreate(0, subsicul, OBJ_HLINE, 0, 0, valor);
               ObjectSetInteger(0, subsicul, OBJPROP_WIDTH, 2);
               ObjectSetInteger(0, subsicul, OBJPROP_STYLE, STYLE_DASHDOTDOT);
               ObjectSetInteger(0, subsicul, OBJPROP_COLOR, cor_de_linhas);
            }
      }
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void criar_linha_venda(double valor)
{
   if(!mostrarobjetos)
      {
         return ;
      }
   string linha_de_venda = "LINHA_DE_VENDA_" + DoubleToString(valor, ddd);
   bool unica2 = true;
   for(int i = 0; i < ArraySize(precosArray); i++)
      {
         if(precosArray[i] == valor)
            {
               unica2 = false ;
               break;
            }
      }
   if(unica2)
      {
         int currentSize = ArraySize(precosArray);
         ArrayResize(precosArray, currentSize + 1);
         precosArray[currentSize] = valor;
         if(g_param_ea_auto == true)
            {
               ObjectCreate(0, linha_de_venda, OBJ_TREND, 0, currentHour, valor, future, valor);
               ObjectCreate(0, linha_de_venda, OBJ_ARROW_LEFT_PRICE, 0, currentHour, valor);
               ObjectSetInteger(0, linha_de_venda, OBJPROP_WIDTH, 2);
               ObjectSetInteger(0, linha_de_venda, OBJPROP_STYLE, STYLE_SOLID);
               ObjectSetInteger(0, linha_de_venda, OBJPROP_COLOR, cor_de_linhas);
            }
         else
            {
               ObjectCreate(0, linha_de_venda, OBJ_HLINE, 0, 0, valor);
               ObjectSetInteger(0, linha_de_venda, OBJPROP_WIDTH, 2);
               ObjectSetInteger(0, linha_de_venda, OBJPROP_STYLE, STYLE_SOLID);
               ObjectSetInteger(0, linha_de_venda, OBJPROP_COLOR, cor_de_linhas);
            }
      }
}



//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void criar_linha_de_compra(double valor)
{
   if(!mostrarobjetos)
      {
         return ;
      }
   string precobuy = "LINHA_DE_COMPRA_" + DoubleToString(valor, ddd);
   bool unica = true;
   for(int i = 0; i < ArraySize(precosArray); i++)
      {
         if(precosArray[i] ==  valor)
            {
               unica = false ;
               break;
            }
      }
   if(unica)
      {
         int currentSize = ArraySize(precosArray);
         ArrayResize(precosArray, currentSize + 1);
         precosArray[currentSize] = valor;
         if(g_param_ea_auto == true)
            {
               ObjectCreate(0, precobuy, OBJ_TREND, 0, currentHour, valor, future, valor);
               ObjectCreate(0, precobuy, OBJ_ARROW_LEFT_PRICE, 0, currentHour, valor);
               ObjectSetInteger(0, precobuy, OBJPROP_WIDTH, 2);
               ObjectSetInteger(0, precobuy, OBJPROP_STYLE, STYLE_SOLID);
               ObjectSetInteger(0, precobuy, OBJPROP_COLOR, cor_de_linhas);
            }
         else
            {
               ObjectCreate(0, precobuy, OBJ_HLINE, 0, 0, valor);
               ObjectSetInteger(0, precobuy, OBJPROP_WIDTH, 2);
               ObjectSetInteger(0, precobuy, OBJPROP_STYLE, STYLE_SOLID);
               ObjectSetInteger(0, precobuy, OBJPROP_COLOR, cor_de_linhas);
            }
      }
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void criarlinhaequador_baixa(double valor)
{
   string quador_baixa = "LINHA_DE_EQUADOR_" + DoubleToString(valor, ddd);
   bool uniequabaixa = true;
   for(int i = 0; i < ArraySize(listaequador); i++)
      {
         if(listaequador[i] == valor)
            {
               uniequabaixa = false ;
               break;
            }
      }
   if(uniequabaixa)
      {
         int currentSize = ArraySize(listaequador);
         ArrayResize(listaequador, currentSize + 1);
         listaequador[currentSize] = valor;
         ObjectCreate(0, quador_baixa, OBJ_HLINE, 0, 0, valor);
         ObjectSetInteger(0, quador_baixa, OBJPROP_STYLE, STYLE_SOLID);
         ObjectSetInteger(0, quador_baixa, OBJPROP_COLOR, corr_de_equador);
      }
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void criarlinhaequador_cento(double valor)
{
   string centro = "LINHA_DE_EQUADOR_50%_" + DoubleToString(valor, ddd);
   bool unicentrobaixa = true;
   for(int i = 0; i < ArraySize(listaequador); i++)
      {
         if(listaequador[i] == valor)
            {
               unicentrobaixa = false ;
               break;
            }
      }
   if(unicentrobaixa)
      {
         int currentSize = ArraySize(listaequador);
         ArrayResize(listaequador, currentSize + 1);
         listaequador[currentSize] = valor;
         ObjectCreate(0, centro, OBJ_HLINE, 0, 0, valor);
         ObjectSetInteger(0, centro, OBJPROP_STYLE, STYLE_DASH);
         ObjectSetInteger(0, centro, OBJPROP_COLOR, corr_de_equador);
      }
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void criarlinhaequador_alta(double valor)
{
   string equador_alta = "LINHA_DE_EQUADOR_" + DoubleToString(valor, ddd);
   bool uniequadoralta = true;
   for(int i = 0; i < ArraySize(listaequador); i++)
      {
         if(listaequador[i] == valor)
            {
               uniequadoralta = false ;
               break;
            }
      }
   if(uniequadoralta)
      {
         int currentSize = ArraySize(listaequador);
         ArrayResize(listaequador, currentSize + 1);
         listaequador[currentSize] = valor;
         ObjectCreate(0, equador_alta, OBJ_HLINE, 0, 0, valor);
         ObjectSetInteger(0, equador_alta, OBJPROP_STYLE, STYLE_SOLID);
         ObjectSetInteger(0, equador_alta, OBJPROP_COLOR, corr_de_equador);
      }
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+


// Função para verificar o motivo de fechamento de uma negociação
string CheckDealReason(ulong deal_id)
{
// Obtemos o motivo de encerramento do negócio
   int reason = (int) HistoryDealGetInteger(deal_id, DEAL_REASON);
// Obtém o lucro da negociação
   double  lastDealProfit = HistoryDealGetDouble(deal_id, DEAL_PROFIT);
// Verificamos o motivo do encerramento
   switch(reason)
      {
      case DEAL_REASON_TP: // Caso tenha atingido o Take Profit
         return "Take Profit atingido";
      case DEAL_REASON_SL: // Caso tenha atingido o Stop Loss
         return "Stop Loss atingido";
      default: // Outros motivos (ex.: fechamento manual)
         return "  manual ";
      }
}


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void funcao_verifica_meta_ou_perda_atingida()
{
   double tmpValor_Maximo_Ganho ; //tmpValor_Maximo_Ganho = valor estipulado de meta do  dia
   double tmpValorMaximoPerda  ;  //tmpValorMaximoPerda = valor máximo desejado como perda máxima
   double tmp_resultado_financeiro_dia = 0.0;
   string tmp_x;
//resulporcentoss;
   int    tmp_contador;
   double posetivo;
   contol_de_gerenciamento = true;
// obter saldo desponivel na conta
   double saldototal = AccountInfoDouble(ACCOUNT_BALANCE);
   MqlDateTime    tmp_data_b;
   TimeCurrent(tmp_data_b);
   tmp_resultado_financeiro_dia = 0;
   tmp_x = string(tmp_data_b.year) + "." + string(tmp_data_b.mon) + "." + string(tmp_data_b.day) + " 00:00:01";
   HistorySelect(StringToTime(tmp_x), TimeCurrent());
   int      tmp_total = HistoryDealsTotal();
   ulong    tmp_ticket = 0;
   double   tmp_price;
   double   tmp_profit;
   datetime tmp_time;
   string   tmp_symboll;
   long     tmp_typee;
   long     tmp_entry;
//--- para todos os negócios
   for(tmp_contador = 0; tmp_contador < tmp_total; tmp_contador++)
      {
         //--- tentar obter ticket negócios
         if((tmp_ticket = HistoryDealGetTicket(tmp_contador)) > 0)
            {
               //--- obter as propriedades negócios
               tmp_price = HistoryDealGetDouble(tmp_ticket, DEAL_PRICE);
               tmp_time  = (datetime)HistoryDealGetInteger(tmp_ticket, DEAL_TIME);
               tmp_symboll = HistoryDealGetString(tmp_ticket, DEAL_SYMBOL);
               tmp_typee  = HistoryDealGetInteger(tmp_ticket, DEAL_TYPE);
               tmp_entry = HistoryDealGetInteger(tmp_ticket, DEAL_ENTRY);
               tmp_profit = HistoryDealGetDouble(tmp_ticket, DEAL_PROFIT);
               if(tmp_symboll == Symbol())   //--- apenas para o símbolo atual
                  {
                     tmp_resultado_financeiro_dia = tmp_resultado_financeiro_dia + tmp_profit;
                  }
            }
      }
   posetivo = tmp_resultado_financeiro_dia;
   if(SALDO == 00.0)
      {
         // calculos de porcentagem para preda
         tmpValorMaximoPerda = saldototal * g_param_porcentos / -100.0;
         tmpValor_Maximo_Ganho  = saldototal * g_param_porcentosg / 100.0;
      }
   else
      {
         tmpValorMaximoPerda = SALDO * g_param_porcentos / -100.0;
         tmpValor_Maximo_Ganho  = SALDO * g_param_porcentosg / 100.0;
      }
   if(g_param_gerenc_diario == false)
      {
         placar = false;
         placarx = false ;
         placarw = false ;
         placarfw = false ;
         placarfl = false ;
         mostra =  "gestao diário desativado ";
      }
   else
      {
         if(SALDO > 0)
            {
               resulporcentoss = (tmp_resultado_financeiro_dia / SALDO) * 100;
               calcol = tmp_resultado_financeiro_dia * g_param_cambio ;
            }
         else
            {
               resulporcentoss = (tmp_resultado_financeiro_dia / saldototal) * 100;
               calcol = tmp_resultado_financeiro_dia * g_param_cambio ;
            }
      }
   if(tmp_resultado_financeiro_dia == 0)
      {
         if(placar == true)
            {
               inib = true;
               tmp_placar = true;
               tmp_placarx = true ;
               tmp_placarw = true ;
               tmp_placarfw = true ;
               tmp_placarfl = true ;
               placar = true;
               placarx = true ;
               placarw = true ;
               placarfw = true ;
               placarfl = true ;
               mostra =   " gestao diario ativado: sem lucro ";
               placar = false;
            }
      }
   else
      {
         if(tmp_resultado_financeiro_dia > 0)
            {
               if(placarw == true)
                  {
                     mostra = " lucro diário ";
                  }
               placarw = false;
               if(tmp_resultado_financeiro_dia > tmpValor_Maximo_Ganho)
                  {
                     if(g_param_gerenc_diario == true)
                        {
                           contol_de_gerenciamento = false;
                        }
                     if(placarfw == true)
                        {
                           mostra = " lucro diário atingido ";
                        }
                     placarfw = false;
                  }
            }
         else
            {
               if(placarx == true)
                  {
                     mostra = " prejuízo diário ";
                  }
               placarx = false;
               if(tmp_resultado_financeiro_dia < tmpValorMaximoPerda)
                  {
                     if(g_param_gerenc_diario == true)
                        {
                           contol_de_gerenciamento = false;
                        }
                     if(placarfl == true)
                        {
                           mostra = " prejuízo diário atingido ";
                        }
                     placarfl = false;
                  }
            }
      }
}
string context  =
   "🔎 Esta análise apresenta os resultados percentuais financeiros mais recentes, permitindo uma visão clara dos resultados obtidos.\n" +
   "📈 Se os percentuais forem positivos, significa que houve um lucro. Caso contrário, uma análise mais detalhada pode ser necessária.\n" +
   "💡 Lembre-se: **monitorar os dados regularmente ajuda na tomada de decisões mais estratégicas e assertivas.**\n\n" +

   "✅ *Dica Importante:* Considere avaliar a tendência geral antes de tomar qualquer decisão. O mercado pode apresentar variações, e cada número conta!\n\n" +

   "🚀 *Siga acompanhando os resultados e continue avançando!*";
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
datetime GetStartOfWeek()
{
   MqlDateTime tmp_data;
   TimeCurrent(tmp_data);
   int day_of_week = tmp_data.day_of_week;
// Subtrai os dias passados desde o domingo
   tmp_data.day -= day_of_week;
   tmp_data.hour = 0;
   tmp_data.min = 0;
   tmp_data.sec = 0;
   return StructToTime(tmp_data);
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void UpdateWeeklyResult()
{
   string symbol = Symbol() ;
   datetime start_of_week = GetStartOfWeek();
   double tmp_resultado_financeiro_semana;
   resulporcentos = 0.0;
   double tmpValor_Maximo_Ganhow = 0.0;  // Valor máximo de ganho diário
   double tmpValorMaximoPerdaw = 0.0;    // Valor máximo de perda diária
   HistorySelect(start_of_week, TimeCurrent());
   int total_trades_week = HistoryDealsTotal();
   tmp_resultado_financeiro_semana = 0;
   contol_de_gerenciamento_semanal = true;
// obter saldo desponivel na conta
   double saldototal = AccountInfoDouble(ACCOUNT_BALANCE);
   for(int tmp_contador = 0; tmp_contador < total_trades_week; tmp_contador++)
      {
         ulong tmp_ticket = HistoryDealGetTicket(tmp_contador);
         if(tmp_ticket > 0)
            {
               string tmp_symboll = HistoryDealGetString(tmp_ticket, DEAL_SYMBOL);
               double tmp_profit = HistoryDealGetDouble(tmp_ticket, DEAL_PROFIT);
               if(tmp_symboll == symboll)
                  {
                     tmp_resultado_financeiro_semana += tmp_profit;
                  }
            }
      }
   if(SALDO == 00.0)
      {
         //calculos de porcentagem para preda
         tmpValorMaximoPerdaw = saldototal *  g_param_porcentoo / -100.0;
         tmpValor_Maximo_Ganhow  = saldototal * g_param_porcentoss / 100.0;
      }
   else
      {
         tmpValorMaximoPerdaw = SALDO *  g_param_porcentoo / -100.0;
         tmpValor_Maximo_Ganhow  = SALDO * g_param_porcentoss / 100.0;
      }
   if(g_param_gerenc_semanal == false)
      {
         tmp_placar = false;
         tmp_placarx = false ;
         tmp_placarw = false ;
         tmp_placarfw = false ;
         tmp_placarfl = false ;
         mostraw = " gestao semanal desativado ";//
         if(inib == true)
            {
               int index = MathRand() % ArraySize(emotionalControlSecrets);
               motiva =  emotionalControlSecrets[index];
               Comment(mostraw +  DoubleToString(NormalizeDouble(calcll, 2), 2) + " " + g_param_moeda + " \n "
                       + DoubleToString(NormalizeDouble(resulporcentos, 2), 2) + " %  \n  " + mostra +  DoubleToString(NormalizeDouble(calcol, 2), 2) + " " + g_param_moeda + " \n "
                       + DoubleToString(NormalizeDouble(resulporcentoss, 2), 2) + " % ");
               //enviar email
               SendMailMQL5("✅ confirmado",
                            "<html>"
                            "<body style='font-family: Times New Roman, serif; font-size: 12px; color: #222; background-color: #f7f7f7;'>"
                            "<div style='background-color: #eaeaea;border-radius: 20px;padding: 20px; box-shadow: 0px 0px 5px rgba(0.4,0.4,0.4,0.4);'>"
                            "<h2 style='text-align: center; border-bottom: 2px solid #666; padding-bottom: 10px;'>EA fimaster</h2>"
                            "<div style='background-color: #dcdcdc; padding: 15px; border-radius: 5px; margin-bottom: 10px; border: 1px solid #bbb;'>"
                            "<h3 style='text-align: center;'>📅 Dia da Semana</h3>"
                            "<p style='text-align: center; font-weight: bold;'>" + DayOfWeek(current) + " " + (string)current_time + "</p>"
                            "</div>"
                            "<div style='background-color: #f2f2f2; padding: 15px; border-radius: 5px; margin-bottom: 10px; border: 1px solid #bbb;'>"
                            "<h3 style='text-align: center;'>🏆 Dica de Ouro</h3>"
                            "<p style='text-align: center; font-weight: bold;'>" + motiva + "</p>"
                            "</div>"
                            "<div style='background-color: #dcdcdc; padding: 15px; border-radius: 5px; margin-bottom: 10px; border: 1px solid #bbb;'>"
                            "<h3 style='text-align: center;'>📊 Análise de Gerenciamento Diário</h3>"
                            "<ul style='list-style: none; padding: 0;'>"
                            "<li style='border-bottom: 1px solid #bbb; padding: 3px;'><b></b></span></li>"
                            "<li style='border-bottom: 1px solid #bbb; padding: 3px;'><b>💰 Valor:</b> <span style='float: right;'>" + mostra + " " + DoubleToString(NormalizeDouble(calcol, 2), 2) + " " + g_param_moeda + "</span></li>"
                            "<li style='border-bottom: 1px solid #bbb; padding: 3px;'><b>📈 Percentual:</b> <span style='float: right;'>" + DoubleToString(NormalizeDouble(resulporcentoss, 2), 2) + " %</span></li>"
                            "</ul>"
                            "</div>"
                            "<div style='background-color: #f2f2f2; padding: 15px; border-radius: 5px; border: 1px solid #bbb;'>"
                            "<h3 style='text-align: center;'>📢 Resumo</h3>"
                            "<p style='text-align: center;'>" + context + "</p>"
                            "</div>"
                            "<h3 style='text-align: center; border-top: 2px solid #666; padding-top: 10px;'>✅ Mantenha-se atento às notificações.</h3>"
                            "</div>"
                            "</div>"
                            "<div style='margin-top: 20px; text-align: center; border-top: 1px solid #bbb; padding-top: 10px; font-size: 14px; color: #555;'>"
                            "<p>Atenciosamente</p>"
                            "<p><b>jossias Macucul</b></p>"
                            "<img src='https://scontent.fmpm1-1.fna.fbcdn.net/v/t39.30808-6/491938161_2507846312884992_8093885575213355777_n.jpg?stp=dst-jpg_p526x296_tt6&_nc_cat=109&ccb=1-7&_nc_sid=833d8c&_nc_eui2=AeFaUXxHomop_5plv_dU571rgcvTQfIUGm-By9NB8hQab6GWoLSk5w_LkpI_i21bHgzj9nblk1VuaB2zyAJHdqCv&_nc_ohc=qbXLUyP6vvkQ7kNvwH4B0ZV&_nc_oc=AdncZn_ien4k3aNn-ybH4Emnmd5CI4rDx6auDyOAY_pjgVYvR8_pUxi3leZs4BwKUgc&_nc_pt=5&_nc_zt=23&_nc_ht=scontent.fmpm1-1.fna&_nc_gid=SQpVoEHFfm4kjhoh5PpiVg&oh=00_AfHt3opt4pL2tPVHzkgAQupSyxBa08n129SIAldVhH9nYA&oe=680874C6'alt='Logo' style='width: 100px; margin-top: 10px;'>"
                            "</div>"
                            "</body></html>"
                           );
               inib = false;
            }
      }
   else
      {
         if(SALDO > 0)
            {
               calcll = tmp_resultado_financeiro_semana * g_param_cambio;
               resulporcentos = (tmp_resultado_financeiro_semana / SALDO) * 100;
            }
         else
            {
               calcll = tmp_resultado_financeiro_semana * g_param_cambio;
               resulporcentos = (tmp_resultado_financeiro_semana / saldototal) * 100;
            }
      }
// Lógica adicional para gerenciamento de risco baseado no resultado financeiro semanal
   if(tmp_resultado_financeiro_semana == 0)
      {
         if(tmp_placar == true)
            {
               mostraw = " gestao semanal ativado: sem lucro ";
               Comment(mostraw + "\n" + mostra);
               tmp_placar = false;
            }
         return;
      }
   else
      {
         if(tmp_resultado_financeiro_semana > 0)
            {
               if(tmp_placarw == true)
                  {
                     int index = MathRand() % ArraySize(emotionalControlSecrets);
                     motiva =  emotionalControlSecrets[index];
                     mostraw =  " lucro semanal ";
                     Comment(mostraw +  DoubleToString(NormalizeDouble(calcll, 2), 2) + " " + g_param_moeda + " \n "
                             + DoubleToString(NormalizeDouble(resulporcentos, 2), 2) + " % \n  " + mostra +  DoubleToString(NormalizeDouble(calcol, 2), 2) + " " + g_param_moeda + " \n "
                             + DoubleToString(NormalizeDouble(resulporcentoss, 2), 2) + " % ");
                     //enviar email
                     EnviarEmailRelatorio(current, current_time, motiva, mostra, calcol, g_param_moeda, resulporcentoss, mostraw, calcll, resulporcentos, context);
                     tmp_placarw = false;
                  }
               if(tmp_resultado_financeiro_semana > tmpValor_Maximo_Ganhow)
                  {
                     if(g_param_gerenc_semanal == true)
                        {
                           contol_de_gerenciamento_semanal = false;
                        }
                     if(tmp_placarfw == true)
                        {
                           int index = MathRand() % ArraySize(emotionalControlSecrets);
                           motiva =  emotionalControlSecrets[index];
                           mostraw = " lucro semanal atingido " ;
                           Comment(mostraw +  DoubleToString(NormalizeDouble(calcll, 2), 2) + " " + g_param_moeda + " \n "
                                   + DoubleToString(NormalizeDouble(resulporcentos, 2), 2) + " % \n  " + mostra +  DoubleToString(NormalizeDouble(calcol, 2), 2) + " " + g_param_moeda + " \n "
                                   + DoubleToString(NormalizeDouble(resulporcentoss, 2), 2) + " % ");
                           //enviar email
                           EnviarEmailRelatorio(current, current_time, motiva, mostra, calcol, g_param_moeda, resulporcentoss, mostraw, calcll, resulporcentos, context);
                           tmp_placarfw = false;
                        }
                     return;
                  }
            }
         else
            {
               if(tmp_placarx == true)
                  {
                     int index = MathRand() % ArraySize(motivationalMessages);
                     motiva =  motivationalMessages[index];
                     mostraw = " prejuízo semanal ";
                     Comment(mostraw  +  DoubleToString(NormalizeDouble(calcll, 2), 2) + " " + g_param_moeda + " \n "
                             + DoubleToString(NormalizeDouble(resulporcentos, 2), 2) + " % \n  " + mostra +  DoubleToString(NormalizeDouble(calcol, 2), 2) + " " + g_param_moeda + " \n "
                             + DoubleToString(NormalizeDouble(resulporcentoss, 2), 2) + " % ");
                     //enviar email
                     EnviarEmailRelatorio(current, current_time, motiva, mostra, calcol, g_param_moeda, resulporcentoss, mostraw, calcll, resulporcentos, context);
                     tmp_placarx = false;
                  }
               if(tmp_resultado_financeiro_semana < tmpValorMaximoPerdaw)
                  {
                     if(g_param_gerenc_semanal == true)
                        {
                           contol_de_gerenciamento_semanal = false;
                        }
                     if(tmp_placarfl == true)
                        {
                           int index = MathRand() % ArraySize(motivationalMessages);
                           motiva =  motivationalMessages[index];
                           mostraw = " prejuízo semanal atingido ";
                           Comment(mostraw +  DoubleToString(NormalizeDouble(calcll, 2), 2) + " " + g_param_moeda + " \n "
                                   + DoubleToString(NormalizeDouble(resulporcentos, 2), 2) + " % \n  " + mostra +  DoubleToString(NormalizeDouble(calcol, 2), 2) + " " + g_param_moeda + " \n "
                                   + DoubleToString(NormalizeDouble(resulporcentoss, 2), 2) + " % ");
                           //enviar email
                           EnviarEmailRelatorio(current, current_time, motiva, mostra, calcol, g_param_moeda, resulporcentoss, mostraw, calcll, resulporcentos, context);
                           tmp_placarfl = false;
                        }
                     return;
                  }
            }
      }
}

//+------------------------------------------------------------------+
//| Função para enviar email formatado                              |
//+------------------------------------------------------------------+
void EnviarEmailRelatorio(datetime currentj,
                          datetime current_timej,
                          string motivaj,
                          string mostraj,
                          double calcolj,
                          string monyj,
                          double resulporcentossj,
                          string mostrawj,
                          double calcllj,
                          double resulporcentosj,
                          string contextj)
{
   string assunto = "✅ confirmado";
   string corpo =
      "<html>"
      "<body style='font-family: Times New Roman, serif; font-size: 12px; color: #222; background-color: #f7f7f7;'>"
      "<div style='background-color: #eaeaea;border-radius: 20px; padding: 20px; box-shadow: 0px 0px 5px rgba(0.4,0.4,0.4,0.4);'>"
      "<h2 style='text-align: center; border-bottom: 2px solid #666; padding-bottom: 10px;'>""EA fimaster""</h2>"
      "<div style='background-color: #dcdcdc; padding: 15px; border-radius: 5px; margin-bottom: 10px; border: 1px solid #bbb;'>"
      "<h3 style='text-align: center;'>📅 Dia da Semana</h3>"
      "<p style='text-align: center; font-weight: bold;'>" + DayOfWeek(currentj) + " " + (string) current_timej + "</p>"
      "</div>"
      "<div style='background-color: #f2f2f2; padding: 15px; border-radius: 5px; margin-bottom: 10px; border: 1px solid #bbb;'>"
      "<h3 style='text-align: center;'>🏆 Dica de Ouro</h3>"
      "<p style='text-align: center; font-weight: bold;'>" + motivaj + "</p>"
      "</div>"
      "<div style='background-color:#dcdcdc ; padding: 15px; border-radius: 5px; margin-bottom: 10px; border: 1px solid #bbb;'>"
      "<h3 style='text-align: center;'>📊 Análise de Gerenciamento Diário</h3>"
      "<ul style='list-style: none; padding: 0;'>"
      "<li style='border-bottom: 1px solid #bbb; padding: 3px;'><b>💰 Valor:</b> <span style='float: right;'>" + mostraj + " " + DoubleToString(NormalizeDouble(calcolj, 2), 2) + " " + monyj + "</span></li>"
      "<li style='border-bottom: 1px solid #bbb; padding: 3px;'><b>📉 Percentual:</b> <span style='float: right;'>" + DoubleToString(NormalizeDouble(resulporcentossj, 2), 2) + " %</span></li>"
      "</ul>"
      "</div>"
      "<div style='background-color: #f2f2f2; padding: 15px; border-radius: 5px; margin-bottom: 10px; border: 1px solid #bbb;'>"
      "<h3 style='text-align: center;'>📊 Análise de Gerenciamento Semanal</h3>"
      "<ul style='list-style: none; padding: 0;'>"
      "<li style='border-bottom: 1px solid #bbb; padding: 3px;'><b>💰 Valor:</b> <span style='float: right;'>" + mostrawj + " " + DoubleToString(NormalizeDouble(calcllj, 2), 2) + " " + monyj + "</span></li>"
      "<li style='border-bottom: 1px solid #bbb; padding: 3px;'><b>📉 Percentual:</b> <span style='float: right;'>" + DoubleToString(NormalizeDouble(resulporcentosj, 2), 2) + " %</span></li>"
      "</ul>"
      "</div>"
      "<div style='background-color: #dcdcdc; padding: 15px; border-radius: 5px; border: 1px solid #bbb;'>"
      "<h3 style='text-align: center;'>📢 Resumo</h3>"
      "<p style='text-align: center;'>" + contextj + "</p>"
      "</div>"
      "<h3 style='text-align: center; border-top: 2px solid #666; padding-top: 10px;'>✅ Mantenha-se atento às notificações.</h3>"
      "</div>"
      "<div style='margin-top: 20px; text-align: center; border-top: 1px solid #bbb; padding-top: 10px; font-size: 14px; color: #555;'>"
      "<p>Atenciosamente</p>"
      "<p><b>Jossias Macucul</b></p>"
      "<img src='https://scontent.fmpm1-1.fna.fbcdn.net/...jpg' alt='Logo' style='width: 100px; margin-top: 10px;'>"
      "</div>"
      "</body></html>";
// JSON Payload para relatório financeiro
   string payload = StringFormat(
                       "{\"event\":\"relatorio_financeiro\",\"symbol\":\"%s\",\"data\":\"%s\",\"hora\":\"%s\",\"motivacao\":\"%s\",\"moeda\":\"%s\",\"diario_status\":\"%s\",\"diario_valor\":%.2f,\"diario_pct\":%.2f,\"semanal_status\":\"%s\",\"semanal_valor\":%.2f,\"semanal_pct\":%.2f,\"resumo\":\"%s\",\"timestamp\":%d}",
                       _Symbol,
                       TimeToString(currentj, TIME_DATE),
                       TimeToString(current_timej, TIME_SECONDS),
                       motivaj,
                       monyj,
                       mostraj,
                       DoubleToString(NormalizeDouble(calcolj, 2), 2),
                       DoubleToString(NormalizeDouble(resulporcentossj, 2), 2),
                       mostrawj,
                       DoubleToString(NormalizeDouble(calcllj, 2), 2),
                       DoubleToString(NormalizeDouble(resulporcentosj, 2), 2),
                       contextj,
                       (int)TimeCurrent()
                    );
   EnviarPutHTTP(ObterEventosEndpointFirebase("relatorio_financeiro"), payload);
// Enviar email
   SendMailMQL5(assunto, corpo);
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void EnviarEmailInicializacao()
{
   string assunto =
      "🚀 EA FIMASTER INICIALIZADO - " + _Symbol;
   string msg =
      "<html>"
      "<body style='font-family: Times New Roman, serif; font-size:12px; color:#222; background-color:#f7f7f7;'>"
      "<div style='background-color:#eaeaea; border-radius:20px; padding:20px;"
      "box-shadow:0px 0px 5px rgba(0.4,0.4,0.4,0.4);'>"
      "<h2 style='text-align:center; border-bottom:2px solid #666; padding-bottom:10px;'>"
      "🚀 RELATÓRIO COMPLETO DE INICIALIZAÇÃO EA FIMASTER دُنْيَا "
      "</h2>"
////////////////////////////////////////////////////
// 👤 CONTA
////////////////////////////////////////////////////
      "<div style='background-color:#f2f2f2; padding:15px; border-radius:5px; margin-bottom:10px; border:1px solid #bbb;'>"
      "<h3 style='text-align:center;'>👤 Conta</h3>"
      "<ul style='list-style:none; padding:0;'>"
      "<li style='border-bottom:1px solid #bbb; padding:3px;'>""<b>Login:</b><span style='float:right;'>" + IntegerToString(AccountInfoInteger(ACCOUNT_LOGIN)) + "</span>""</li>"
      "<li style='border-bottom:1px solid #bbb; padding:3px;'>""<b>Servidor:</b><span style='float:right;'>" + AccountInfoString(ACCOUNT_SERVER) + "</span>""</li>"
      "<li style='border-bottom:1px solid #bbb; padding:3px;'>""<b>Ativo:</b><span style='float:right;'>" + _Symbol + "</span>""</li>"
      "<li style='border-bottom:1px solid #bbb; padding:3px;'>""<b>Timeframe:</b><span style='float:right;'>" + EnumToString((ENUM_TIMEFRAMES)_Period) + "</span>""</li>"
      "<li style='border-bottom:1px solid #bbb; padding:3px;'>""<b>Moeda:</b><span style='float:right;'>" + AccountInfoString(ACCOUNT_CURRENCY) + "</span>""</li>"
      "<li style='border-bottom:1px solid #bbb; padding:3px;'>""<b>Saldo:</b><span style='float:right;'>" + DoubleToString(AccountInfoDouble(ACCOUNT_BALANCE), 2) + "</span>""</li>"
      "</ul></div>"
////////////////////////////////////////////////////
// 🎯 ESTRATÉGIA
////////////////////////////////////////////////////
      "<div style='background-color:#dcdcdc; padding:15px; border-radius:5px; margin-bottom:10px; border:1px solid #bbb;'>"
      "<h3 style='text-align:center;'>🎯 Estratégia</h3>"
      "<ul style='list-style:none; padding:0;'>"
      "<li style='border-bottom:1px solid #bbb; padding:3px;'>""<b>Tri_exp_moving average 9 / 21:</b>""<span style='float:right;'>" + (TEMA ? "ATIVADO" : "DESATIVADO") + "</span>" "</li>"
      "<li style='border-bottom:1px solid #bbb; padding:3px;'>""<b>Linha de equador:</b>""<span style='float:right;'>" + (g_param_linhas_eq ? "ATIVADO" : "DESATIVADO") + "</span>" "</li>"
      "<li style='border-bottom:1px solid #bbb; padding:3px;'>""<b>Tendência:</b>""<span style='float:right;'>" + (g_param_linhas_eq ?  EnumToString(g_param_tendencia) : "DESATIVADO") + "</span>" "</li>"
      "<li style='border-bottom:1px solid #bbb; padding:3px;'>""<b>Estratégia:</b>""<span style='float:right;'>" + EnumToString(g_param_estrategia) + "</span>""</li>"
      "<li style='border-bottom:1px solid #bbb; padding:3px;'>""<b>Virada de Jogo:</b><span style='float:right;'>" + (g_param_virada_jogo ? "ATIVADO" : "DESATIVADO") + "</span>""</li>"
      "<li style='border-bottom:1px solid #bbb; padding:3px;'>""<b>Níveis:</b><span style='float:right;'>" + DoubleToString(g_param_niveis, 0) + "</span>""</li>"
      "<li style='border-bottom:1px solid #bbb; padding:3px;'>""<b>Costurar:</b><span style='float:right;'>" + (g_param_costurar ? "ATIVADO" : "DESATIVADO") + "</span>""</li>"
      "<li style='border-bottom:1px solid #bbb; padding:3px;'>""<b>Período Operacional:</b><span style='float:right;'>" + EnumToString(PeriodoOperacional) + "</span>""</li>"
      "<li style='border-bottom:1px solid #bbb; padding:3px;'>""<b>Lote:</b><span style='float:right;'>" + DoubleToString(g_param_lote, 2) + "</span>""</li>"
      "</ul></div>"
////////////////////////////////////////////////////
// 🤖 AUTOMAÇÃO
////////////////////////////////////////////////////
      "<div style='background-color:#f2f2f2; padding:15px; border-radius:5px; margin-bottom:10px; border:1px solid #bbb;'>"
      "<h3 style='text-align:center;'>🤖 Automação</h3>"
      "<ul style='list-style:none; padding:0;'>"
      "<li style='border-bottom:1px solid #bbb; padding:3px;'>""<b>Auto Trading:</b><span style='float:right;'>" + (g_param_ea_auto ? "ATIVADO" : "DESATIVADO") + "</span>""</li>"
      "<li style='border-bottom:1px solid #bbb; padding:3px;'>""<b>Auto Período:</b><span style='float:right;'>" + EnumToString(g_param_auto_periodo) + "</span>""</li>"
      "<li style='border-bottom:1px solid #bbb; padding:3px;'>""<b>Pcm:</b><span style='float:right;'>" + (g_param_auto_surfada ? "ATIVADO" : "DESATIVADO") + "</span>""</li>"
      "<li style='border-bottom:1px solid #bbb; padding:3px;'>""<b>Sessão asia_toquio:</b><span style='float:right;'>" + (g_param_sessao_asia ? "ATIVADO" : "DESATIVADO") + "</span>""</li>"
      "<li style='border-bottom:1px solid #bbb; padding:3px;'>""<b>Sessão londres:</b><span style='float:right;'>" + (g_param_sessao_londres ? "ATIVADO" : "DESATIVADO") + "</span>""</li>"
      "<li style='border-bottom:1px solid #bbb; padding:3px;'>""<b>Sessão nova_yorqui:</b><span style='float:right;'>" + (g_param_sessao_ny ? "ATIVADO" : "DESATIVADO") + "</span>""</li>"
      "<li style='border-bottom:1px solid #bbb; padding:3px;'>""<b>Expansão minima:</b><span style='float:right;'>" + IntegerToString(g_param_expansao_min) + "</span>""</li>"
      "<li style='border-bottom:1px solid #bbb; padding:3px;'>""<b>Expansão maxima:</b><span style='float:right;'>" + IntegerToString(g_param_expansao_max) + "</span>""</li>"
      "</ul></div>"
////////////////////////////////////////////////////
// 💰 RISCO
////////////////////////////////////////////////////
      "<div style='background-color:#dcdcdc; padding:15px; border-radius:5px; margin-bottom:10px; border:1px solid #bbb;'>"
      "<h3 style='text-align:center;'>💰 Gestão de Risco</h3>"
      "<ul style='list-style:none; padding:0;'>"
      "<li style='border-bottom:1px solid #bbb; padding:3px;'>""<b>Gerenciamento Diário:</b><span style='float:right;'>" + (g_param_gerenc_diario ? "ATIVADO" : "DESATIVADO") + "</span>""</li>"
      "<li style='border-bottom:1px solid #bbb; padding:3px;'>""<b>Perda Dia:</b><span style='float:right;'>" + (g_param_gerenc_diario ? DoubleToString(g_param_porcentos, 2) + "%" : "DESATIVADO") + "</span>""</li>"
      "<li style='border-bottom:1px solid #bbb; padding:3px;'>""<b>Ganho Dia:</b><span style='float:right;'>" + (g_param_gerenc_diario  ?  DoubleToString(g_param_porcentosg, 2) + "% " : "DESATIVADO") + " </span>""</li>"
      "<li style='border-bottom:1px solid #bbb; padding:3px;'>""<b>Gerenciamento Semanal:</b><span style='float:right;'>" + (g_param_gerenc_semanal ? "ATIVADO" : "DESATIVADO") + "</span>""</li>"
      "<li style='border-bottom:1px solid #bbb; padding:3px;'>""<b>Perda Semana:</b><span style='float:right;'>" + (g_param_gerenc_semanal ?  DoubleToString(g_param_porcentoo, 2) + "%" :  "DESATIVADO") + "</span>""</li>"
      "<li style='border-bottom:1px solid #bbb; padding:3px;'>""<b>Ganho Semana:</b><span style='float:right;'>" + (g_param_gerenc_semanal ? DoubleToString(g_param_porcentoss, 2) + "%" : "DESATIVADO") + "</span>""</li>"
      "</ul></div>"
////////////////////////////////////////////////////
// ⚙ EXECUÇÃO
////////////////////////////////////////////////////
      "<div style='background-color:#f2f2f2; padding:15px; border-radius:5px; margin-bottom:10px; border:1px solid #bbb;'>"
      "<h3 style='text-align:center;'>⚙ Execução</h3>"
      "<ul style='list-style:none; padding:0;'>"
      "<li style='border-bottom:1px solid #bbb; padding:3px;'>""<b>G-mail:</b><span style='float:right;'>" + (g_param_gmail ? "ATIVADO" : "DESATIVADO") + "</span>""</li>"
      "<li style='border-bottom:1px solid #bbb; padding:3px;'>""<b>notificação:</b><span style='float:right;'>" + (g_param_notific ? "ATIVADO" : "DESATIVADO") + "</span>""</li>"
      "<li style='border-bottom:1px solid #bbb; padding:3px;'>""<b>Compra:</b><span style='float:right;'>" + (g_param_ativar_compra ? "ATIVADO" : "DESATIVADO") + "</span>""</li>"
      "<li style='border-bottom:1px solid #bbb; padding:3px;'>""<b>Venda:</b><span style='float:right;'>" + (g_param_ativar_venda ? "ATIVADO" : "DESATIVADO") + "</span>""</li>"
      "<li style='border-bottom:1px solid #bbb; padding:3px;'>""<b>SL 0x0:</b><span style='float:right;'>" + (g_param_modify_sl ? "ATIVADO" : "DESATIVADO") + "</span>""</li>"
      "<li style='border-bottom:1px solid #bbb; padding:3px;'>""<b>Romp. Compra:</b><span style='float:right;'>" + (g_param_rompimento_c ? "ATIVADO" : "DESATIVADO") + "</span>""</li>"
      "<li style='border-bottom:1px solid #bbb; padding:3px;'>""<b>Romp. Venda:</b><span style='float:right;'>" + (g_param_rompimento_v ? "ATIVADO" : "DESATIVADO") + "</span>""</li>"
      "</ul></div>"
////////////////////////////////////////////////////
// 📢 FINAL
////////////////////////////////////////////////////
      "<div style='background-color:#f2f2f2; padding:15px; border-radius:5px; border:1px solid #bbb;'>"
      "<h3 style='text-align:center;'>📢 Sistema</h3>"
      "<p style='text-align:center;'>EA iniciado com sucesso. Sistema pronto para operar conforme regras definidas.</p>"
      "</div>"
      "<h3 style='text-align:center; border-top:2px solid #666; padding-top:10px;'>"
      "✅ SISTEMA TOTALMENTE OPERACIONAL"
      "</h3>"
      "</div>"
      "<div style='margin-top:20px; text-align:center; border-top:1px solid #bbb; padding-top:10px; font-size:14px; color:#555;'>"
      "<p><b>EA fimaster Trading System</b></p>"
      "<p>Inicialização automática concluída</p>"
      "</div>"
      "</body>"
      "</html>";
// Constrói o JSON com os dados da conta extraída de ACCOUNT_LOGIN
   string payload = StringFormat(
                       "{\"event\":\"inicializacao\",\"symbol\":\"%s\",\"login\":%s,\"server\":\"%s\",\"timeframe\":\"%s\",\"currency\":\"%s\",\"timestamp\":%d}",
                       _Symbol,
                       ObterContaMt5Login(),
                       AccountInfoString(ACCOUNT_SERVER),
                       EnumToString((ENUM_TIMEFRAMES)_Period),
                       AccountInfoString(ACCOUNT_CURRENCY),
                       (int)TimeCurrent()
                    );
// Envia o evento de inicialização para o nó /dados/eventos/{ACCOUNT_LOGIN}.json
   EnviarPutHTTP(ObterEventosEndpointFirebase("inicializacao"), payload);
   SendMailMQL5(assunto, msg);
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//| Retorna a URL base limpa do Firebase                             |
//+------------------------------------------------------------------+
string ObterBaseUrlFirebase()
{
   string cleaned = server_url;
   int pos = StringFind(cleaned, ".firebaseio.com");
   if(pos != -1)
      {
         return StringSubstr(cleaned, 0, pos + 15);
      }
   pos = StringFind(cleaned, "/dados/");
   if(pos != -1)
      {
         return StringSubstr(cleaned, 0, pos);
      }
   while(StringLen(cleaned) > 0 && StringSubstr(cleaned, StringLen(cleaned) - 1, 1) == "/")
      {
         cleaned = StringSubstr(cleaned, 0, StringLen(cleaned) - 1);
      }
   return cleaned;
}

// Global cache for resolved user ID
string g_resolved_user_id = "";

//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//| Retorna o endpoint do nó /dados/parametros/{ACCOUNT_LOGIN}.json  |
//| Extrai a conta diretamente de ACCOUNT_LOGIN                       |
//+------------------------------------------------------------------+
string ObterConfigEndpointFirebase()
{
// Obtém a URL base limpa do Firebase Database
   string baseUrl = ObterBaseUrlFirebase();
// Extrai o número da conta MT5 usando a função ACCOUNT_LOGIN
   string loginStr = ObterContaMt5Login();
// Constrói o caminho exato do nó de parâmetros no banco de dados
   string path = StringFormat("%s/dados/parametros/%s.json", baseUrl, loginStr);
// Anexa a senha/token de autenticação caso fornecida
   if(auth_key != "")
      {
         path = path + "?auth=" + auth_key;
      }
   return path;
}

//+------------------------------------------------------------------+
//| Retorna o endpoint do nó /dados/status/{ACCOUNT_LOGIN}.json      |
//| Extrai a conta diretamente de ACCOUNT_LOGIN                       |
//+------------------------------------------------------------------+
string ObterStatusEndpointFirebase()
{
// Obtém a URL base limpa do Firebase Database
   string baseUrl = ObterBaseUrlFirebase();
// Extrai o número da conta MT5 usando a função ACCOUNT_LOGIN
   string loginStr = ObterContaMt5Login();
// Constrói o caminho do nó de status e telemetria do robô
   string path = StringFormat("%s/dados/status/%s.json", baseUrl, loginStr);
// Anexa a senha/token de autenticação caso fornecida
   if(auth_key != "")
      {
         path = path + "?auth=" + auth_key;
      }
   return path;
}

//+------------------------------------------------------------------+
//| Retorna o endpoint do nó /dados/eventos/{ACCOUNT_LOGIN}.json     |
//| Extrai a conta diretamente de ACCOUNT_LOGIN                       |
//+------------------------------------------------------------------+
string ObterEventosEndpointFirebase(string nomeEvento = "")
{
// Obtém a URL base limpa do Firebase Database
   string baseUrl = ObterBaseUrlFirebase();
// Extrai o número da conta MT5 usando a função ACCOUNT_LOGIN
   string loginStr = ObterContaMt5Login();
// Remove extensão .json caso o parâmetro nomeEvento contenha
   string cleanEvent = nomeEvento;
   int jsonPos = StringFind(cleanEvent, ".json");
   if(jsonPos != -1)
      {
         cleanEvent = StringSubstr(cleanEvent, 0, jsonPos);
      }
// Define o caminho do nó de eventos históricos
   string path = "";
   if(cleanEvent != "")
      {
         path = StringFormat("%s/dados/eventos/%s/%s.json", baseUrl, loginStr, cleanEvent);
      }
   else
      {
         path = StringFormat("%s/dados/eventos/%s.json", baseUrl, loginStr);
      }
// Anexa a senha/token de autenticação caso fornecida
   if(auth_key != "")
      {
         path = path + "?auth=" + auth_key;
      }
   return path;
}


//+------------------------------------------------------------------+
//| Lê os parâmetros do nó /dados/parametros/{ACCOUNT_LOGIN}.json    |
//| Atualiza o estado operacional e responde com confirmação de sync |
//+------------------------------------------------------------------+
void SincronizarParametrosDoApp()
{
// Se o envio HTTP estiver desativado, interrompe a leitura
   if(!enviar_http)
      {
         return;
      }
// Obtém o endpoint exato de parâmetros construído com ACCOUNT_LOGIN
   string endpoint = ObterConfigEndpointFirebase();
   if(endpoint == "")
      {
         return;
      }
   char data[];
   char result[];
   string result_headers;
   string headers = "Content-Type: application/json\r\n";
// Faz a leitura HTTP GET no nó do Firebase
   int res = WebRequest("GET", endpoint, headers, 3000, data, result, result_headers);
   if(res == 200)
      {
         string json = CharArrayToString(result);
         if(StringLen(json) > 5 && json != "null" && json != "{}")
            {
               // ====================================================================
               // 🔒 1. VERIFICAÇÃO DE SEGURANÇA E AUTENTICAÇÃO PRIMEIRO (MANDATÓRIO)
               // ====================================================================
               string senhaRecebida = ExtrairValorStringJson(json, "SENHA", "");
               if(StringLen(senhaRecebida) == 0)
                  {
                     Print("🔴 ERRO DE SEGURANÇA: Autenticação negada! Senha obrigatória do robô ausente no JSON.");
                     g_ea_ativo = false;
                     AtualizarPainelVisualStatus();
                     int agoraErro = (int)TimeCurrent();
                     string statusEndpointErro = ObterStatusEndpointFirebase();
                     if(statusEndpointErro != "")
                        {
                           string payloadErro = StringFormat(
                                                   "{\"online\":true,\"ea_ativo\":false,\"config_sync\":false,\"last_ping\":%d,\"msg\":\"🔒 ERRO DE AUTENTICAÇÃO: Senha obrigatória não fornecida! EA bloqueado por segurança.\",\"timestamp\":%d}",
                                                   agoraErro, agoraErro
                                                );
                           char postDataErro[];
                           char respResultErro[];
                           string respHeadersErro;
                           StringToCharArray(payloadErro, postDataErro, 0, StringLen(payloadErro));
                           WebRequest("PUT", statusEndpointErro, "Content-Type: application/json\r\n", 3000, postDataErro, respResultErro, respHeadersErro);
                        }
                     return;
                  }
               bool estadoAnterior = g_ea_ativo;
               // 2. Atualiza a chave "EA_ATIVO" recebida do App
               if(StringFind(json, "\"EA_ATIVO\":false") != -1 || StringFind(json, "\"EA_ATIVO\": false") != -1 ||
                     StringFind(json, "\"ea_ativo\":false") != -1 || StringFind(json, "\"ea_ativo\": false") != -1)
                  {
                     g_ea_ativo = false; // Desativa o EA
                  }
               else if(StringFind(json, "\"EA_ATIVO\":true") != -1 || StringFind(json, "\"EA_ATIVO\": true") != -1 ||
                       StringFind(json, "\"ea_ativo\":true") != -1 || StringFind(json, "\"ea_ativo\": true") != -1)
                  {
                     g_ea_ativo = true; // Ativa o EA
                  }
               // Exibe log no terminal em caso de alteração no estado de execução
               if(estadoAnterior != g_ea_ativo)
                  {
                     Print(g_ea_ativo ? "🟢 EA Fimaster ATIVADO pelo Aplicativo!" : "🔴 EA Fimaster DESATIVADO pelo Aplicativo!");
                  }
               // Atualiza a interface gráfica móvel no gráfico no canto inferior esquerdo
               AtualizarPainelVisualStatus();
               // 2. Executa a leitura dos parâmetros salvos conforme a regra
               // (Controlado exclusivamente pelo interruptor PERMITIR_LEITURA_PARAMETROS; g_ea_ativo não impede a leitura)
               bool leuParametros = CarregarParametrosSalvosApp(json);
               string msgNotificacao = "";
               if(leuParametros)
                  {
                     msgNotificacao = "🟢 Parâmetros lidos e sincronizados com sucesso pelo EA Fimaster!";
                     // 🔒 SEGURANÇA: Como o EA leu os parâmetros, altera PERMITIR_LEITURA_PARAMETROS para false no banco de dados
                     // para que o EA leia apenas UMA VEZ por solicitação de sincronização do aplicativo.
                     string paramReadEndpoint = StringFormat("%s/dados/parametros/%s/PERMITIR_LEITURA_PARAMETROS.json", ObterBaseUrlFirebase(), ObterContaMt5Login());
                     if(auth_key != "")
                        {
                           paramReadEndpoint += "?auth=" + auth_key;
                        }
                     EnviarPutHTTP(paramReadEndpoint, "false");
                     string mainParamEndpoint = ObterConfigEndpointFirebase();
                     if(mainParamEndpoint != "")
                        {
                           EnviarRequisicaoHTTP("PATCH", mainParamEndpoint, "{\"PERMITIR_LEITURA_PARAMETROS\":false}");
                        }
                  }
               else
                  {
                     msgNotificacao = "Comando do EA processado. Leitura de parâmetros ignorada (PERMITIR_LEITURA_PARAMETROS=false).";
                  }
               // 3. Prepara dados de confirmação/notificação para o nó de status
               int agora = (int)TimeCurrent();
               int fuso = ObterFusoServidor();
               string fusoTxt = ObterFusoTexto();
               string servidor = AccountInfoString(ACCOUNT_SERVER);
               double saldoDisponivel = AccountInfoDouble(ACCOUNT_BALANCE);
               string statusEndpoint = ObterStatusEndpointFirebase();
               if(statusEndpoint != "")
                  {
                     // Payload de atualização de status do EA com a mensagem de confirmação
                     string payloadSync = StringFormat(
                                             "{\"online\":true,\"ea_ativo\":%s,\"config_sync\":true,\"last_config_sync\":%d,\"last_ping\":%d,\"fuso_horario\":%d,\"fuso_texto\":\"%s\",\"symbol\":\"%s\",\"tem_posicao\":%s,\"servidor\":\"%s\",\"login\":%s,\"saldo_disponivel\":%.2f,\"msg\":\"%s\",\"timestamp\":%d}",
                                             g_ea_ativo ? "true" : "false",
                                             agora,
                                             agora,
                                             fuso,
                                             fusoTxt,
                                             symboll,
                                             ExistePosicaoAberta(symboll) ? "true" : "false",
                                             servidor,
                                             ObterContaMt5Login(),
                                             saldoDisponivel,
                                             msgNotificacao,
                                             agora
                                          );
                     // Grava diretamente no nó /dados/status/{ACCOUNT_LOGIN}.json
                     EnviarPutHTTP(statusEndpoint, payloadSync);
                  }
            }
      }
}



//| Envia o Heartbeat (Ping) ao nó /dados/status/{ACCOUNT_LOGIN}.json |
//+------------------------------------------------------------------+
void NotificarEAOnline()
{
   bool temPosicao = ExistePosicaoAberta(symboll);
   int fuso = ObterFusoServidor();
   string fusoTxt = ObterFusoTexto();
   string servidor = AccountInfoString(ACCOUNT_SERVER);
   int agora = (int)TimeCurrent();
   double saldoDisponivel = AccountInfoDouble(ACCOUNT_BALANCE);
// 1. Registra evento de ping no histórico em /dados/eventos/{ACCOUNT_LOGIN}.json
   string payloadEvent = StringFormat(
                            "{\"event\":\"ping\",\"symbol\":\"%s\",\"login\":%s,\"msg\":\"EA Fimaster online e ativo.\",\"ea_ativo\":%s,\"tem_posicao\":%s,\"fuso_horario\":%d,\"fuso_texto\":\"%s\",\"servidor\":\"%s\",\"saldo_disponivel\":%.2f,\"timestamp\":%d}",
                            symboll,
                            ObterContaMt5Login(),
                            g_ea_ativo ? "true" : "false",
                            temPosicao ? "true" : "false",
                            fuso,
                            fusoTxt,
                            servidor,
                            saldoDisponivel,
                            agora
                         );
   EnviarPutHTTP(ObterEventosEndpointFirebase("ping"), payloadEvent);
// 2. Atualiza o estado em tempo real no nó /dados/status/{ACCOUNT_LOGIN}.json via PUT
   string statusEndpoint = ObterStatusEndpointFirebase();
   if(statusEndpoint != "")
      {
         string payloadStatus = StringFormat(
                                   "{\"online\":true,\"ea_ativo\":%s,\"config_sync\":true,\"last_config_sync\":%d,\"last_ping\":%d,\"fuso_horario\":%d,\"fuso_texto\":\"%s\",\"symbol\":\"%s\",\"tem_posicao\":%s,\"servidor\":\"%s\",\"login\":%s,\"saldo_disponivel\":%.2f,\"timestamp\":%d}",
                                   g_ea_ativo ? "true" : "false",
                                   agora,
                                   agora,
                                   fuso,
                                   fusoTxt,
                                   symboll,
                                   temPosicao ? "true" : "false",
                                   servidor,
                                   ObterContaMt5Login(),
                                   saldoDisponivel,
                                   agora
                                );
         EnviarPutHTTP(statusEndpoint, payloadStatus);
      }
}
// ====================================================================
// 🖥️ INTERFACE GRÁFICA INTERATIVA E MÓVEL (CANTO INFERIOR ESQUERDO)
// ====================================================================


//+------------------------------------------------------------------+
//| Remove o painel gráfico do gráfico do MetaTrader 5              |
//+------------------------------------------------------------------+
void DestruirPainelVisualStatus()
{
   if(ObjectFind(0, PAINEL_STATUS_NOME) >= 0)
      {
         ObjectDelete(0, PAINEL_STATUS_NOME);
         ChartRedraw(0);
      }
}

//+------------------------------------------------------------------+


// Função para gerar um Magic Number exclusivo baseado no símbolo
int GerarMagicNumberPorSimbolo()
{
   string symbol = Symbol();  // Pega o símbolo atual
   int magic_base = 100000;   // Base para os magic numbers
   int symbol_hash = 0;
// Gera um número único baseado no nome do símbolo
   for(int i = 0; i < StringLen(symbol); i++)
      {
         symbol_hash += (int)symbol[i] * (i + 1);
      }
   return magic_base + symbol_hash;
}

// Função para verificar se há posição aberta para o símbolo
bool ExistePosicaoAberta(string symbol)
{
   if(PositionSelect(symbol))
      {
         long positionMagicNumber = PositionGetInteger(POSITION_MAGIC);
         string positionsymbol = PositionGetString(POSITION_SYMBOL);
         if(positionMagicNumber == MagicNumber && positionsymbol == symbol)
            {
               return true;
            }
      }
   return false;
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//| Função para extrair valor de texto (String) de um JSON           |
//+------------------------------------------------------------------+
string ExtrairValorStringJson(string json, string chave, string valorPadrao)
{
   string busca = "\"" + chave + "\":\"";
   int pos = StringFind(json, busca);
   if(pos == -1)
      {
         busca = "\"" + chave + "\": \"";
         pos = StringFind(json, busca);
      }
   if(pos != -1)
      {
         int start = pos + StringLen(busca);
         int end = StringFind(json, "\"", start);
         if(end != -1)
            {
               return StringSubstr(json, start, end - start);
            }
      }
   return valorPadrao;
}

//+------------------------------------------------------------------+
//| Função para extrair valor numérico (Double) de um JSON           |
//+------------------------------------------------------------------+
double ExtrairValorDoubleJson(string json, string chave, double valorPadrao)
{
   string busca = "\"" + chave + "\":";
   int pos = StringFind(json, busca);
   if(pos == -1)
      {
         busca = "\"" + chave + "\": ";
         pos = StringFind(json, busca);
      }
   if(pos != -1)
      {
         int start = pos + StringLen(busca);
         int end1 = StringFind(json, ",", start);
         int end2 = StringFind(json, "}", start);
         int end = (end1 != -1 && end2 != -1) ? MathMin(end1, end2) : ((end1 != -1) ? end1 : end2);
         if(end != -1)
            {
               string valStr = StringSubstr(json, start, end - start);
               StringTrimLeft(valStr);
               StringTrimRight(valStr);
               return StringToDouble(valStr);
            }
      }
   return valorPadrao;
}

//+------------------------------------------------------------------+
//| Função para extrair valor booleano (Bool) de um JSON             |
//+------------------------------------------------------------------+
bool ExtrairValorBoolJson(string json, string chave, bool valorPadrao)
{
   string jsonLower = json;
   StringToLower(jsonLower);
   string chaveLower = chave;
   StringToLower(chaveLower);
   if(StringFind(jsonLower, "\"" + chaveLower + "\":true") != -1 || StringFind(jsonLower, "\"" + chaveLower + "\": true") != -1)
      {
         return true;
      }
   if(StringFind(jsonLower, "\"" + chaveLower + "\":false") != -1 || StringFind(jsonLower, "\"" + chaveLower + "\": false") != -1)
      {
         return false;
      }
   return valorPadrao;
}

//+------------------------------------------------------------------+
//| Função para ler todos os parâmetros salvos vindo do Aplicativo    |
//| REGRA RIGOROSA: Se o EA estiver ATIVADO (g_ea_ativo==true),      |
//| NÃO LÊ parâmetros. Só lê se estiver DESATIVADO (g_ea_ativo==false)|
//| Verifica os seletores booleanos por JANELA para determinar o que  |
//| deve ser lido.                                                    |
//+------------------------------------------------------------------+
bool CarregarParametrosSalvosApp(string json)
{
// 🔒 INTERRUPTOR DE SEGURANÇA AO SINCRONIZAR PARÂMETROS
// Apenas lê os parâmetros se PERMITIR_LEITURA_PARAMETROS estiver LIGADO (true).
// O botão de ativar e desativar o EA (g_ea_ativo) não toma mais essa responsabilidade.
   if(veja == "Tester")
      {
         return false;
      }
   bool permitirLeitura = ExtrairValorBoolJson(json, "PERMITIR_LEITURA_PARAMETROS", false);
   if(!permitirLeitura)
      {
         Print("🔒 SEGURANÇA: Interruptor PERMITIR_LEITURA_PARAMETROS está DESATIVADO! Leitura de parâmetros ignorada pelo EA.");
         return false;
      }
   deletgarobjetos();
// Se o EA está DESATIVADO (g_ea_ativo == false), LÊ parâmetros conforme chaves booleanas ativas por janela
   string secoesLidas = "";
// 1. Conexão e Licença (SENHA é OBRIGATÓRIA e sempre lida, sem filtro booleano)
   string senhaApp = ExtrairValorStringJson(json, "SENHA", "");
   if(StringLen(senhaApp) > 0)
      {
         g_param_senha = senhaApp;
         secoesLidas += "Conexão/Autenticação (Mandatória), ";
      }
// 2. Esquema de Cores (Enum de Cores e Códigos Hex)
   if(ExtrairValorBoolJson(json, "LER_ESQUEMA_CORES", true))
      {
         string enumCoresStr = ExtrairValorStringJson(json, "ESQUEMA_CORES_ENUM", "CYAN_NEON");
         string corCanalStr   = ExtrairValorStringJson(json, "cor_de_canal", "#22D3EE");
         string corLinhasStr  = ExtrairValorStringJson(json, "cor_de_linhas", "#FF00E5");
         string corEquadorStr = ExtrairValorStringJson(json, "corr_de_equador", "#FFFF00");
         AplicarEsquemaCoresEA(enumCoresStr, corCanalStr, corLinhasStr, corEquadorStr);
         secoesLidas += "Esquema de Cores (" + enumCoresStr + "), ";
      }
// 2. Painel & Moeda / Câmbio
   if(ExtrairValorBoolJson(json, "LER_PAINEL_CAMBIO", true))
      {
         g_param_cambio = ExtrairValorDoubleJson(json, "CAMBIO", g_param_cambio);
         g_param_moeda  = ExtrairValorStringJson(json, "mony", g_param_moeda);
         secoesLidas += "Painel/Câmbio, ";
      }
// 3. Canais de Tendência (enum tendencia: TENDENCIA_DE_ALTA, TENDENCIA_DE_BAIXA)
   if(ExtrairValorBoolJson(json, "LER_CANAIS_TENDENCIA", true))
      {
         string trendStr = ExtrairValorStringJson(json, "TREND", "TENDENCIA_DE_ALTA");
         if(trendStr == "TENDENCIA_DE_BAIXA" || trendStr == "DOWN_TREND")
            {
               g_param_tendencia = TENDENCIA_DE_BAIXA;
            }
         else
            {
               g_param_tendencia = TENDENCIA_DE_ALTA;
            }
         g_param_linhas_eq    = ExtrairValorBoolJson(json, "LINHAS_DE_EQUADOR", g_param_linhas_eq);
         g_param_equador_alta = ExtrairValorDoubleJson(json, "M_equador_alta", g_param_equador_alta);
         g_param_equador_baixa = ExtrairValorDoubleJson(json, "M_equador_baixa", g_param_equador_baixa);
         secoesLidas += "Tendência, ";
      }
// 4. Estratégia Principal (enum Estrategia: FIMATHE, F_SURFADA)
   if(ExtrairValorBoolJson(json, "LER_ESTRATEGIA_PRINCIPAL", true))
      {
         string estStr = ExtrairValorStringJson(json, "ESTRATÉGIA", "FIMATHE");
         if(StringFind(estStr, "F_SURFADA") != -1)
            {
               g_param_estrategia = F_SURFADA;
            }
         else
            {
               g_param_estrategia = FIMATHE;
            }
         g_param_timeframe   = ExtrairValorStringJson(json, "OperationalPeriod", "PERIOD_M15");
         g_param_lote        = ExtrairValorDoubleJson(json, "lot", 0.01);
         g_param_niveis      = ExtrairValorDoubleJson(json, "Nives", 1.0);
         g_param_costurar    = ExtrairValorBoolJson(json, "Costurar", true);
         g_param_virada_jogo = ExtrairValorBoolJson(json, "virada_de_jogo", false);
         secoesLidas += "Estratégia, ";
      }
// 5. Posicionamento de Ordem
   if(ExtrairValorBoolJson(json, "LER_POSICIONAMENTO_ORDEM", true))
      {
         g_param_compra       = ExtrairValorDoubleJson(json, "compra", g_param_compra);
         g_param_venda        = ExtrairValorDoubleJson(json, "venda", g_param_venda);
         g_param_santo        = ExtrairValorDoubleJson(json, "santo", g_param_santo);
         g_param_dedo         = ExtrairValorDoubleJson(json, "dedo", g_param_dedo);
         g_param_posicao_take = ExtrairValorBoolJson(json, "posicaoTake", g_param_posicao_take);
         g_param_buy_take     = ExtrairValorDoubleJson(json, "buy_take", g_param_buy_take);
         g_param_sell_take    = ExtrairValorDoubleJson(json, "sell_take", g_param_sell_take);
         secoesLidas += "Posicionamento, ";
      }
// 6. Gestão de Capital e Risco
   if(ExtrairValorBoolJson(json, "LER_GESTAO_RISCO", true))
      {
         g_param_saldo         = ExtrairValorDoubleJson(json, "SALDO", g_param_saldo);
         g_param_gerenc_diario = ExtrairValorBoolJson(json, "GERENCIAMENTO_DE_RISCO_DIARIO", g_param_gerenc_diario);
         g_param_porcentos     = ExtrairValorDoubleJson(json, "porcentos", g_param_porcentos);
         g_param_porcentosg    = ExtrairValorDoubleJson(json, "poercentosg", g_param_porcentosg);
         g_param_gerenc_semanal = ExtrairValorBoolJson(json, "GERENCIAMENTO_DE_RISCO_SEMANAL", g_param_gerenc_semanal);
         g_param_porcentoo     = ExtrairValorDoubleJson(json, "PORCENTOO", g_param_porcentoo);
         g_param_porcentoss    = ExtrairValorDoubleJson(json, "PORCENTOSS", g_param_porcentoss);
         secoesLidas += "Gestão/Risco, ";
      }
// 7. Automação e Sessões (enum AUTO_PERIODO: MANUAL, SESSOES, SEMANAL, DIARIO, HORAS_8, HORA_1)
   if(ExtrairValorBoolJson(json, "LER_AUTOMACAO_SESSOES", true))
      {
         g_param_ea_auto      = ExtrairValorBoolJson(json, "EA_AUTO", g_param_ea_auto);
         string autoPerStr    = ExtrairValorStringJson(json, "AUTO_PERIOD", "HORA_1");
         if(autoPerStr == "MANUAL")
            {
               g_param_auto_periodo = MANUAL;
            }
         else if(autoPerStr == "SESSOES" || autoPerStr == "SESSION")
            {
               g_param_auto_periodo = SESSOES;
            }
         else if(autoPerStr == "SEMANAL")
            {
               g_param_auto_periodo = SEMANAL;
            }
         else if(autoPerStr == "DIARIO")
            {
               g_param_auto_periodo = DIARIO;
            }
         else if(autoPerStr == "HORAS_8" || autoPerStr == "8_HORAS")
            {
               g_param_auto_periodo = HORAS_8;
            }
         else
            {
               g_param_auto_periodo = HORA_1;
            }
         g_param_auto_surfada = ExtrairValorBoolJson(json, "AUTO_SURFADA", g_param_auto_surfada);
         g_param_sessao_asia   = ExtrairValorBoolJson(json, "SESSAO_ASIA_TOQUIO", g_param_sessao_asia);
         g_param_sessao_londres = ExtrairValorBoolJson(json, "SESSAO_LONDRES", g_param_sessao_londres);
         g_param_sessao_ny     = ExtrairValorBoolJson(json, "SESSAO_NOVA_YORQUI", g_param_sessao_ny);
         g_param_expansao_min  = (int)ExtrairValorDoubleJson(json, "EXPANSAO_MINIMA", g_param_expansao_min);
         g_param_expansao_max  = (int)ExtrairValorDoubleJson(json, "EXPANSAO_MAXIMA", g_param_expansao_max);
         secoesLidas += "Automação, ";
      }
// 8. Resultados e Notificações
   if(ExtrairValorBoolJson(json, "LER_RESULTADOS_NOTIFICACOES", true))
      {
         g_param_gmail        = ExtrairValorBoolJson(json, "GMAIL", g_param_gmail);
         g_param_notific      = ExtrairValorBoolJson(json, "notific", g_param_notific);
         g_param_ativar_venda = ExtrairValorBoolJson(json, "ativar_ou_desativar_venda", g_param_ativar_venda);
         g_param_ativar_compra = ExtrairValorBoolJson(json, "ativar_ou_desativar_compra", g_param_ativar_compra);
         g_param_modify_sl    = ExtrairValorBoolJson(json, "Modify_Sl_For_OxO", g_param_modify_sl);
         g_param_rompimento_c = ExtrairValorBoolJson(json, "condicao_De_rompimento_c", g_param_rompimento_c);
         g_param_rompimento_v = ExtrairValorBoolJson(json, "condicao_De_rompimento_v", g_param_rompimento_v);
         secoesLidas += "Notificações, ";
      }
//ValidarParametros();
//if(StringLen(ValidarParametros()) != 0)
//   {
//      return  false ;
//   }
   PrintFormat("📥 Parâmetros lidos e aplicados com sucesso pelo EA Fimaster (EA DESATIVADO). Seções: [%s]", secoesLidas);
   estado_organizacao_de_precos = ESTADO_EXPANSAO_RANGE;
   ESTADO_SICLO_DE_CANAL  = ESTADO_SICLO_DE_CANAL_INICIAL;
   ESTADO_DE_EXECUCAO = ESTADO_DE_EXECUCAO_INICIAL;
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
   ZeroMemory(precosArray);
   equador_semanal_baixa =  g_param_equador_baixa;
   equador_semanal_alta =  g_param_equador_alta;
   expansao = g_param_equador_alta - g_param_equador_baixa;;
   meio = expansao / 2 ;
   equador_diario_centro = equador_semanal_alta - meio ;
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
   criarlinhaequador_baixa(equador_semanal_baixa);
   criarlinhaequador_cento(equador_diario_centro);
   criarlinhaequador_alta(equador_semanal_alta);
   criarlinhaequador_cento(equador_diario_centro);
//+------------------------------------------------------------------+
//|   inicialização de preços
//+------------------------------------------------------------------+
   if(g_param_auto_surfada == true)
      {
         Costura = false;
      }
   if(g_param_ea_auto == true && (g_param_auto_periodo == MANUAL && g_param_auto_surfada == true))
      {
         var1 = g_param_compra;
         var2 = g_param_venda;
         PrecoDeCompra = var1;
         PrecoDeVenda = var2;
         pontosf = (var1 - var2) ;
         espas = MathAbs(PrecoDeCompra - PrecoDeVenda) / Point();
         espassao  = (int) espas;
         divisao = pontosf / 2;
         Buytake = PrecoDeCompra + (pontosf * g_param_niveis);
         Buystop = PrecoDeCompra - pontosf;
         Buysubsicul = PrecoDeCompra + divisao;
         Buymodif = PrecoDeCompra;
         Selltake = PrecoDeVenda - (pontosf * g_param_niveis);
         Sellestop = PrecoDeVenda + pontosf;
         Sellsubsicul = PrecoDeVenda - divisao;
         SellModif = PrecoDeVenda;
         sasa  = MathAbs(((PrecoDeCompra -  PrecoDeVenda) / 12) / Point()); // PTS: PARA santo
         fora = santinho * sasa;
         Costura = false;
         tempoInicioCiclo = iTime(symboll, PeriodoOperacional, 1);
         mcompra = PrecoDeCompra;
         mvenda = PrecoDeVenda;
         msbcompra = Buysubsicul;
         msubvenda = Sellsubsicul;
         mtakebuy = Buytake;
         mtakesel = Selltake;
         AVANCA = true;
         if(!JcicloAtivo)
            {
               CriarGrupo1(PrecoDeCompra, PrecoDeVenda, PrecoDeCompra - divisao);
            }
      }
   else if(! g_param_ea_auto)
      {
         var1 = g_param_compra;
         var2 = g_param_venda;
         PrecoDeCompra = var1;
         PrecoDeVenda = var2;
         pontosf = (var1 - var2) ;
         espas = MathAbs(PrecoDeCompra - PrecoDeVenda) / Point();
         espassao  = (int) espas;
         divisao = pontosf / 2;
         Buytake = PrecoDeCompra + (pontosf * g_param_niveis);
         Buystop = PrecoDeCompra - pontosf;
         Buysubsicul = PrecoDeCompra + divisao;
         Buymodif = PrecoDeCompra;
         Selltake = PrecoDeVenda - (pontosf * g_param_niveis);
         Sellestop = PrecoDeVenda + pontosf;
         Sellsubsicul = PrecoDeVenda - divisao;
         SellModif = PrecoDeVenda;
         Costura = g_param_costurar;
      }
   if(!g_param_auto_surfada)
      {
         criar_linha_venda1(var2);
         criar_linha_de_compra1(var1);
         criar_linha_subsicol1(var1 - divisao);
      }
   CHAMA();
   return true;
}


//+------------------------------------------------------------------+
//| Codifica array uchar para String Base64 no MQL5                   |
//+------------------------------------------------------------------+
string Base64EncodeMql5(const uchar &data[])
{
   int total = ArraySize(data);
   if(total == 0) return "";
   string b64Chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
   string result = "";
   int i = 0;
   while(i < total)
      {
         uint b0 = data[i++];
         uint b1 = (i < total) ? data[i++] : 0;
         uint b2 = (i < total) ? data[i++] : 0;
         uint triple = (b0 << 16) | (b1 << 8) | b2;
         result += StringSubstr(b64Chars, (triple >> 18) & 0x3F, 1);
         result += StringSubstr(b64Chars, (triple >> 12) & 0x3F, 1);
         result += (i - 1 < total) ? StringSubstr(b64Chars, (triple >> 6) & 0x3F, 1) : "=";
         result += (i < total) ? StringSubstr(b64Chars, triple & 0x3F, 1) : "=";
      }
   return result;
}

//+------------------------------------------------------------------+
//| Lê arquivo de captura de tela gerado pelo MQL5 e converte Base64 |
//+------------------------------------------------------------------+
string LerArquivoGraficoBase64(string filenamel)
{
   ResetLastError();
   int handle = FileOpen(filenamel, FILE_READ | FILE_BIN);
   if(handle == INVALID_HANDLE)
      {
         PrintFormat("⚠️ Aviso MQL5: Não foi possível abrir o arquivo '%s'. Erro: %d", filenamel, GetLastError());
         return "";
      }
   ulong size = FileSize(handle);
   if(size == 0)
      {
         FileClose(handle);
         return "";
      }
   uchar data[];
   ArrayResize(data, (int)size);
   FileReadArray(handle, data, 0, (int)size);
   FileClose(handle);
   return Base64EncodeMql5(data);
}

//+------------------------------------------------------------------+
//| Captura a tela do gráfico incluindo todos os objetos (Canais,    |
//| linhas de nível Fimathe, setas de ordens e painel MQL5) e envia  |
//| notificação de conclusão ao banco de dados e aplicativo.         |
//+------------------------------------------------------------------+
bool CapturarGraficoComObjetos()
{
// Redesenha todos os objetos no gráfico antes da captura
   ChartRedraw(0);
   string contaLogin = ObterContaMt5Login();
   string filenamel = StringFormat("captura_grafico_%s.gif", contaLogin);
   int largura = 1280;
   int altura = 720;
// ChartScreenShot() do MQL5 realiza a captura do gráfico com todos os objetos desenhados
   if(ChartScreenShot(0, filenamel, largura, altura, ALIGN_RIGHT))
      {
         int totalObjetos = ObjectsTotal(0);
         string b64Image = LerArquivoGraficoBase64(filenamel);
         PrintFormat("📸 CAPTURA DE TELA SUCESSO REAL: Arquivo '%s' gerado (%dx%d, %d chars Base64) com %d objetos no gráfico.", filenamel, largura, altura, StringLen(b64Image), totalObjetos);
         // Notifica o aplicativo sobre a conclusão da captura com a imagem REAL em Base64
         int agora = (int)TimeCurrent();
         string payload = StringFormat(
                             "{\"event\":\"captura_tela_concluida\",\"login\":%s,\"symbol\":\"%s\",\"timeframe\":\"%s\",\"filename\":\"%s\",\"image_base64\":\"%s\",\"objetos\":%d,\"msg\":\"Captura de tela REAL enviada com sucesso ao App do MT5 com objetos MQL5.\",\"timestamp\":%d}",
                             contaLogin,
                             _Symbol,
                             EnumToString(_Period),
                             filenamel,
                             b64Image,
                             totalObjetos,
                             agora
                          );
         EnviarPutHTTP(ObterEventosEndpointFirebase("captura_tela"), payload);
         // Atualiza também o nó do comando confirmando o recebimento
         string statusPayload = StringFormat("{\"status\":\"CONCLUIDO\",\"timestamp\":%d,\"objetos\":%d}", agora, totalObjetos);
         string cmdEndpoint = StringFormat("%s/dados/eventos/%s/capturar_tela.json", ObterBaseUrlFirebase(), contaLogin);
         if(auth_key != "") cmdEndpoint += "?auth=" + auth_key;
         int resCmd = EnviarPutHTTP(cmdEndpoint, statusPayload);
         // Fallback: se /dados/comandos retornar 401 ou erro, atualiza no nó de parâmetros e eventos
         return true;
      }
   else
      {
         PrintFormat("🔴 ERRO DE CAPTURA DE TELA: Falha ao gerar screenshot. Código MQL5: %d", GetLastError());
         return false;
      }
}

//+------------------------------------------------------------------+
//| Estrutura para armazenar extrato completo de movimentos        |
//+------------------------------------------------------------------+
struct ExtracaoMovimento
{
   ulong             ticket;
   string            tipo;          // "DEPOSIT", "WITHDRAWAL", "CLOSED_POSITION", "ENTRY_POSITION"
   string            simbolo;       // p.ex: "EURUSD", "XAUUSD" ou "CONTA_MT5"
   double            valor;         // valor monetario (lucro + swap + comissao ou montante de deposito/saque)
   datetime          timestamp;   // data/hora do negocio
   string            descricao;     // comentario / nota descritiva
};

//+------------------------------------------------------------------+
//| Extrai automaticamente do histórico do MT5 todos os depósitos,  |
//| saques e posições fechadas/entradas e envia ao Firebase/App      |
//+------------------------------------------------------------------+
void VerificarEEnviarHistoricoFinanceiro()
{
   if(!enviar_http) return;
// Seleciona o histórico desde o início da conta
   if(!HistorySelect(0, TimeCurrent())) return;
   int totalDeals = HistoryDealsTotal();
   string contaLogin = ObterContaMt5Login();
   datetime agora = TimeCurrent();
   static int ultimoTotalDealsProcessado = -1;
   if(totalDeals == ultimoTotalDealsProcessado && totalDeals > 0) return; // evita reenvio duplicado se nada mudou
// Array MQL5 para guardar todas as extrações de entradas, saques e depósitos
   ExtracaoMovimento arrMovimentos[];
   ArrayResize(arrMovimentos, 0);
   int contMovimentos = 0;
   string jsonMovimentosArray = "[";
   for(int i = 0; i < totalDeals; i++)
      {
         ulong ticket = HistoryDealGetTicket(i);
         if(ticket <= 0) continue;
         long dealType = HistoryDealGetInteger(ticket, DEAL_TYPE);
         long dealEntry = HistoryDealGetInteger(ticket, DEAL_ENTRY);
         double profit = HistoryDealGetDouble(ticket, DEAL_PROFIT);
         double swap = HistoryDealGetDouble(ticket, DEAL_SWAP);
         double commission = HistoryDealGetDouble(ticket, DEAL_COMMISSION);
         string symbol = HistoryDealGetString(ticket, DEAL_SYMBOL);
         datetime dealTime = (datetime)HistoryDealGetInteger(ticket, DEAL_TIME);
         string comment = HistoryDealGetString(ticket, DEAL_COMMENT);
         string tipoTransacao = "";
         double valorTotal = 0.0;
         string descTraducao = "";
         if(dealType == DEAL_TYPE_BALANCE)
            {
               if(profit > 0)
                  {
                     tipoTransacao = "DEPOSIT";
                     valorTotal = profit;
                     descTraducao = "Depósito em Conta";
                  }
               else if(profit < 0)
                  {
                     tipoTransacao = "WITHDRAWAL";
                     valorTotal = profit; // valor negativo
                     descTraducao = "Saque / Retirada";
                  }
            }
         else if(dealEntry == DEAL_ENTRY_OUT || dealEntry == DEAL_ENTRY_INOUT)
            {
               tipoTransacao = "CLOSED_POSITION";
               valorTotal = profit + swap + commission;
               descTraducao = StringFormat("Fechamento de Posição (%s)", symbol != "" ? symbol : "Ativo");
            }
         else if(dealEntry == DEAL_ENTRY_IN)
            {
               tipoTransacao = "ENTRY_POSITION";
               valorTotal = profit + swap + commission;
               descTraducao = StringFormat("Entrada de Posição (%s)", symbol != "" ? symbol : "Ativo");
            }
         if(tipoTransacao != "")
            {
               if(symbol == "") symbol = symboll;
               string notaCompleta = comment != "" ? comment : descTraducao;
               // Adiciona à estrutura do Array MQL5
               int newSize = ArraySize(arrMovimentos) + 1;
               ArrayResize(arrMovimentos, newSize);
               arrMovimentos[newSize - 1].ticket = ticket;
               arrMovimentos[newSize - 1].tipo = tipoTransacao;
               arrMovimentos[newSize - 1].simbolo = symbol;
               arrMovimentos[newSize - 1].valor = valorTotal;
               arrMovimentos[newSize - 1].timestamp = dealTime;
               arrMovimentos[newSize - 1].descricao = notaCompleta;
               // Constrói item JSON para o Array organizado
               if(contMovimentos > 0) jsonMovimentosArray += ",";
               jsonMovimentosArray += StringFormat(
                                         "{\"id\":\"deal_%d\",\"ticket\":%d,\"type\":\"%s\",\"symbol\":\"%s\",\"amount\":%.2f,\"timestamp\":%d,\"note\":\"%s\"}",
                                         ticket,
                                         ticket,
                                         tipoTransacao,
                                         symbol,
                                         valorTotal,
                                         (int)dealTime,
                                         notaCompleta
                                      );
               contMovimentos++;
               // Se for um novo negócio (após o último processado), dispara evento individual no nó /dados/eventos
               if(i >= ultimoTotalDealsProcessado && ultimoTotalDealsProcessado >= 0)
                  {
                     if(tipoTransacao == "DEPOSIT")
                        PrintFormat("💰 MT5 AUTO-DETECT: Depósito de +%.2f detectado no ticket #%d", valorTotal, ticket);
                     else if(tipoTransacao == "WITHDRAWAL")
                        PrintFormat("💸 MT5 AUTO-DETECT: Saque de %.2f detectado no ticket #%d", valorTotal, ticket);
                     else
                        PrintFormat("📈 MT5 AUTO-DETECT: Operação %s (%s) resultado %.2f no ticket #%d", tipoTransacao, symbol, valorTotal, ticket);
                     string payloadEvt = StringFormat(
                                            "{\"event\":\"historico_financeiro\",\"id\":\"deal_%d\",\"type\":\"%s\",\"symbol\":\"%s\",\"amount\":%.2f,\"timestamp\":%d,\"note\":\"%s (Ticket #%d)\",\"login\":%s}",
                                            ticket,
                                            tipoTransacao,
                                            symbol,
                                            valorTotal,
                                            (int)dealTime,
                                            notaCompleta,
                                            ticket,
                                            contaLogin
                                         );
                     EnviarPutHTTP(ObterEventosEndpointFirebase("historico_financeiro"), payloadEvt);
                  }
            }
      }
   jsonMovimentosArray += "]";
// Posta no Banco de Dados o nó de Histórico de Patrimônio Organizado
   double saldoAtual = AccountInfoDouble(ACCOUNT_BALANCE);
   string payloadFullHistory = StringFormat(
                                  "{\"login\":\"%s\",\"total_movimentos\":%d,\"last_updated\":%d,\"saldo_atual\":%.2f,\"movimentos\":%s}",
                                  contaLogin,
                                  contMovimentos,
                                  (int)agora,
                                  saldoAtual,
                                  jsonMovimentosArray
                               );
   string historicoEndpoint = StringFormat("%s/dados/eventos/historico_patrimonio/%s.json", ObterBaseUrlFirebase(), contaLogin);
   if(auth_key != "") historicoEndpoint += "?auth=" + auth_key;
   EnviarPutHTTP(historicoEndpoint, payloadFullHistory);
   ultimoTotalDealsProcessado = totalDeals;
}

//+------------------------------------------------------------------+
//| Consulta comandos pendentes de captura de tela enviados do App   |
//+------------------------------------------------------------------+
void VerificarComandoCapturaTela()
{
   if(!enviar_http) return;
   string contaLogin = ObterContaMt5Login();
   char data[];
   char result[];
   string result_headers;
   string headers = "Content-Type: application/json\r\n";
// 1. Tenta consultar nó principal de comandos
 
         string paramEndpoint = StringFormat("%s/dados/eventos/%s/capturar_tela.json", ObterBaseUrlFirebase(), contaLogin);
         if(auth_key != "") paramEndpoint += "?auth=" + auth_key;
         int res = WebRequest("GET", paramEndpoint, headers, 3000, data, result, result_headers);
      
   if(res == 200)
      {
         string json = CharArrayToString(result);
         if(StringFind(json, "\"REQUEST_SCREENSHOT\"") != -1 || StringFind(json, "\"cmd\":\"REQUEST_SCREENSHOT\"") != -1 || StringFind(json, "\"PENDENTE\"") != -1)
            {
               Print("📸 COMANDO RECEBIDO: Aplicativo solicitou captura de tela do gráfico com objetos MQL5!");
               CapturarGraficoComObjetos();
            }
      }
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string encoded = "";
string xx   = "if(ctrl + zxcv = but) return true ;";
string token  ;
int base64_table[128];
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+//| Função para gerar um hash SHA-256                                |
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//| Função para converter uchar array para string hexadecimal        |string validPasswordHashe;

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void SaveBlockData()
{
   int handle = FileOpen(filename, FILE_WRITE | FILE_TXT);
   if(handle == INVALID_HANDLE)
      {
         Print("Erro ao abrir arquivo para salvar dados de bloqueio.", GetLastError());
         return;
      }
// Grava os dados no arquivo
   FileWrite(handle, "failedAttempts=" + IntegerToString(failedAttempts));
   FileWrite(handle, "lockUntil=" + IntegerToString((int)lockUntil));
   FileWrite(handle, "userAccountNumber=" + IntegerToString((long)userAccountNumber));
   FileClose(handle);
////Print("Dados de bloqueio salvos com sucesso.");
}
// Carrega dados de bloqueio do arquivo
void LoadBlockData()
{
   int handle = FileOpen(filename, FILE_READ | FILE_TXT);
   if(handle == INVALID_HANDLE)
      {
         //Print("Arquivo de bloqueio não encontrado. Inicializando com valores padrão.");
         failedAttempts = 0;
         lockUntil = 0;
         return;
      }
// Lê os dados do arquivo
   while(!FileIsEnding(handle))
      {
         string line = FileReadString(handle);
         int pos = StringFind(line, "=");
         if(pos > 0)
            {
               string key = StringSubstr(line, 0, pos);
               string value = StringSubstr(line, pos + 1);
               if(key == "failedAttempts")
                  {
                     failedAttempts = StringToInteger(value);
                  }
               else if(key == "lockUntil")
                  {
                     lockUntil = (datetime)StringToInteger(value);
                  }
               else if(key == "userAccountNumber")
                  {
                     user = StringToInteger(value);
                  }
            }
      }
   FileClose(handle);
////Print("Dados de bloqueio carregados com sucesso.");
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
// Token pessoal do GitHub (autenticação)// Token de autenticação SecureDecode(encoded, xx)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
//+------------------------------------------------------------------+
//| Cria um botão para ativar/desativar a exibição do lucro flutuante |
//+------------------------------------------------------------------+
void CreateToggleButton()
{
   string buttonName = "ToggleFloatingProfit";
   if(!ObjectFind(0, buttonName))
      {
         ////Print("🔹 O botão já existe.");
         return;
      }
   else
      {
         // //Print("❌ Erro ao criar botão!");
      }
// //Print("✅ Criando botão...");
   if(ObjectCreate(0, buttonName, OBJ_BUTTON, 0, 0, 0))
      // Configuração para canto superior direito
      {
         ObjectSetInteger(0, buttonName, OBJPROP_CORNER, CORNER_RIGHT_LOWER);
      }
   ObjectSetInteger(0, buttonName, OBJPROP_XDISTANCE, 75);
   ObjectSetInteger(0, buttonName, OBJPROP_YDISTANCE, 65);
   ObjectSetInteger(0, buttonName, OBJPROP_XSIZE, 70);
   ObjectSetInteger(0, buttonName, OBJPROP_YSIZE, 25);
   ObjectSetInteger(0, buttonName, OBJPROP_COLOR, clrRed);
   ObjectSetInteger(0, buttonName, OBJPROP_BORDER_TYPE, BORDER_RAISED);
   ObjectSetString(0, buttonName, OBJPROP_TEXT, "OCULTAR");
   ChartRedraw();
}
//+------------------------------------------------------------------+
//| Alterna a exibição do lucro flutuante quando o botão for clicado |
//+------------------------------------------------------------------+
void OnChartEvent(const int id, const long & lparam, const double & dparam, const string & sparam)
{
// //Print("📌 OnChartEvent() foi chamado! ID: ", id, " Objeto: ", sparam);
   if(id == CHARTEVENT_OBJECT_CLICK && sparam == "ToggleFloatingProfit")
      {
         //     //Print("✅ Botão clicado! Alternando exibição...");
         showFloatingProfit = !showFloatingProfit;
         mostrarobjetos = !mostrarobjetos ;
         if(showFloatingProfit)
            {
               ObjectSetString(0, "ToggleFloatingProfit", OBJPROP_TEXT, "Ocultard3");
               ObjectSetInteger(0, "ToggleFloatingProfit", OBJPROP_COLOR, clrRed);
            }
         else
            {
               my = true;
               ObjectSetString(0, "ToggleFloatingProfit", OBJPROP_TEXT, "Mostrar");
               ObjectSetInteger(0, "ToggleFloatingProfit", OBJPROP_COLOR, clrGreen);
            }
         // Atualiza o gráfico
         ChartRedraw();
      }
// Quando o painel for clicado no gráfico
   if(id == CHARTEVENT_OBJECT_CLICK && sparam == PAINEL_STATUS_NOME)
      {
         ObjectSetInteger(0, PAINEL_STATUS_NOME, OBJPROP_STATE, false);
         ChartRedraw(0);
      }
   if(id == CHARTEVENT_KEYDOWN && lparam == 67) // Tecla 'C'
      {
         Print("⌨️ Captura manual disparada!");
         CapturarGraficoComObjetos();
      }
}

//+------------------------------------------------------------------+
//| Cria a interface gráfica móvel no canto inferior esquerdo        |
//+------------------------------------------------------------------+
void CriarPainelVisualStatus()
{
// Cria o objeto botão caso ainda não exista no gráfico
   if(ObjectFind(0, PAINEL_STATUS_NOME) < 0)
      {
         ObjectCreate(0, PAINEL_STATUS_NOME, OBJ_BUTTON, 0, 0, 0);
         ObjectSetInteger(0, PAINEL_STATUS_NOME, OBJPROP_CORNER, CORNER_LEFT_LOWER);
         ObjectSetInteger(0, PAINEL_STATUS_NOME, OBJPROP_XDISTANCE, 20);
         ObjectSetInteger(0, PAINEL_STATUS_NOME, OBJPROP_YDISTANCE, 35);
         ObjectSetInteger(0, PAINEL_STATUS_NOME, OBJPROP_XSIZE, 370);
         ObjectSetInteger(0, PAINEL_STATUS_NOME, OBJPROP_YSIZE, 38);
         ObjectSetInteger(0, PAINEL_STATUS_NOME, OBJPROP_FONTSIZE, 8);
         ObjectSetString(0, PAINEL_STATUS_NOME, OBJPROP_FONT, "Segoe UI");
         // Habilita seleção e movimentação pelo utilizador no gráfico
         ObjectSetInteger(0, PAINEL_STATUS_NOME, OBJPROP_SELECTABLE, true);
         ObjectSetInteger(0, PAINEL_STATUS_NOME, OBJPROP_SELECTED, false);
         ObjectSetInteger(0, PAINEL_STATUS_NOME, OBJPROP_HIDDEN, false);
         ObjectSetInteger(0, PAINEL_STATUS_NOME, OBJPROP_ZORDER, 100);
      }
// Atualiza os textos e cores dinâmicas
   AtualizarPainelVisualStatus();
}
//+------------------------------------------------------------------+
//| Atualiza o texto e a cor do painel visual conforme g_ea_ativo    |
//+------------------------------------------------------------------+
void AtualizarPainelVisualStatus()
{
   if(ObjectFind(0, PAINEL_STATUS_NOME) >= 0)
      {
         // Texto dinâmico conforme o estado do EA
         string texto = g_ea_ativo ? "EA Fimaster ATIVADO pelo Aplicativo!" : "EA Fimaster DESATIVADO pelo Aplicativo!";
         // Cores para estado ATIVADO (Verde) e DESATIVADO (Vermelho)
         color bgCor     = g_ea_ativo ? C'20,110,50' : C'160,30,30';
         color txtCor    = clrWhite;
         color borderCor = g_ea_ativo ? C'50,220,100' : C'240,90,90';
         ObjectSetString(0, PAINEL_STATUS_NOME, OBJPROP_TEXT, texto);
         ObjectSetInteger(0, PAINEL_STATUS_NOME, OBJPROP_BGCOLOR, bgCor);
         ObjectSetInteger(0, PAINEL_STATUS_NOME, OBJPROP_COLOR, txtCor);
         ObjectSetInteger(0, PAINEL_STATUS_NOME, OBJPROP_BORDER_COLOR, borderCor);
         ObjectSetInteger(0, PAINEL_STATUS_NOME, OBJPROP_STATE, false); // Restaura estado do botão
         ChartRedraw(0);
      }
}
//+------------------------------------------------------------------+
//| Obtém o lucro flutuante total de todas as posições abertas       |
//+------------------------------------------------------------------+
/*double GetFloatingProfit()
{
   double totalProfit = 0.0;
   double profit = PositionGetDouble(POSITION_PROFIT);
//  //Print("🔹 Posição ", i, " - Lucro: ", profit, " USD");
   totalProfit += profit;
// //Print("🔍 Lucro Flutuante Atual: ", DoubleToString(totalProfit, 2), " USD");
   return totalProfit;
}
*/
double GetFloatingProfit()
{
   double totalProfit = 0.0;
   totalPositions =  PositionSelect(symboll);
// //Print("📊 Posições Abertas: ", totalPositions);
   for(int i = 0; i < totalPositions; i++)
      {
         if(PositionSelect(PositionGetSymbol(i)))
            {
               double profit = PositionGetDouble(POSITION_PROFIT);
               //  //Print("🔹 Posição ", i, " - Lucro: ", profit, " USD");
               totalProfit += profit;
            }
      }
// //Print("🔍 Lucro Flutuante Atual: ", DoubleToString(totalProfit, 2), " USD");
   return totalProfit;
}
//+------------------------------------------------------------------+
//| Exibe o lucro flutuante no gráfico  ;                            |
//+------------------------------------------------------------------+
string mil = g_param_moeda;
void DisplayFloatingProfit()
{
   string text ;
   double floatingProfit = GetFloatingProfit();
   double voar = floatingProfit * g_param_cambio;
   if(voar >= -999.99)
      {
         mil  =   g_param_moeda;
      }
   if(voar <= 999.99)
      {
         mil  =   g_param_moeda;
      }
   if(voar <= -1000.00)
      {
         mil  =  " mil " + g_param_moeda;
      }
   if(voar <= -1000000.00)
      {
         mil  =  " milhÃo " + g_param_moeda;
      }
   if(voar >= 1000.00)
      {
         mil  =  " mil " + g_param_moeda;
      }
   if(voar >= 1000000.00)
      {
         mil  =  " milhÃo " + g_param_moeda;
      }
   string objectName = "FloatingProfitText";
   voar < 0 ?  text = "prejuízo : " + DoubleToString(voar, 2) + mil
                      : text  = "lucro : " + DoubleToString(voar, 2) + mil;
   if(!showFloatingProfit)
      {
         ObjectDelete(0, "FloatingProfitText");
         return;
      }
   else
      {
         ObjectCreate(0, "FloatingProfitText", OBJ_LABEL, 0, 0, 0);
      }
   if(!ObjectFind(0, "FloatingProfitText"))
      {
         ObjectCreate(0, "FloatingProfitText", OBJ_LABEL, 0, 0, 0);
         /// ObjectSetInteger(0, "FloatingProfitText", OBJPROP_CORNER, CORNER_RIGHT_LOWER);
         if(my == true)
            {
               ObjectSetInteger(0, "FloatingProfitText", OBJPROP_XDISTANCE, 870);
               ObjectSetInteger(0, "FloatingProfitText", OBJPROP_YDISTANCE, 60);
               my = false;
            }
         ObjectSetInteger(0, "FloatingProfitText", OBJPROP_FONTSIZE, 9);
         ObjectSetInteger(0, "FloatingProfitText", OBJPROP_BORDER_TYPE, BORDER_RAISED);
         ObjectSetInteger(0, "FloatingProfitText", OBJPROP_SELECTABLE, true);
      }
   ObjectSetString(0, "FloatingProfitText", OBJPROP_TEXT, text);
//if(voar <= -1000000.00)
//   ObjectSetInteger(0, objectName, OBJPROP_COLOR, clrBlack);       // Perda extrema
//else
//   if(voar <= -1000.00)
//      ObjectSetInteger(0, objectName, OBJPROP_COLOR, clrRed);         // Perda significativa
//   else
   if(voar < 0)
      {
         ObjectSetInteger(0, objectName, OBJPROP_COLOR, clrRed);   // Pequena perda
      }
   else if(voar == 0)
      {
         ObjectSetInteger(0, objectName, OBJPROP_COLOR, clrDimGray);   // Neutro
      }
   else if(voar > 0)
      {
         ObjectSetInteger(0, objectName, OBJPROP_COLOR, clrRoyalBlue);   // Pequeno ganho
      }
//else&& voar < 1000.00
//   if(voar >= 1000.00 && voar < 1000000.00)
//      ObjectSetInteger(0, objectName, OBJPROP_COLOR, clrDodgerBlue);  // Grande ganho
//   else
//      if(voar >= 1000000.00)
//         ObjectSetInteger(0, objectName, OBJPROP_COLOR, clrGreen);       // Lucro extremo
   ChartRedraw();
}
bool my = true;
//+------------------------------------------------------------------+
//| Verifica se o lucro atingiu o limite e salva no histórico       |
//+------------------------------------------------------------------+
void CheckAlertAndLog(double floatingProfit)
{
   if(floatingProfit >= alertThreshold && !alertTriggered)
      {
         Alert("💰 Alerta de Lucro! Seu ganho flutuante atingiu: ", DoubleToString(floatingProfit, 2), " USD");
         PlaySound("alert.wav");
         alertTriggered = true;
         SaveProfitToLog(floatingProfit);
      }
   else if(floatingProfit < alertThreshold)
      {
         //  alertTriggered = false;
      }
}
//+------------------------------------------------------------------+
//| Salva o lucro flutuante no histórico de ganhos                  |
//+------------------------------------------------------------------+
void SaveProfitToLog(double floatingProfit)
{
   int fileHandle = FileOpen(logFileName, FILE_CSV | FILE_READ | FILE_WRITE | FILE_COMMON);
   if(fileHandle != INVALID_HANDLE)
      {
         FileSeek(fileHandle, 0, SEEK_END); // Adiciona ao final do arquivo
         FileWrite(fileHandle, TimeToString(TimeLocal(), TIME_SECONDS), floatingProfit);
         FileClose(fileHandle);
      }
   else
      {
         //Print("Erro ao abrir arquivo de histórico!");
      }
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void SendMailMQL5(string subject, string body)
{
   if(g_param_gmail == true)
      {
         if(!SendMail(subject, body))
            {
               Print("Erro ao enviar e-mail: ", GetLastError());
            }
         else
            {
               Print("E-mail enviado com sucesso! ");
            }
      }
}
//+------------------------------------------------------------------+
//| Retorna o nome do dia da semana                                   |
//+------------------------------------------------------------------+
string DayOfWeek(const datetime time)
{
   MqlDateTime dt;
   string day = "";
   TimeToStruct(time, dt);
   switch(dt.day_of_week)
      {
      case 0:
         day = " Domingo ";
         break;
      case 1:
         day = " Segunda-feira";
         break;
      case 2:
         day = " Terça-feira ";
         break;
      case 3:
         day = " Quarta-feira ";
         break;
      case 4:
         day = " Quinta-feira ";
         break;
      case 5:
         day = " Sexta-feira ";
         break;
      default:
         day = " sábado ";
         break;
      }
//---
   return day;
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double SymbolInfoSessionTradeOPEN(const string symbol, const ENUM_DAY_OF_WEEK day_of_week, const uint session_index)
{
//--- declaramos variáveis para armazenar o início e término da sessão de negociação
   datetime date_from; // hora de início da sessão
   datetime date_to;   // hora de término da sessão
//--- obtemos os dados da sessão de negociação para o símbolo e dia da semana
   if(!SymbolInfoSessionTrade(symbol, day_of_week, session_index, date_from, date_to))
      {
         //Print("SymbolInfoSessionTrade() failed. Error ", GetLastError());
         //return;
      }
//--- criamos o nome do dia da semana a partir da constante de enumeração
   string week_day = EnumToString(day_of_week);
   if(week_day.Lower())
      {
         week_day.SetChar(0, ushort(week_day.GetChar(0) - 32));
      }
//--- imprimimos no log os dados da sessão de negociação especificada
//  //PrintFormat("- %-10s %s - %s  ", week_day, TimeToString(date_from, TIME_MINUTES), TimeToString(date_to, TIME_MINUTES));
// Exibe os horários de início e fim da sessão de negociação
   double abertura = StringToDouble(TimeToString(date_from, TIME_MINUTES));
   currentTime = TimeCurrent();
   string currentHourMinute = TimeToString(currentTime, TIME_MINUTES); // Obtém somente hora e minuto
//  //Print("Hora atual: ", currentHourMinute);
// Calcula a hora e minuto 30 minutos antes do fechamento
   datetime sessionEndMinus30 = date_to - 30 * 60;
   string sessionEndMinus30HourMinute = TimeToString(sessionEndMinus30, TIME_MINUTES);
//  //Print("Sessão fecha às: ", TimeToString(date_to, TIME_MINUTES), " | 30 min antes: ", sessionEndMinus30HourMinute);
// Verifica se estamos a 30 minutos do fim da sessão comparando strings formatadas
   return abertura;
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
datetime ssmm = 0; // RECEB O INDEX DE DATETIME DA SEMANA
datetime hra = 0;
bool COMECO = true;
string passe;
// Range das 4 velas
bool GetFirst4CandlesRange_Dayy(
   string symbol,
   ENUM_TIMEFRAMES timeframe,
   double & topo,
   double & fundo,
   int indx
)
{
   datetime inicio = 0 ;
   if(indx < 4)
      {
         return false;
      }
   inicio = iTime(symboll, PeriodoOperacional, (indx - 3));
// Copia as 4 primeiras velas
   MqlRates rates[4];
   int copied = CopyRates(
                   symboll,
                   timeframe,
                   inicio,
                   4,
                   rates);
// Precisamos das 4 velas FECHADAS
   if(copied < 4)
      {
         return false;
      }
   topo = rates[0].high;
   fundo = rates[0].low;
// Calcula topo e fundo
   for(int j = 1; j < 4; j++)
      {
         if(rates[j].high > topo)
            {
               topo = rates[j].high;
            }
         if(rates[j].low < fundo)
            {
               fundo = rates[j].low;
            }
      }
   if(indx > 4)
      {
         return false;
      }
   return true;
}
//+------------------------------------------------------------------+
//| Função para desenhar suporte e resistência após 3 velas de 1h    |
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void CriarGrupo1(double Jpreco1C, double Jpreco2V, double Jpreco3S)
{
   if(!mostrarobjetos)
      {
         return ;
      }
   JcicloAtivo = true;
   CriarLinhac1(Jpreco1C);
   CriarLinhav1(Jpreco2V);
   CriarLinhas1(Jpreco3S);
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void CriarGrupo2v(double Opreco2V, double Opreco3S)
{
   if(!mostrarobjetos)
      {
         return ;
      }
// NÃO muda tempoInicioCiclo !!
   CriarLinhav(Opreco2V);
   CriarLinhas(Opreco3S);
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void CriarGrupo2c(double Opreco1C, double Opreco3S)
{
   if(!mostrarobjetos)
      {
         return ;
      }
// NÃO muda tempoInicioCiclo !!
   CriarLinhac(Opreco1C);
   CriarLinhas(Opreco3S);
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void CriarLinhac1(double valor)
{
   int id = ArraySize(JnomesLinhas);
   ArrayResize(JnomesLinhas, id + 1);
   ArrayResize(JprecosArray, id + 1);
   ArrayResize(Jativa, id + 1);
   string nome = "compra_" + IntegerToString(id);
   JnomesLinhas[id] = nome;
   JprecosArray[id] = valor;
   Jativa[id] = true;
   ObjectCreate(0, nome, OBJ_TREND, 0,
                tempoInicioCiclo, valor,
                tempoInicioCiclo, valor);
   ObjectSetInteger(0, nome, OBJPROP_COLOR, cor_de_canal);
   ObjectSetInteger(0, nome, OBJPROP_WIDTH, 2);
   ObjectSetInteger(0, nome, OBJPROP_STYLE, STYLE_SOLID);
   ObjectCreate(0, nome, OBJ_ARROW_LEFT_PRICE, 0, tempoInicioCiclo, valor);
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void CriarLinhav1(double valor)
{
   int id = ArraySize(JnomesLinhas);
   ArrayResize(JnomesLinhas, id + 1);
   ArrayResize(JprecosArray, id + 1);
   ArrayResize(Jativa, id + 1);
   string nome = "venda_" + IntegerToString(id);
   JnomesLinhas[id] = nome;
   JprecosArray[id] = valor;
   Jativa[id] = true;
   ObjectCreate(0, nome, OBJ_TREND, 0,
                tempoInicioCiclo, valor,
                tempoInicioCiclo, valor);
   ObjectSetInteger(0, nome, OBJPROP_COLOR, cor_de_canal);
   ObjectSetInteger(0, nome, OBJPROP_WIDTH, 2);
   ObjectSetInteger(0, nome, OBJPROP_STYLE, STYLE_SOLID);
   ObjectCreate(0, nome, OBJ_ARROW_LEFT_PRICE, 0, tempoInicioCiclo, valor);
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void CriarLinhas1(double valor)
{
   int id = ArraySize(JnomesLinhas);
   ArrayResize(JnomesLinhas, id + 1);
   ArrayResize(JprecosArray, id + 1);
   ArrayResize(Jativa, id + 1);
   string nome = "entresiclo" + IntegerToString(id);
   JnomesLinhas[id] = nome;
   JprecosArray[id] = valor;
   Jativa[id] = true;
   ObjectCreate(0, nome, OBJ_TREND, 0,
                tempoInicioCiclo, valor,
                tempoInicioCiclo, valor);
   ObjectSetInteger(0, nome, OBJPROP_COLOR, cor_de_canal);
   ObjectSetInteger(0, nome, OBJPROP_WIDTH, 2);
   ObjectSetInteger(0, nome, OBJPROP_STYLE, STYLE_DASHDOTDOT);
   ObjectCreate(0, nome, OBJ_ARROW_LEFT_PRICE, 0, tempoInicioCiclo, valor);
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void CriarLinhac(double valor)
{
   int id = ArraySize(JnomesLinhas);
   ArrayResize(JnomesLinhas, id + 1);
   ArrayResize(JprecosArray, id + 1);
   ArrayResize(Jativa, id + 1);
   string nome = "compra_" + IntegerToString(id);
   JnomesLinhas[id] = nome;
   JprecosArray[id] = valor;
   Jativa[id] = true;
   ObjectCreate(0, nome, OBJ_TREND, 0,
                tempoInicioCiclo, valor,
                tempoInicioCiclo, valor);
   ObjectSetInteger(0, nome, OBJPROP_COLOR, cor_de_linhas);
   ObjectSetInteger(0, nome, OBJPROP_WIDTH, 2);
   ObjectSetInteger(0, nome, OBJPROP_STYLE, STYLE_SOLID);
   ObjectCreate(0, nome, OBJ_ARROW_LEFT_PRICE, 0, tempoInicioCiclo, valor);
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void CriarLinhav(double valor)
{
   int id = ArraySize(JnomesLinhas);
   ArrayResize(JnomesLinhas, id + 1);
   ArrayResize(JprecosArray, id + 1);
   ArrayResize(Jativa, id + 1);
   string nome = "venda_" + IntegerToString(id);
   JnomesLinhas[id] = nome;
   JprecosArray[id] = valor;
   Jativa[id] = true;
   ObjectCreate(0, nome, OBJ_TREND, 0,
                tempoInicioCiclo, valor,
                tempoInicioCiclo, valor);
   ObjectSetInteger(0, nome, OBJPROP_COLOR, cor_de_linhas);
   ObjectSetInteger(0, nome, OBJPROP_WIDTH, 2);
   ObjectSetInteger(0, nome, OBJPROP_STYLE, STYLE_SOLID);
   ObjectCreate(0, nome, OBJ_ARROW_LEFT_PRICE, 0, tempoInicioCiclo, valor);
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void CriarLinhas(double valor)
{
   int id = ArraySize(JnomesLinhas);
   ArrayResize(JnomesLinhas, id + 1);
   ArrayResize(JprecosArray, id + 1);
   ArrayResize(Jativa, id + 1);
   string nome = "entresiclo" + IntegerToString(id);
   JnomesLinhas[id] = nome;
   JprecosArray[id] = valor;
   Jativa[id] = true;
   ObjectCreate(0, nome, OBJ_TREND, 0,
                tempoInicioCiclo, valor,
                tempoInicioCiclo, valor);
   ObjectSetInteger(0, nome, OBJPROP_COLOR, cor_de_linhas);
   ObjectSetInteger(0, nome, OBJPROP_WIDTH, 2);
   ObjectSetInteger(0, nome, OBJPROP_STYLE, STYLE_DASHDOTDOT);
   ObjectCreate(0, nome, OBJ_ARROW_LEFT_PRICE, 0, tempoInicioCiclo, valor);
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void AtualizarLinhas()
{
   if(!JcicloAtivo)
      {
         return;
      }
   datetime tempoFinal = iTime(_Symbol, _Period, 1);
   for(int i = 0; i < ArraySize(JnomesLinhas); i++)
      {
         if(!Jativa[i])
            {
               continue;
            }
         if(ObjectFind(0, JnomesLinhas[i]) >= 0)
            {
               // TODAS usam o MESMO tempoFinal
               ObjectMove(0, JnomesLinhas[i], 1, tempoFinal, JprecosArray[i]);
            }
      }
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void PararCiclo()
{
   for(int i = 0; i < ArraySize(Jativa); i++)
      {
         Jativa[i] = false;
      }
   JcicloAtivo = false;
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void ResetCiclo()
{
   ZeroMemory(JnomesLinhas);
//ArrayResize(JprecosArray, 0);
   ZeroMemory(JprecosArray);
   ZeroMemory(Jativa);
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool atualizarcompr = true;
bool atualizarvenda  = true;
double EXPASSION_MINIMA ;
double VEAJUSTADA;
double COAJUSTADA;
double espax;
bool disparouSydney   = false;
bool disparouTokyo    = false;
bool disparouLondres  = false;
bool disparouNewYork  = false;
double aprimoradoc ;
double aprimoradov;
bool VVV = false;
bool CCC = false;
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int ObterFusoServidor()
{
   int offset = (int)((TimeCurrent() - TimeGMT()) / 3600);
   Print("A diferença entre hora do servidor e UTC  :  ", offset);
   return offset;
}
//| Obtém o fuso horário formatado (ex: GMT+2 ou GMT-3)              |
//+------------------------------------------------------------------+
string ObterFusoTexto()
{
   int offset = ObterFusoServidor();
   if(offset >= 0)
      {
         return "GMT+" + IntegerToString(offset);
      }
   else
      {
         return "GMT" + IntegerToString(offset);
      }
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void ConverterUTCparaServidor(int horaUTC, int minutoUTC, int &horaServidor, int &minutoServidor)
{
   int offset = ObterFusoServidor();
   horaServidor   = horaUTC + offset;
   minutoServidor = minutoUTC;
// Ajuste de overflow
   if(horaServidor >= 24)
      {
         horaServidor -= 24;
      }
   if(horaServidor < 0)
      {
         horaServidor += 24;
      }
   Print("Converter hora UTC para hora do servidor  :  ", horaServidor);
}
struct SessaoForex
{
   int               inicio_hora;
   int               inicio_minuto;

   int               fim_hora;
   int               fim_minuto;
};
// Definir sessões do Forex (UTC)
SessaoForex Sydney  = {22, 0, 7, 0 };
SessaoForex Tokyo   = {0, 0, 7, 0 };
SessaoForex Londres = {7, 0, 13, 20 };  // 🔥 07:30
SessaoForex NewYork = {13, 30, 20, 0 };
//Converter sessões para horário do servidor
void ConverterSessoes()
{
   ConverterUTCparaServidor(22, 0, Sydney.inicio_hora, Sydney.inicio_minuto);
   ConverterUTCparaServidor(7, 0, Sydney.fim_hora, Sydney.fim_minuto);
   ConverterUTCparaServidor(0, 0, Tokyo.inicio_hora, Tokyo.inicio_minuto);
   ConverterUTCparaServidor(7, 0, Tokyo.fim_hora, Tokyo.fim_minuto);
   ConverterUTCparaServidor(7, 0, Londres.inicio_hora, Londres.inicio_minuto);
   ConverterUTCparaServidor(13, 20, Londres.fim_hora, Londres.fim_minuto);
   ConverterUTCparaServidor(13, 30, NewYork.inicio_hora, NewYork.inicio_minuto);
   ConverterUTCparaServidor(20, 0, NewYork.fim_hora, NewYork.fim_minuto);
}
//Função para saber se estamos dentro da sessão
bool EstaNaSessao(SessaoForex & s)
{
   MqlDateTime tempo;
   TimeToStruct(TimeCurrent(), tempo);
   int atualMin = tempo.hour * 60 + tempo.min;
   int inicioMin = s.inicio_hora * 60 + s.inicio_minuto;
   int fimMin    = s.fim_hora * 60 + s.fim_minuto;
// sessão normal
   if(inicioMin < fimMin)
      {
         return (atualMin >= inicioMin && atualMin <= fimMin);
      }
// sessão que cruza meia-noite
   return (atualMin >= inicioMin || atualMin <= fimMin);
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool roboAtivo = true;
struct ControleSessao
{
   bool              estavaNaSessao;
};
ControleSessao ctrlTokyo;
ControleSessao ctrlLondres;
ControleSessao ctrlNewYork;
datetime ObterInicioSessao(SessaoForex & s)
{
   MqlDateTime dt;
   TimeToStruct(TimeCurrent(), dt);
   dt.hour = s.inicio_hora;
   dt.min  = s.inicio_minuto;
   dt.sec  = 0;
   return StructToTime(dt);
}
//-------------------------------------
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
datetime ObterFimSessao(SessaoForex & s)
{
   MqlDateTime dt;
   TimeToStruct(TimeCurrent(), dt);
   dt.hour = s.fim_hora;
   dt.min  = s.fim_minuto;
   dt.sec  = 0;
   datetime fim = StructToTime(dt);
// sessão cruzou meia-noite
   int inicioMin = s.inicio_hora * 60 + s.inicio_minuto;
   int fimMin    = s.fim_hora * 60 + s.fim_minuto;
   if(fimMin < inicioMin)
      {
         fim += 86400;
      }
   return fim;
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void OnSessionStart(string nome, SessaoForex & s)
{
   Print("==========");
   Print("INICIO DA SESSAO: ", nome);
   currentHour = ObterInicioSessao(s);
   future = ObterFimSessao(s);
   Print("Inicio: ", TimeToString(currentHour));
   Print("Fim: ", TimeToString(future));
   roboAtivo = true;
// JSON Payload para início de sessão
   string payload = StringFormat(
                       "{\"event\":\"sessao_inicio\",\"sessao\":\"%s\",\"symbol\":\"%s\",\"hora_inicio\":%d,\"hora_fim\":%d,\"timestamp\":%d}",
                       nome,
                       _Symbol,
                       TimeToString(currentHour),
                       TimeToString(future),
                       (int)TimeCurrent()
                    );
   EnviarPutHTTP(ObterEventosEndpointFirebase("sessao_inicio"), payload);
// =====================================
// COLOQUE SUA LOGICA AQUI
// =====================================
// exemplo:
// abrir ordem
// resetar variaveis
// iniciar contagem
// enviar alerta
// salvar high/low
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void OnSessionEnd(string nome, SessaoForex & s)
{
   Print("==========");
   Print("FIM DA SESSAO: ", nome);
   datetime fim = ObterFimSessao(s);
   Print("Fim real: ", TimeToString(fim));
   roboAtivo = false;
// JSON Payload para fim de sessão
   string payload = StringFormat(
                       "{\"event\":\"sessao_fim\",\"sessao\":\"%s\",\"symbol\":\"%s\",\"hora_fim\":%d,\"minuto_fim\":%d,\"timestamp\":%d}",
                       nome,
                       _Symbol,
                       fim,
                       s.fim_minuto,
                       (int)TimeCurrent()
                    );
   EnviarPutHTTP(ObterEventosEndpointFirebase("sessao_fim"), payload);
// =====================================
// COLOQUE SUA LOGICA AQUI
// =====================================
// exemplo:
// fechar ordens
// parar trailing
// salvar resultado
// enviar relatorio
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void MonitorarSessao(
   SessaoForex & sessao,
   ControleSessao & controle,
   string nome)
{
   bool dentro = EstaNaSessao(sessao);
// entrou na sessão
   if(dentro && !controle.estavaNaSessao)
      {
         OnSessionStart(nome, sessao);
      }
// saiu da sessão
   if(!dentro && controle.estavaNaSessao)
      {
         OnSessionEnd(nome, sessao);
      }
// atualiza estado
   controle.estavaNaSessao = dentro;
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
datetime GetStartOfWee(int openHour)
{
   MqlDateTime dt;
   TimeToStruct(TimeCurrent(), dt);
   int day_of_week = dt.day_of_week;
   if(day_of_week == 0)
      {
         day_of_week = 7;
      }
   dt.day -= (day_of_week - 1);
   dt.hour = openHour;
   dt.min  = 0;
   dt.sec  = 0;
   return StructToTime(dt);
}
//+------------------------------------------------------------------+
//| Envia um sinal (heartbeat) notificando que o EA está online      |
//+------------------------------------------------------------------+
datetime ultima_execucao ;
void CheckNewHourAndDrawLines()
{
   int abertur  = (int) SymbolInfoSessionTradeOPEN(symboll, (ENUM_DAY_OF_WEEK)DayOfWeek(current), SESSION_INDEX);
//Print("abertura ", abertur);
   currentTime = TimeCurrent();
   MqlDateTime dt;
   TimeToStruct(currentTime, dt);
// Zera hora, minuto e segundo para pegar o início do dia
   if(g_param_auto_periodo == DIARIO)
      {
         dt.hour = abertur;
         dt.min = 0;
         dt.sec = 0;
         datetime startOfDay = StructToTime(dt);
         currentHour = startOfDay ;
         future = currentHour +  86400; //diario
      }
   if(g_param_auto_periodo == HORAS_8)
      {
         dt.hour = abertur + (dt.hour / 8) * 8;
         dt.min = 0;
         dt.sec = 0;
         future = currentHour + 28800;
         // enviar email sobre abertura  e horario para acompanhar meu fuso horario
         datetime roundedTime = StructToTime(dt);
         // Converte de volta para datetime
         currentHour = roundedTime;
      }
   if(g_param_auto_periodo == HORA_1)
      {
         currentHour = currentTime - dt.min * 60 - dt.sec;
         future = currentHour +  3600; // 1 hora adiante
      }
   if(g_param_auto_periodo == SEMANAL)
      {
         currentHour = GetStartOfWee(abertur);
         future = currentHour + 604800;
      }
   if(g_param_auto_periodo == SESSOES)
      {
         if(g_param_sessao_asia)
            {
               MonitorarSessao(Tokyo, ctrlTokyo, "TOKYO");
            }
         if(g_param_sessao_londres)
            {
               MonitorarSessao(Londres, ctrlLondres, "LONDRES");
            }
         if(g_param_sessao_ny)
            {
               MonitorarSessao(NewYork, ctrlNewYork, "NEW YORK");
            }
      }
   if(ultima_execucao < currentHour)
      {
         ultima_execucao =  currentHour  ;
         tempoInicioCiclo = ultima_execucao ;
         CHAMA();
      }
   startIndex = iBarShift(symboll, PeriodoOperacional, ultima_execucao, false)  ;
   if(startIndex < 2)
      {
         return;
      }
   if(GetFirst4CandlesRange_Dayy(symboll, PeriodoOperacional,
                                 compraa, vendaa, startIndex))
      {
         lastHourProcessed = ultima_execucao;
         RANGE = (compraa - vendaa) / _Point;
         Print("tupo .", compraa);
         Print("fundo .", vendaa);
         Print("PRIMEIRO RANGE .", RANGE);
      }
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void ResetarVariaveisHora()
{
   ger = true;
   reg = true;
   controlbuy = true;
   controlsell = true;
   controlbuymdf = false;
   controlsellmdf = false;
   control_de_compra = true;
   control_de_venda = true;
   segundo_control_de_takbuy = true;
   segundo_control_de_taksell = true;
   caneta = false;
   ZeroMemory(precosArray);
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void IniciarVariaves()
{
   ger = true;
   reg = true;
   VVV = false;
   CCC = false;
   PASSOU = false;
   controlbuy = false;
   controlsell = false;
   controlbuymdf = false;
   controlsellmdf = false;
   control_de_compra = false;
   control_de_venda = false;
   segundo_control_de_takbuy = false;
   segundo_control_de_taksell = false;
   caneta = true;
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool AjustarCanal(double & CJ, double & VJ, double & esp, double & EXPM )
{
  
         if(closeprice > CJ)
            {
               CCC = true;
               CJ = CJ + esp ;
               esp = (CJ - VJ);
               EXPM = (CJ - VJ) / _Point;
               //aprimoradoc = CJ;
               //aprimoradov = VJ;
               return  true;
            }
         else if(closeprice < VJ)
            {
               VVV = true;
               VJ = VJ - esp ;
               esp = (CJ - VJ);
               EXPM = (CJ - VJ) / _Point;
               //aprimoradoc = CJ;
               //aprimoradov = VJ;
               return  true;
            }
     return false;
     
      
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void RompimentoCima()
{
   caneta = true;
   if(ger == false)
      {
         buy = compraa;
         sell = compraa - pptt;
      }
   else
      {
         sell = VEAJUSTADA;
         buy = COAJUSTADA ;
      }
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void RompimentoBaixo()
{
   caneta = true;
   if(ger == false)
      {
         buy = vendaa + pptt;
         sell = vendaa;
      }
   else
      {
         sell = VEAJUSTADA ;
         buy = COAJUSTADA;
      }
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double mcompra;
double mvenda ;
double msubvenda;
double msbcompra;
double mtakesel;
double mtakebuy;
void InicializarOrdens()
{
   PrecoDeCompra = buy;
   PrecoDeVenda  = sell;
   pontosf = buy - sell;
   divisao = pontosf / 2;
   pc = PrecoDeCompra ;
   pv = PrecoDeVenda ;
   Pontos = pc - pv;
   divisao = Pontos / 2;
   linhabuy = pc + Pontos;
   linhasubsiculc = pc + divisao;
   linhasell = pv - Pontos;
   linhasubsiculv = pv - divisao;
   espas = MathAbs(PrecoDeCompra - PrecoDeVenda) / Point();
   espassao  = (int) espas;
   Buytake = PrecoDeCompra + (pontosf * g_param_niveis);
   Buystop = PrecoDeCompra - pontosf;
   Buysubsicul = PrecoDeCompra + divisao;
   Selltake = PrecoDeVenda - (pontosf * g_param_niveis);
   Sellestop = PrecoDeVenda + pontosf;
   Sellsubsicul = PrecoDeVenda - divisao;
   sasa  = MathAbs(((PrecoDeCompra -  PrecoDeVenda) / 12) / Point()); // PTS: PARA santo
   fora = santinho * sasa;
   if(g_param_auto_surfada)
      {
         mcompra = PrecoDeCompra;
         mvenda = PrecoDeVenda;
         msbcompra = Buysubsicul;
         msubvenda = Sellsubsicul;
         mtakebuy = Buytake;
         mtakesel = Selltake;
         AVANCA = true;
         if(!JcicloAtivo)
            {
               CriarGrupo1(mcompra, mvenda, mcompra - divisao);
            }
      }
   else
      {
         criar_linha_subsicol1(PrecoDeCompra - divisao);
         criar_linha_de_compra1(PrecoDeCompra);
         criar_linha_venda1(PrecoDeVenda);
      }
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void InicializarOrdensa()
{
   PrecoDeCompra = buy;
   PrecoDeVenda  = sell;
   pontosf = buy - sell;
   divisao = pontosf / 2;
   pc = PrecoDeCompra ;
   pv = PrecoDeVenda ;
   Pontos = pc - pv;
   divisao = Pontos / 2;
   linhabuy = pc + Pontos;
   linhasubsiculc = pc + divisao;
   linhasell = pv - Pontos;
   linhasubsiculv = pv - divisao;
   espas = MathAbs(PrecoDeCompra - PrecoDeVenda) / Point();
   espassao  = (int) espas;
   Buytake = PrecoDeCompra + (pontosf * g_param_niveis);
   Buystop = PrecoDeCompra - pontosf;
//Buysubsicul = PrecoDeCompra + divisao;
   Selltake = PrecoDeVenda - (pontosf * g_param_niveis);
   Sellestop = PrecoDeVenda + pontosf;
//Sellsubsicul = PrecoDeVenda - divisao;
   sasa  = MathAbs(((PrecoDeCompra -  PrecoDeVenda) / 12) / Point()); // PTS: PARA santo
   fora = santinho * sasa;
   if(g_param_auto_surfada)
      {
         mcompra = PrecoDeCompra;
         mvenda = PrecoDeVenda;
         msbcompra = PrecoDeCompra + divisao;;
         msubvenda = PrecoDeVenda - divisao;
         mtakebuy = Buytake;
         mtakesel = Selltake;
         AVANCA = true;
         if(!JcicloAtivo)
            {
               CriarGrupo1(mcompra, mvenda, mcompra - divisao);
            }
      }
   else
      {
         criar_linha_subsicol1(PrecoDeCompra - divisao);
         criar_linha_de_compra1(PrecoDeCompra);
         criar_linha_venda1(PrecoDeVenda);
      }
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
enum ESTADO_DE_PRECOS
{
   ESTADO_NOVO_CICLO,
   ESTADO_EXPANSAO_RANGE,
   ESTADO_AJUSTE_CANAL,
   ESTADO_CANAL_PRONTO,
   ESTADO_ROMPIMENTO_CIMA,
   ESTADO_ROMPIMENTO_BAIXO,
   ESTADO_DE_PRECOS_CONCLUIDO,
   ESTADO_DE_PRECOS_PARAMETROS
};
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
ESTADO_DE_PRECOS estado_organizacao_de_precos = ESTADO_EXPANSAO_RANGE;

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void TROCAR_ESTADO_DE_PRECOS(ESTADO_DE_PRECOS novosprecos)
{
   if(estado_organizacao_de_precos == novosprecos)
      {
         return;
      }
   Print("Estado atual de preços : ", EnumToString(estado_organizacao_de_precos),
         "\n -> Novo estado de preços : ", EnumToString(novosprecos));
   EnviarEmailEstado(
      SISTEMA_PRECOS,
      EnumToString(estado_organizacao_de_precos),
      EnumToString(novosprecos),
      ObterDescricaoEstadoPrecos(estado_organizacao_de_precos),
      ObterDescricaoEstadoPrecos(novosprecos)
   );
   RegistrarEstadoExecucao(EnumToString(estado_organizacao_de_precos), ObterDescricaoEstadoPrecos(estado_organizacao_de_precos));
   estado_organizacao_de_precos = novosprecos;
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool PASSOU = false;
void Automatico()
{
   if(!g_param_ea_auto)
      {
         return;
      }
   if(ultima_execucao != lastHourProcessed)
      {
         TROCAR_ESTADO_DE_PRECOS(ESTADO_NOVO_CICLO);
         caneta = false;
      }
   if(startIndex < 4)
      {
         return;
      }
   switch(estado_organizacao_de_precos)
      {
//========================================
      case ESTADO_NOVO_CICLO:
         VEAJUSTADA = vendaa ;
         COAJUSTADA = compraa ;
         EXPASSION_MINIMA = RANGE;
         espax = COAJUSTADA - VEAJUSTADA;
         ResetarVariaveisHora();
         TROCAR_ESTADO_DE_PRECOS(ESTADO_EXPANSAO_RANGE);
         break;
//========================================
      case ESTADO_EXPANSAO_RANGE:
         Print("RANGE DE RANGE 2 ,", RANGE);
         Print("crzn ,", g_param_expansao_max);
         Print("EXPANSAO_MINIMA ,", g_param_expansao_min);
         //========================================
         //========================================
         if(EXPASSION_MINIMA > g_param_expansao_max )
            {
            
               if(  AjustarCanal(COAJUSTADA, VEAJUSTADA, espax, EXPASSION_MINIMA ))
                  {
                     divisao = espax / 2 ;
                     if(g_param_auto_surfada)
                        {
                           if(!JcicloAtivo)
                              {
                                 CriarGrupo1(COAJUSTADA, VEAJUSTADA, COAJUSTADA - divisao);
                              }
                        }
                     if(!ExistePosicaoAberta(symboll))
                        {
                           RompimentoCima();
                           IniciarVariaves();
                           InicializarOrdens();
                           TROCAR_ESTADO_DE_PRECOS(ESTADO_DE_PRECOS_CONCLUIDO);
                        }
                     else if(g_param_auto_surfada)
                        {
                           RompimentoCima();
                           InicializarOrdensa();
                           TROCAR_ESTADO_DE_PRECOS(ESTADO_DE_PRECOS_CONCLUIDO);
                        }
                  }
               caneta = true;
               break;
            }
         if(EXPASSION_MINIMA < g_param_expansao_max )
            {
               TROCAR_ESTADO_DE_PRECOS(ESTADO_AJUSTE_CANAL);
            }
         break;
//========================================
      case ESTADO_AJUSTE_CANAL:
         //========================================
         
         if( AjustarCanal(COAJUSTADA, VEAJUSTADA, espax, EXPASSION_MINIMA ))
            {
               divisao = espax / 2 ;
               if(g_param_auto_surfada)
                  {
                     if(!JcicloAtivo)
                        {
                           CriarGrupo1(COAJUSTADA, VEAJUSTADA, COAJUSTADA - divisao);
                        }
                  }
               TROCAR_ESTADO_DE_PRECOS(ESTADO_CANAL_PRONTO);
            }
         break;
//========================================
      case ESTADO_CANAL_PRONTO:
         //========================================
         if(COAJUSTADA == 0.0 || VEAJUSTADA == 0.0)
            {
               return;
            }
         if(closeprice > COAJUSTADA)
            {
               Print("COMPRA .", COAJUSTADA);
               Print("VENDA .", VEAJUSTADA);
               Print("RANGE DE AJUSTE PRONTO .", EXPASSION_MINIMA);
               TROCAR_ESTADO_DE_PRECOS(ESTADO_ROMPIMENTO_CIMA);
            }
         else if(closeprice < VEAJUSTADA)
            {
               Print("COMPRA .", COAJUSTADA);
               Print("VENDA .", VEAJUSTADA);
               Print("RANGE DE AJUSTE PRONTO .", EXPASSION_MINIMA);
               TROCAR_ESTADO_DE_PRECOS(ESTADO_ROMPIMENTO_BAIXO);
            }
         break;
//========================================
      case ESTADO_ROMPIMENTO_CIMA:
         //========================================
         if(!ExistePosicaoAberta(symboll))
            {
               RompimentoCima();
               IniciarVariaves();
               InicializarOrdens();
               TROCAR_ESTADO_DE_PRECOS(ESTADO_DE_PRECOS_CONCLUIDO);
               TROCAR_ESTADO_DE_EXECUCAO(ESTADO_DE_EXECUCAO_INICIAL);
            }
         else if(g_param_auto_surfada)
            {
               RompimentoCima();
               InicializarOrdensa();
               TROCAR_ESTADO_DE_PRECOS(ESTADO_DE_PRECOS_CONCLUIDO);
               TROCAR_ESTADO_DE_EXECUCAO(ESTADO_DE_EXECUCAO_MODIFICAR);
            }
         break;
//========================================
      case ESTADO_ROMPIMENTO_BAIXO:
         //========================================
         if(!ExistePosicaoAberta(symboll))
            {
               RompimentoBaixo();
               IniciarVariaves();
               InicializarOrdens();
               TROCAR_ESTADO_DE_PRECOS(ESTADO_DE_PRECOS_CONCLUIDO);
               TROCAR_ESTADO_DE_EXECUCAO(ESTADO_DE_EXECUCAO_INICIAL);
            }
         else if(g_param_auto_surfada)
            {
               RompimentoBaixo();
               InicializarOrdensa();
               TROCAR_ESTADO_DE_PRECOS(ESTADO_DE_PRECOS_CONCLUIDO);
               TROCAR_ESTADO_DE_EXECUCAO(ESTADO_DE_EXECUCAO_MODIFICAR);
            }
         break;
      case ESTADO_DE_PRECOS_CONCLUIDO:
         break;
      case ESTADO_DE_PRECOS_PARAMETROS:
         break;
      }
}
const long idd = 0;
bool PodeExecutarNovoCandle()
{
   static datetime last_bar = 0;
   datetime current_bar = iTime(_Symbol, _Period, 0);
   if(current_bar == last_bar)
      {
         return false;
      }
   last_bar = current_bar;
   return true;
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool AVANCA = false;
enum ESTADO_SICLO
{
   ESTADO_SICLO_DE_CANAL_INICIAL,
   ESTADO_SICLO_DE_CANAL_COMPRA,
   ESTADO_SICLO_DE_CANAL_VENDA,
   ESTADO_SICLO_DE_CANAL_COMPRA_FINALIZADO,
   ESTADO_SICLO_DE_CANAL_VENDA_FINALIZADO,

};
ESTADO_SICLO ESTADO_SICLO_DE_CANAL  = ESTADO_SICLO_DE_CANAL_INICIAL;
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void TROCAR_ESTADO_DE_SICLO(ESTADO_SICLO novociclo)
{
   if(ESTADO_SICLO_DE_CANAL == novociclo)
      {
         return;
      }
   Print("Estado atual do ciclo : ", EnumToString(ESTADO_SICLO_DE_CANAL),
         "\n -> Novo estado do ciclo : ", EnumToString(novociclo));
   EnviarEmailEstado(
      SISTEMA_SICLO,
      EnumToString(ESTADO_SICLO_DE_CANAL),
      EnumToString(novociclo),
      ObterDescricaoEstadoCiclo(ESTADO_SICLO_DE_CANAL),
      ObterDescricaoEstadoCiclo(novociclo)
   );
   RegistrarEstadoExecucao(EnumToString(ESTADO_SICLO_DE_CANAL), ObterDescricaoEstadoCiclo(ESTADO_SICLO_DE_CANAL));
   ESTADO_SICLO_DE_CANAL = novociclo;
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void CHAMA()
{
   PararCiclo();
   ResetCiclo();
   ultima_execucao = iTime(symboll, PeriodoOperacional, 1);
   tempoInicioCiclo = ultima_execucao; // tempo fixo do ciclo
   TROCAR_ESTADO_DE_SICLO(ESTADO_SICLO_DE_CANAL_INICIAL);
   AVANCA = false;
}
//+------------------------------------------------------------------+<
//|                                                                  |
//+------------------------------------------------------------------+
void AUTO_SURFE()
{
   if(!g_param_auto_surfada)
      {
         return;
      }
   if(!AVANCA)
      {
         return;
      }
   switch(ESTADO_SICLO_DE_CANAL)
      {
//========================================
      case ESTADO_SICLO_DE_CANAL_INICIAL:
         if(mcompra == 0.0 || mvenda == 0.0)
            {
               return;
            }
         if(closeprice > mcompra)
            {
               if(JcicloAtivo)
                  {
                     CriarGrupo2c(mtakebuy, msbcompra);
                  }
               TROCAR_ESTADO_DE_SICLO(ESTADO_SICLO_DE_CANAL_COMPRA);
            }
         else if(closeprice < mvenda)
            {
               if(JcicloAtivo)
                  {
                     CriarGrupo2v(mtakesel, msubvenda);
                  }
               TROCAR_ESTADO_DE_SICLO(ESTADO_SICLO_DE_CANAL_VENDA);
            }
         break;
//========================================
      case ESTADO_SICLO_DE_CANAL_COMPRA:
         if(closeprice > msbcompra)
            {
               TROCAR_ESTADO_DE_SICLO(ESTADO_SICLO_DE_CANAL_COMPRA_FINALIZADO);
            }
         else if(closeprice < mvenda)
            {
               CHAMA();
               return;
            }
         break;
//========================================
      case ESTADO_SICLO_DE_CANAL_VENDA:
         if(closeprice < msubvenda)
            {
               TROCAR_ESTADO_DE_SICLO(ESTADO_SICLO_DE_CANAL_VENDA_FINALIZADO);
            }
         else if(closeprice > mcompra)
            {
               CHAMA();
               return;
            }
         break;
//========================================
      case ESTADO_SICLO_DE_CANAL_COMPRA_FINALIZADO:
         if(closeprice > mtakebuy || closeprice < mcompra)
            {
               CHAMA();
               return;
            }
         break;
//========================================
      case ESTADO_SICLO_DE_CANAL_VENDA_FINALIZADO:
         if(closeprice < mtakesel || closeprice > mvenda)
            {
               CHAMA();
               return;
            }
         break;
      }
}
//+------------------------------------------------------------------+
//|   maquina de estado                                 |
//+------------------------------------------------------------------+
// Enumeração dos temas de cores suportados pelo EA
enum ENUM_ESQUEMA_CORES
{
   CORES_CYAN_NEON = 0,    // Cyan Neon (#22D3EE, #FF00E5, #FFFF00)
   CORES_DARK_MATRIX,      // Dark Matrix (#00FF66, #008000, #00FFCC)
   CORES_GOLDEN_PRO,       // Golden Pro (#FFD700, #FF8C00, #FFFFFF)
   CORES_PURPLE_NIGHT,     // Purple Night (#A855F7, #EC4899, #38BDF8)
   CORES_CLASSIC_BLUE,     // Classic Blue (#3B82F6, #1D4ED8, #60A5FA)
   CORES_CUSTOM            // Personalizado (Usa Códigos Hex Digitados)
};

ENUM_ESQUEMA_CORES g_esquema_cores_enum = CORES_CYAN_NEON;
color g_cor_canal   = C'34,211,238';  // #22D3EE
color g_cor_linhas  = C'255,0,229';   // #FF00E5
color g_cor_equador = C'255,255,0';   // #FFFF00

// Converte string Hex (#RRGGBB) para tipo color no MQL5
color HexToColor(string hexStr)
{
   StringReplace(hexStr, "#", "");
   if(StringLen(hexStr) != 6)
      {
         return clrCyan;
      }
   long r = StringToInteger("0x" + StringSubstr(hexStr, 0, 2));
   long g = StringToInteger("0x" + StringSubstr(hexStr, 2, 2));
   long b = StringToInteger("0x" + StringSubstr(hexStr, 4, 2));
   return (color)((b << 16) | (g << 8) | r);
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void AplicarEsquemaCoresEA(string enumStr, string hexCanal, string hexLinhas, string hexEquador)
{
   if(enumStr == "DARK_MATRIX")
      {
         g_esquema_cores_enum = CORES_DARK_MATRIX;
         g_cor_canal   = HexToColor("#00FF66");
         g_cor_linhas  = HexToColor("#008000");
         g_cor_equador = HexToColor("#00FFCC");
      }
   else if(enumStr == "GOLDEN_PRO")
      {
         g_esquema_cores_enum = CORES_GOLDEN_PRO;
         g_cor_canal   = HexToColor("#FFD700");
         g_cor_linhas  = HexToColor("#FF8C00");
         g_cor_equador = HexToColor("#FFFFFF");
      }
   else if(enumStr == "PURPLE_NIGHT")
      {
         g_esquema_cores_enum = CORES_PURPLE_NIGHT;
         g_cor_canal   = HexToColor("#A855F7");
         g_cor_linhas  = HexToColor("#EC4899");
         g_cor_equador = HexToColor("#38BDF8");
      }
   else if(enumStr == "CLASSIC_BLUE")
      {
         g_esquema_cores_enum = CORES_CLASSIC_BLUE;
         g_cor_canal   = HexToColor("#3B82F6");
         g_cor_linhas  = HexToColor("#1D4ED8");
         g_cor_equador = HexToColor("#60A5FA");
      }
   else if(enumStr == "CUSTOM")
      {
         g_esquema_cores_enum = CORES_CUSTOM;
         g_cor_canal   = HexToColor(hexCanal);
         g_cor_linhas  = HexToColor(hexLinhas);
         g_cor_equador = HexToColor(hexEquador);
      }
   else     // CYAN_NEON default
      {
         g_esquema_cores_enum = CORES_CYAN_NEON;
         g_cor_canal   = HexToColor(hexCanal != "" ? hexCanal : "#22D3EE");
         g_cor_linhas  = HexToColor(hexLinhas != "" ? hexLinhas : "#FF00E5");
         g_cor_equador = HexToColor(hexEquador != "" ? hexEquador : "#FFFF00");
      }
   Print(StringFormat("🎨 ESQUEMA DE CORES APLICADO NO EA: Enum=%s | Canal=%X | Linhas=%X | Equador=%X", enumStr, g_cor_canal, g_cor_linhas, g_cor_equador));
}


enum ESTADO_ROBO
{
   ESTADO_DE_EXECUCAO_INICIAL = 0,
   ESTADO_DE_EXECUCAO_COMPRA_INICIAL,
   ESTADO_DE_EXECUCAO_VENDA_INICIAL,
   ESTADO_DE_EXECUCAO_COMPRA_POSICAO,
   ESTADO_DE_EXECUCAO_VENDA_POSICAO,
   ESTADO_DE_EXECUCAO_MODIFICAR,
   ESTADO_DE_EXECUCAO_MODIFICAR_COMPRA,
   ESTADO_DE_EXECUCAO_MODIFICAR_VENDA,
   ESTADO_DE_EXECUCAO_REPOUSO
};
ESTADO_ROBO ESTADO_DE_EXECUCAO = ESTADO_DE_EXECUCAO_INICIAL;
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void TROCAR_ESTADO_DE_EXECUCAO(ESTADO_ROBO novoEstado)
{
   if(ESTADO_DE_EXECUCAO == novoEstado)
      {
         return;
      }
   Print("Estado atual de execuçao: ", EnumToString(ESTADO_DE_EXECUCAO),
         "\n -> Novo estado de execuçao: ", EnumToString(novoEstado));
   EnviarEmailEstado(
      SISTEMA_ROBO,
      EnumToString(ESTADO_DE_EXECUCAO),
      EnumToString(novoEstado),
      ObterDescricaoEstadoRobo(ESTADO_DE_EXECUCAO),
      ObterDescricaoEstadoRobo(novoEstado)
   );
   RegistrarEstadoExecucao(EnumToString(ESTADO_DE_EXECUCAO), ObterDescricaoEstadoRobo(ESTADO_DE_EXECUCAO));
   ESTADO_DE_EXECUCAO = novoEstado;
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void MaquinaDeEstado()
{
   switch(ESTADO_DE_EXECUCAO)
      {
      case ESTADO_DE_EXECUCAO_INICIAL:
         VerificarEntradaInicial();
         break;
      case ESTADO_DE_EXECUCAO_COMPRA_INICIAL:
         ExecutarCompraInicial();
         break;
      case ESTADO_DE_EXECUCAO_VENDA_INICIAL:
         ExecutarVendaInicial();
         break;
      case ESTADO_DE_EXECUCAO_COMPRA_POSICAO:
         ProcessarCompraComPosicao();
         break;
      case ESTADO_DE_EXECUCAO_VENDA_POSICAO:
         ProcessarVendaComPosicao();
         break;
      case ESTADO_DE_EXECUCAO_MODIFICAR:
         processarModificacao();
         break;
      case ESTADO_DE_EXECUCAO_MODIFICAR_COMPRA:
         ExecutarModificacaoCompra();
         break;
      case ESTADO_DE_EXECUCAO_MODIFICAR_VENDA:
         ExecutarModificacaoVenda();
         break;
      case ESTADO_DE_EXECUCAO_REPOUSO:
         break;
      }
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void ProcessarCompraComPosicao()
{
processarModificacao();
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void ProcessarVendaComPosicao()
{
processarModificacao();
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void  processarModificacao()
{
   if(closeprice >= Buysubsicul &&
         Buysubsicul > 0 &&
         !controlbuymdf)
      {
         TROCAR_ESTADO_DE_EXECUCAO(ESTADO_DE_EXECUCAO_MODIFICAR_COMPRA);
      }
   else if(closeprice <= Sellsubsicul &&
           Sellsubsicul > 0 &&
           !controlsellmdf)
      {
         TROCAR_ESTADO_DE_EXECUCAO(ESTADO_DE_EXECUCAO_MODIFICAR_VENDA);
      }
   else if(!g_param_auto_surfada)
      {
         if(closeprice >= PrecoDeCompra &&
               PrecoDeCompra > 0 &&
               !controlbuy && roboAtivo && g_ea_ativo)
            {
               TROCAR_ESTADO_DE_EXECUCAO(ESTADO_DE_EXECUCAO_COMPRA_INICIAL);
               return;
            }
         else if(closeprice <= PrecoDeVenda &&
                 PrecoDeVenda > 0 &&
                 !controlsell && roboAtivo && g_ea_ativo)
            {
               TROCAR_ESTADO_DE_EXECUCAO(ESTADO_DE_EXECUCAO_VENDA_INICIAL);
               return;
            }
      }
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void VerificarEntradaInicial()
{
   if(!roboAtivo  || !g_ea_ativo)
      {
         return;
      }
   if(closeprice > PrecoDeCompra &&
         PrecoDeCompra > 0 &&
         !controlbuy)
      {
         if(ExistePosicaoAberta(symboll))
            {
               if(CompraComPosicao())
                  {
                     TROCAR_ESTADO_DE_EXECUCAO(ESTADO_DE_EXECUCAO_COMPRA_POSICAO);
                  }
               return;
            }
         else
            {
               if(CompraSemPosicao())
                  {
                     TROCAR_ESTADO_DE_EXECUCAO(ESTADO_DE_EXECUCAO_COMPRA_INICIAL);
                  }
               else
                  {
                     TROCAR_ESTADO_DE_EXECUCAO(ESTADO_DE_EXECUCAO_MODIFICAR);
                  }
            }
         return;
      }
   if(closeprice < PrecoDeVenda &&
         PrecoDeVenda > 0 &&
         !controlsell)
      {
         if(ExistePosicaoAberta(symboll))
            {
               VendaComPosicao();
               TROCAR_ESTADO_DE_EXECUCAO(ESTADO_DE_EXECUCAO_VENDA_POSICAO);
               return;
            }
         else
            {
               if(VendaSemPosicao())
                  {
                     TROCAR_ESTADO_DE_EXECUCAO(ESTADO_DE_EXECUCAO_VENDA_INICIAL);
                  }
               else
                  {
                     TROCAR_ESTADO_DE_EXECUCAO(ESTADO_DE_EXECUCAO_MODIFICAR);
                  }
            }
         return;
      }
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void ExecutarCompraInicial()
{
processarModificacao();
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void ExecutarVendaInicial()
{
processarModificacao();
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void ExecutarModificacaoVenda()
{
   if(closeprice > Sellsubsicul || Sellsubsicul == 0)
      {
         return;
      }
   if(ExistePosicaoAberta(symboll))
      {
         ModificarVendaComPosicao();
      }
   else
      {
         ModificarVendaSemPosicao();
      }
   if(g_param_auto_surfada)
      {
         TROCAR_ESTADO_DE_EXECUCAO(ESTADO_DE_EXECUCAO_REPOUSO);
      }
   else
      {
         TROCAR_ESTADO_DE_EXECUCAO(ESTADO_DE_EXECUCAO_INICIAL);
      }
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void ExecutarModificacaoCompra()
{
   if(closeprice < Buysubsicul || Buysubsicul == 0)
      {
         return;
      }
   if(ExistePosicaoAberta(symboll))
      {
         ModificarCompraComPosicao();
      }
   else
      {
         ModificarCompraSemPosicao();
      }
   if(g_param_auto_surfada)
      {
         TROCAR_ESTADO_DE_EXECUCAO(ESTADO_DE_EXECUCAO_REPOUSO);
      }
   else
      {
         TROCAR_ESTADO_DE_EXECUCAO(ESTADO_DE_EXECUCAO_INICIAL);
      }
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string historicoEstados[];
string historicoDescricoes[];
double contagem [];
int Cont;
//+------------------------------------------------------------------+
//| Regista estado + descrição                                       |
//+------------------------------------------------------------------+
void RegistrarEstadoExecucao(string estado, string descricao)
{
   int size = ArraySize(historicoEstados);
   ArrayResize(historicoEstados, size + 1);
   ArrayResize(historicoDescricoes, size + 1);
   ArrayResize(contagem, size + 1);
   historicoEstados[size]     = estado;
   historicoDescricoes[size]  = descricao;
   contagem [size] = Cont ++;
   AtualizarEstadoCiclo(estado, descricao);
}
//+------------------------------------------------------------------+
//| Envia relatório completo do ciclo de estados                     |
//+------------------------------------------------------------------+

//+
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void EnviarRelatorioCicloEstados(string sistema)
{
   string msg =
      "<html>"
      "<body style='font-family:Times New Roman;font-size:12px;color:#222;'>"
      "<div style='background:#eaeaea;padding:20px;border-radius:15px;'>"
      "<h2 style='text-align:center;'>📊 RELATÓRIO COMPLETO DA POSIÇAO</h2>"
      "<h3 style='text-align:center;'>Sistema: " + sistema + "</h3>"
      "<h4 style='text-align:center;'>Símbolo: " + _Symbol + " | Timeframe: " +
      EnumToString((ENUM_TIMEFRAMES)_Period) + "</h4>"
      "<hr>"
      "<h3>📜 EXECUÇÃO DOS ESTADOS</h3>";
   for(int i = 0; i < ArraySize(historicoEstados); i++)
      {
         msg +=
            "<div style='background:#f2f2f2;margin:10px;padding:10px;border-radius:10px;'>"
            "<b>" + DoubleToString(contagem[i], 1) + " Descrição:</b><br>" + historicoDescricoes[i] +
            "</div>";
      }
   msg +=
      "<hr>"
      "<p style='text-align:center;'>"
      "📡 Relatório gerado automaticamente pelo sistema de execução do robô."
      "</p>"
      "</div>"
      "</body>"
      "</html>";
   if(!g_param_gmail)
      {
         SendMail("📊 CICLO COMPLETO DE EXECUçãO - " + _Symbol, msg);
      }
   Print("Relatório de ciclo enviado por email.");
// limpar histórico após envio
   ArrayResize(historicoEstados, 0);
   ArrayResize(historicoDescricoes, 0);
   ArrayResize(contagem, 0);
   Cont = 0;
}
//+------------------------------------------------------------------+
//| Atualiza estados e detecta ciclo completo                       |
//+------------------------------------------------------------------+
void AtualizarEstadoCiclo(string estado, string descricao)
{
   static string estadoInicial = "ESTADO_NOVO_CICLO";
   static bool cicloAtivo = false;
// inicia ciclo
   if(estado == estadoInicial && !cicloAtivo)
      {
         cicloAtivo = true;
      }
// se voltou ao inicial de novo → ciclo completo
   if(cicloAtivo && estado == estadoInicial && ArraySize(historicoEstados) > 2)
      {
         EnviarRelatorioCicloEstados("EA FIMASTER");
         RegistrarEstadoExecucao(estado, descricao);
         cicloAtivo = false;
      }
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//| Descrição dos estados do ciclo operacional                       |
//+------------------------------------------------------------------+
string ObterDescricaoEstadoCiclo(ESTADO_SICLO estado)
{
   switch(estado)
      {
      case ESTADO_SICLO_DE_CANAL_INICIAL:
         return "Trader, "
                "A estrutura operacional encontra-se concluída e estou preparado para iniciar um novo ciclo de acompanhamento."
                "Neste momento aguardo o primeiro rompimento válido que permita dar início a uma operação."
                "Dependendo do comportamento dos preços, poderei entrar num ciclo de compra ou num ciclo de venda."
                "O objetivo desta fase é aguardar apenas sinais com elevada probabilidade de sucesso."
                "Continuarei a monitorizar o mercado até à confirmação de uma oportunidade.";
      case ESTADO_SICLO_DE_CANAL_COMPRA:
         return  "Trader, "
                 "Encontro-me atualmente num ciclo de compra ativo."
                 "A operação já foi iniciada e estou a acompanhar o comportamento dos preços para avaliar a evolução da posição."
                 "O mercado poderá continuar a favor da tendência, atingir o Break Even ou regressar contra a posição."
                 "O objetivo desta fase é gerir a operação da forma mais eficiente possível enquanto o movimento permanece válido."
                 "Continuarei a monitorizar cada movimento do mercado e a proteger o capital sempre que necessário.";
      case ESTADO_SICLO_DE_CANAL_VENDA:
         return "Trader, "
                "Encontro-me atualmente num ciclo de venda ativo."
                "A operação foi executada e estou a acompanhar continuamente a evolução do mercado."
                "O preço poderá continuar a descer, atingir zonas de proteção ou invalidar parcialmente o movimento atual."
                "O objetivo desta fase é maximizar o potencial da operação mantendo o controlo do risco."
                "Continuarei a monitorizar cada alteração do mercado em tempo real.";
      case ESTADO_SICLO_DE_CANAL_COMPRA_FINALIZADO:
         return "Trader, "
                "O ciclo de compra foi concluído e as estruturas associadas à operação foram encerradas."
                "Neste momento estou a limpar referências internas, variáveis temporárias e informações utilizadas durante a gestão da posição."
                "Após a conclusão deste processo estarei preparado para iniciar um novo ciclo operacional."
                "O objetivo desta fase é garantir que futuras decisões não sejam influenciadas por dados já utilizados."
                "Continuarei a monitorizar o mercado em busca de novas oportunidades.";
      case ESTADO_SICLO_DE_CANAL_VENDA_FINALIZADO:
         return "Trader, "
                "O ciclo de venda foi concluído e a operação já não requer acompanhamento adicional."
                "Neste momento estou a remover todas as referências utilizadas durante a gestão da posição."
                "Após esta limpeza estarei novamente disponível para iniciar um novo ciclo operacional."
                "O objetivo desta fase é manter a consistência dos dados utilizados pela estratégia."
                "Continuarei a monitorizar o mercado e a aguardar novas oportunidades.";
      default:
         return "Estado do ciclo desconhecido.";
      }
}
//+------------------------------------------------------------------+
//| Descrição detalhada dos estados                                  |
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//| Descrição dos estados de execução                                |
//+------------------------------------------------------------------+
string ObterDescricaoEstadoRobo(ESTADO_ROBO estado)
{
   switch(estado)
      {
      case ESTADO_DE_EXECUCAO_INICIAL:
         return "Trader, "
                "Estou a monitorizar continuamente o mercado à procura de condições compatíveis com a estratégia configurada."
                "Neste momento avalio rompimentos, tendências e critérios operacionais antes de considerar qualquer execução."
                "Caso seja identificada uma oportunidade válida, poderei iniciar uma operação de compra ou venda."
                "O objetivo desta fase é garantir que apenas sinais qualificados sejam considerados."
                "Continuarei a monitorizar o mercado em tempo real.";
      case ESTADO_DE_EXECUCAO_COMPRA_INICIAL:
         return "Trader, "
                "Foi confirmado um rompimento comprador compatível com todos os parâmetros definidos pela estratégia. "
                "Após a validação das condições de mercado, a oportunidade foi considerada legítima para entrada compradora. "
                "Neste momento estou a executar a operação de compra e a preparar a gestão automática da posição. "
                "A partir deste ponto acompanharei atentamente a evolução dos preços para identificar oportunidades de proteção, otimização e continuidade da tendência. "
                "O objetivo desta ação é posicionar a operação numa fase inicial do movimento comprador e aproveitar o potencial desenvolvimento do mercado. "
                "Continuarei a monitorizar cada variação dos preços para garantir uma gestão eficiente da posição.";
      case ESTADO_DE_EXECUCAO_VENDA_INICIAL:
         return "Trader, "
                "Foi confirmado um rompimento vendedor compatível com todos os parâmetros definidos pela estratégia. "
                "Após a validação das condições de mercado, a oportunidade foi considerada legítima para entrada vendedora. "
                "Neste momento estou a executar a operação de venda e a preparar a gestão automática da posição. "
                "A partir deste ponto acompanharei atentamente a evolução dos preços para identificar oportunidades de proteção, otimização e continuidade da tendência. "
                "O objetivo desta ação é posicionar a operação numa fase inicial do movimento vendedor e aproveitar o potencial desenvolvimento do mercado. "
                "Continuarei a monitorizar cada variação dos preços para garantir uma gestão eficiente da pwosição.";
      case ESTADO_DE_EXECUCAO_COMPRA_POSICAO:
         return "Trader, "
                "Existe uma posição de compra ativa sob gestão. "
                "Neste momento acompanho a evolução do mercado e avalio possíveis extensões do movimento. "
                "Poderei proteger ou otimizar a operação conforme necessário. "
                "Continuarei a monitorizar o mercado em tempo real.";
      case ESTADO_DE_EXECUCAO_VENDA_POSICAO:
         return "Trader, "
                "Existe uma posição de venda ativa sob gestão."
                "Neste momento monitorizo o comportamento do mercado e possíveis extensões do movimento. "
                "Poderei ajustar a proteção ou otimizar a operação conforme necessário. "
                "Continuarei a monitorizar o mercado em tempo real.";
      case ESTADO_DE_EXECUCAO_MODIFICAR:
         return"trader, a execução do da posição atual nao foi conclúida com sucesso."
                "portanto, continuarei seguindo o fluxo definido pelos parâmetros existentes, "
                " mantendo a estratégia conforme previamente estruturada  "
                "Durante o processo, sarao extraidos e analisados novos parâmetros relevante para "
                "a tomada de decisoa. permanecerei atento as proximas condiçoes do mercado para realizar uma nova execuçao "
                "somente quando ocs criterios da estratégia forem devidamente atendidas";
      case ESTADO_DE_EXECUCAO_MODIFICAR_COMPRA:
         return "Trader, "
                "Estou a acompanhar a sua posição de compra e tudo decorre dentro dos parâmetros definidos pela estratégia."
                "Neste momento o mercado alcansou a zona de Break Even. modifiquie automaticamente a ordem para proteger a operação contra possíveis reversões."
                "O objetivo desta ação é transformar uma operação exposta ao risco numa operação mais segura, preservando o capital e os ganhos já obtidos."
                "Até lá, continuarei a monitorizar cada movimento do mercado e a avaliar novas oportunidades de otimização da posição.";
      case ESTADO_DE_EXECUCAO_MODIFICAR_VENDA:
         return "Trader, "
                "Estou a acompanhar a sua posição de venda e tudo decorre dentro dos parâmetros definidos pela estratégia."
                "Neste momento o mercado alcansou a zona de Break Even. modifiquie  automaticamente a ordem para proteger a operação contra possíveis reversões."
                "O objetivo desta ação é transformar uma operação exposta ao risco numa operação mais segura, preservando o capital e os ganhos já obtidos."
                "Até lá, continuarei a monitorizar cada movimento do mercado e a avaliar novas oportunidades de otimização da posição.";
      case ESTADO_DE_EXECUCAO_REPOUSO:
         return "Trader, "
                "Neste momento não existem ações pendentes nem operações que exijam intervenção imediata."
                "Todas as verificações programadas foram concluídas e o sistema encontra-se em modo de observação."
                "Caso surjam novas oportunidades compatíveis com a estratégia, retomarei automaticamente as atividades operacionais."
                "O objetivo desta fase é manter vigilância constante sem assumir riscos desnecessários."
                "Continuarei a monitorizar o mercado e a aguardar novos eventos relevantes.";
      default:
         return "Estado de execução desconhecido.";
      }
}
//+------------------------------------------------------------------+
//| Descrição detalhada dos estados de preços                        |
//+------------------------------------------------------------------+
string ObterDescricaoEstadoPrecos(ESTADO_DE_PRECOS estado)
{
   switch(estado)
      {
      case ESTADO_NOVO_CICLO:
         return "Trader, "
                "Iniciei um novo ciclo de organização dos preços. Todas as referências utilizadas no ciclo anterior foram analisadas e as estruturas antigas estão a ser substituídas por novos dados do mercado."
                "Neste momento estou a preparar o ambiente para construir uma nova estrutura operacional, recolhendo informações que servirão de base para a formação do próximo canal."
                "O próximo passo será verificar se os preços atuais apresentam características compatíveis com os parâmetros definidos pela estratégia."
                "O objetivo desta fase é garantir que todas as decisões futuras sejam tomadas com base em dados atualizados e relevantes."
                "Continuarei a monitorizar o mercado e a organizar as informações necessárias para a próxima etapa.";
      case ESTADO_EXPANSAO_RANGE:
         return "Trader, "
                "Estou a analisar a expansão atual dos preços para verificar se o mercado apresenta condições adequadas para a construção da estrutura operacional."
                "Neste momento avalio a amplitude do movimento, a consistência da expansão e o respeito pelos parâmetros definidos pela estratégia."
                "Caso os critérios sejam satisfeitos, avançarei para a validação do canal. Se forem identificadas inconsistências, realizarei os ajustes necessários antes de prosseguir."
                "O objetivo desta análise é garantir que a estrutura seja construída sobre movimentos legítimos e não sobre oscilações aleatórias."
                "Continuarei a acompanhar a evolução dos preços até obter uma confirmação segura.";
      case ESTADO_AJUSTE_CANAL:
         return "Trader, "
                "Identifiquei que a estrutura atual necessita de ajustes antes de poder ser utilizada operacionalmente."
                "Neste momento estou a recalcular os limites do canal, analisando suportes, resistências e zonas de expansão para obter uma configuração mais precisa."
                "Após a conclusão destes ajustes, o canal poderá ser validado e preparado para utilização."
                "O objetivo desta fase é aumentar a qualidade da leitura do mercado e reduzir a probabilidade de sinais incorretos."
                "Continuarei a monitorizar os preços até concluir todos os ajustes necessários. "
                "configuração válida.";
      case ESTADO_CANAL_PRONTO:
         return "Trader, "
                "Concluí com sucesso a construção da estrutura de preços atual."
                "Neste momento o canal encontra-se validado e pronto para utilização operacional. Os níveis de suporte, resistência e expansão já foram calculados e armazenados."
                "Agora permanecerei em observação aguardando um rompimento confirmado para cima ou para baixo."
                "Se ocorrer um rompimento superior poderei iniciar uma operação de compra. Caso ocorra um rompimento inferior poderei iniciar uma operação de venda."
                "Continuarei a monitorizar o mercado em tempo real até que uma destas condições seja satisfeita.";
      case ESTADO_ROMPIMENTO_CIMA:
         return "Trader, "
                "oi confirmado um rompimento acima da resistência principal da estrutura atual."
                "Neste momento estou a validar as condições finais necessárias para a execução de uma operação compradora."
                "Se o movimento mantiver a sua consistência, avançarei para o processo de entrada em compra."
                "O objetivo desta fase é garantir que o rompimento representa uma oportunidade real e não apenas um movimento temporário do mercado."
                "Continuarei a acompanhar o comportamento dos preços antes da execução definitiva.";
      case ESTADO_ROMPIMENTO_BAIXO:
         return "Trader, "
                "Foi confirmado um rompimento abaixo do suporte principal da estrutura atual."
                "Neste momento estou a validar as condições finais necessárias para a execução de uma operação vendedora."
                "Se o movimento mantiver a sua consistência, avançarei para o processo de entrada em venda."
                "O objetivo desta fase é garantir que o rompimento representa uma oportunidade legítima e compatível com a estratégia."
                "Continuarei a monitorizar o mercado antes de concluir a execução.";
      case ESTADO_DE_PRECOS_CONCLUIDO:
         return "Trader, "
                "Concluí todas as etapas relacionadas com a organização e distribuição da estrutura de preços."
                "Neste momento os dados necessários para a tomada de decisão encontram-se disponíveis para os restantes módulos do sistema."
                "A estrutura foi validada, processada e preparada para utilização operacional."
                "O próximo passo será acompanhar os eventos de mercado e executar as ações correspondentes sempre que as condições forem satisfeitas."
                "Continuarei a monitorizar continuamente a evolução do mercado.";
      case ESTADO_DE_PRECOS_PARAMETROS:
         return "Trader, ""OS PERAMERTOS NAO CORESPONDENTES A ESTRATEGIA";
      default:
         return "Estado desconhecido.";
      }
}
enum TIPO_ESTADO_SISTEMA
{
   SISTEMA_ROBO,
   SISTEMA_SICLO,
   SISTEMA_PRECOS
};
//+------------------------------------------------------------------+
//| Função genérica de envio de email de estado                     |
//+------------------------------------------------------------------+
void EnviarEmailEstado(
   TIPO_ESTADO_SISTEMA tipoSistema,
   string estadoAnterior,
   string estadoNovo,
   string descAnterior,
   string descNovo
)
{
   string sistemaNome;
   switch(tipoSistema)
      {
      case SISTEMA_ROBO:
         sistemaNome = "ESTADO DE EXECUÇAO";
         break;
      case SISTEMA_SICLO:
         sistemaNome = "ESTADO DE CANAL";
         break;
      case SISTEMA_PRECOS:
         sistemaNome = "ESTADO DE PREÇOS";
         break;
      default:
         sistemaNome = "SISTEMA DESCONHECIDO";
      }
   string assunto = StringFormat("[%s] MUDANÇA DE ESTADO - %s",
                                 _Symbol,
                                 sistemaNome);
   string mensagem =
      "<html>"
      "<body style='font-family: Times New Roman, serif; font-size: 12px; color: #222; background-color: #f7f7f7;'>"
      "<div style='background-color: #eaeaea; border-radius: 20px; padding: 20px;"
      "box-shadow: 0px 0px 5px rgba(0.4,0.4,0.4,0.4);'>"
      "<h2 style='text-align:center; border-bottom:2px solid #666; padding-bottom:10px;'>"
      "🧾 RELATÓRIO DE TRANSIÇÃO DE ESTADO"
      "</h2>"
      "<div style='background-color:#dcdcdc; padding:15px; border-radius:5px;"
      "margin-bottom:10px; border:1px solid #bbb;'>"
      "<h3 style='text-align:center;'>📋 Informações Gerais</h3>"
      "<ul style='list-style:none; padding:0;'>"
      "<li style='border-bottom:1px solid #bbb; padding:3px;'>"
      "<b>⚙ Sistema:</b>"
      "<span style='float:right;'>" + sistemaNome + "</span>"
      "</li>"
      "<li style='border-bottom:1px solid #bbb; padding:3px;'>"
      "<b>📈 Símbolo:</b>"
      "<span style='float:right;'>" + _Symbol + "</span>"
      "</li>"
      "<li style='border-bottom:1px solid #bbb; padding:3px;'>"
      "<b>🕒 Timeframe:</b>"
      "<span style='float:right;'>" +
      EnumToString((ENUM_TIMEFRAMES)_Period) +
      "</span>"
      "</li>"
      "<li style='border-bottom:1px solid #bbb; padding:3px;'>"
      "<b>👤 Conta:</b>"
      "<span style='float:right;'>" +
      IntegerToString(AccountInfoInteger(ACCOUNT_LOGIN)) +
      "</span>"
      "</li>"
      "<li style='padding:3px;'>"
      "<b>🌐 Servidor:</b>"
      "<span style='float:right;'>" +
      AccountInfoString(ACCOUNT_SERVER) +
      "</span>"
      "</li>"
      "</ul>"
      "</div>"
      "<div style='background-color:#f2f2f2; padding:15px; border-radius:5px;"
      "margin-bottom:10px; border:1px solid #bbb;'>"
      "<h3 style='text-align:center;'>📅 Data e Hora</h3>"
      "<p style='text-align:center; font-weight:bold;'>"
      + TimeToString(TimeCurrent(), TIME_DATE | TIME_SECONDS) +
      "</p>"
      "</div>"
      "<div style='background-color:#dcdcdc; padding:15px; border-radius:5px;"
      "margin-bottom:10px; border:1px solid #bbb;'>"
      "<h3 style='text-align:center;'>🔄 Estado Anterior</h3>"
      "<p><b>" " ESTADO ANTERIOR " "</b></p>"
      "<p>" + descAnterior + "</p>"
      "</div>"
      "<div style='background-color:#f2f2f2; padding:15px; border-radius:5px;"
      "margin-bottom:10px; border:1px solid #bbb;'>"
      "<h3 style='text-align:center;'>🏷 Novo Estado</h3>"
      "<p><b>" "NOVO ESTADO ""</b></p>"
      "<p>" + descNovo + "</p>"
      "</div>"
      "<div style='background-color:#dcdcdc; padding:15px; border-radius:5px;"
      "border:1px solid #bbb;'>"
      "<h3 style='text-align:center;'>📢 Resumo</h3>"
      "<p style='text-align:center;'>"
      "O sistema efetuou uma transição de estado com sucesso. "
      "Todos os módulos associados foram notificados e o processo "
      "continuará normalmente conforme as regras do algoritmo."
      "</p>"
      "</div>"
      "<h3 style='text-align:center; border-top:2px solid #666;"
      "padding-top:10px;'>"
      "✅ Monitorização automática ativa"
      "</h3>"
      "</div>"
      "<div style='margin-top:20px; text-align:center;"
      "border-top:1px solid #bbb; padding-top:10px;"
      "font-size:14px; color:#555;'>"
      "<p>Atenciosamente</p>"
      "<p><b>EA fimaster</b></p>"
      "<p>Sistema Automático de Trading</p>"
      "</div>"
      "</body>"
      "</html>";
   sistemaNome = (tipoSistema == SISTEMA_ROBO) ? "ESTADO DE EXECUCAO" : ((tipoSistema == SISTEMA_SICLO) ? "ESTADO DE CANAL" : "ESTADO DE PRECOS");
   string payload = StringFormat(
                       "{\"event\":\"mudanca_estado\",\"sistema\":\"%s\",\"login\":%s,\"symbol\":\"%s\",\"anterior\":\"%s\",\"novo\":\"%s\",\"discricao\":\"%s\",\"timestamp\":%d}",
                       sistemaNome, ObterContaMt5Login(), _Symbol, estadoAnterior, estadoNovo, descNovo, (int)TimeCurrent()
                    );
   EnviarPutHTTP(ObterEventosEndpointFirebase("mudanca_estado"), payload);
   SendMailMQL5(assunto, mensagem);
}
//+------------------------------------------------------------------+
//| Atualiza painel com última transição                            |
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool ProcessarCompraInicial()
{
   if(!roboAtivo || !g_ea_ativo)
      {
         return false;
      }
   if(closeprice < PrecoDeCompra || PrecoDeCompra == 0)
      {
         return false;
      }
   if(controlbuy)
      {
         return false;
      }
   if(ExistePosicaoAberta(symboll))
      {
         if(CompraComPosicao())
            {
               return true;
            }
         return false;
      }
   else
      {
         if(CompraSemPosicao())
            {
               return true;
            }
         return false;
      }
   return false;
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool  ProcessarVendaInicial()
{
   if(!roboAtivo || !g_ea_ativo)
      {
         return false;
      }
   if(closeprice > PrecoDeVenda || PrecoDeVenda == 0)
      {
         return false;
      }
   if(controlsell)
      {
         return false;
      }
   if(ExistePosicaoAberta(symboll))
      {
         if(VendaComPosicao())
            {
               return true;
            }
         return false;
      }
   else
      {
         if(VendaSemPosicao())
            {
               return true;
            }
         return false;
      }
   return false;
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool VendaComPosicao()
{
   PrecoDeVenda = PrecoDeVenda ;
   PrecoDeCompra = PrecoDeVenda + pontosf;
   Buysubsicul = PrecoDeCompra + divisao;
   Buymodif = PrecoDeCompra;
   Sellsubsicul = PrecoDeVenda - divisao;
   SellModif = PrecoDeVenda;
   controlbuy = false;
   controlsellmdf = false;
   controlbuymdf = false;
   segundo_control_de_takbuy = false;
   segundo_control_de_taksell = false;
   controlsell = true;
   return true ;
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool  VendaSemPosicao()
{
   PrecoDeVenda = PrecoDeVenda ;
   PrecoDeCompra = PrecoDeVenda + pontosf;
   Buytake = PrecoDeCompra + (pontosf * g_param_niveis) ;
   Buystop = PrecoDeCompra - pontosf;
   Buysubsicul = PrecoDeCompra + divisao;
   Buymodif = PrecoDeCompra;
   Selltake = PrecoDeVenda  - (pontosf * g_param_niveis) ;
   Sellestop = PrecoDeVenda + pontosf;
   Sellsubsicul = PrecoDeVenda - divisao;
   SellModif = PrecoDeVenda;
   if(!control_de_venda)
      {
         controlbuy = false;
         control_de_venda = true;
         controlsellmdf = false;
         controlbuymdf = false;
         segundo_control_de_takbuy = false;
         segundo_control_de_taksell = false;
         controlsell = true;
         if(!g_param_ativar_venda)
            {
               Print(" ordem de venda desativado :");
               notifica = " ordem de venda desativado :" ;
               enviarnotificacvao(notifica);
               return false;
            }
         if(!condicao)
            {
               Print(" ordem de venda travado por fechamento :", pntosDEvelaV, " > ", pontsDEentrada, ": pontos de entrada");
               notifica = " ordem de venda travado por fechamento :" + DoubleToString(pntosDEvelaV, 1) + " > " + DoubleToString(pontsDEentrada, 1) + ": pontos de entrada";
               enviarnotificacvao(notifica);
               return false;
            }
         if(!comando_venda)
            {
               Print(" ordem de venda travdo por linha de equador  :", comando_venda);
               notifica = " ordem de venda trvado por linha de equador ou por tendência :" + (!comando_venda ? "verdade" : "falso");
               enviarnotificacvao(notifica);
               return false;
            }
         if(!contol_de_gerenciamento  || !contol_de_gerenciamento_semanal)
            {
               Print(" ordem de venda travdo por contol_de_gerenciamento. DIARIO  :", contol_de_gerenciamento ? "" : "DIARIO", contol_de_gerenciamento_semanal ? "" : "SEMANAL");
               notifica = "ordem de venda trvado por contol_de_gerenciamento :" + (!contol_de_gerenciamento ? "DIARIO" : " ") + ":" + (!contol_de_gerenciamento_semanal ? "SEMANAL" : "");
               enviarnotificacvao(notifica);
               return false;
            }
         if(SellMarkt())
            {
               return true;
            }
      }
   return false;
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool CompraComPosicao()
{
   PrecoDeVenda = PrecoDeCompra - pontosf;
   Buysubsicul = PrecoDeCompra + divisao;
   Buymodif    = PrecoDeCompra;
   Sellsubsicul = PrecoDeVenda - divisao;
   SellModif    = PrecoDeVenda;
   controlsell = false;
   controlbuymdf = false;
   controlsellmdf = false;
   segundo_control_de_takbuy = false;
   segundo_control_de_taksell = false;
   controlbuy = true;
   return true ;
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool CompraSemPosicao()
{
   PrecoDeVenda = PrecoDeCompra - pontosf;
   Buytake  = PrecoDeCompra + (pontosf * g_param_niveis);
   Buystop  = PrecoDeCompra - pontosf;
   Buysubsicul = PrecoDeCompra + divisao;
   Buymodif    = PrecoDeCompra;
   Selltake = PrecoDeVenda - (pontosf * g_param_niveis);
   Sellestop = PrecoDeVenda + pontosf;
   Sellsubsicul = PrecoDeVenda - divisao;
   SellModif    = PrecoDeVenda;
   if(! control_de_compra)
      {
         controlsell = false;
         control_de_compra = true;
         controlbuymdf = false;
         controlsellmdf = false;
         segundo_control_de_takbuy = false;
         segundo_control_de_taksell = false;
         controlbuy = true;
         if(!g_param_ativar_compra)
            {
               Print(" ordem de compra desativado");
               notifica = " ordem de compra desativado";
               enviarnotificacvao(notifica);
               return false;
            }
         if(!condicao2)
            {
               Print(" ordem de compra travado por fechamento :", pntosDEvelaC, " > ", pontsDEentrada, ": pontos de entrada");
               notifica = " ordem de compra travado por fechamento :" + DoubleToString(pntosDEvelaC, 1) + " > " + DoubleToString(pontsDEentrada, 1) + ": pontos de entrada";
               enviarnotificacvao(notifica);
               return false;
            }
         if(!comando_compra)
            {
               Print(" ordem de compra trvado por linha de equador ou por tendência :", comando_compra);
               notifica = " ordem de compra trvado por linha de equador ou por tendência :" + (!comando_compra ? "verdade" : "falso");
               enviarnotificacvao(notifica);
               return false;
            }
         if(!contol_de_gerenciamento || !contol_de_gerenciamento_semanal)
            {
               Print("ordem de compra trvado por contol_de_gerenciamento DIARIO  :", contol_de_gerenciamento, ". SEMANAL :", contol_de_gerenciamento_semanal);
               notifica = "ordem de compra trvado por contol_de_gerenciamento :" + (!contol_de_gerenciamento ? "DIARIO" : " ") + " : " + (!contol_de_gerenciamento_semanal ? "SEMANAL" : "");
               enviarnotificacvao(notifica);
               return false;
            }
         if(BuyMarkt())
            {
               return true;
            }
      }
   return false;
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool  ProcessarModificacaoCompra()
{
   if(closeprice < Buysubsicul || Buysubsicul == 0)
      {
         return false;
      }
   if(controlbuymdf)
      {
         return false;
      }
   if(ExistePosicaoAberta(symboll))
      {
         if(ModificarCompraComPosicao())
            {
               return true;
            }
         return false;
      }
   else
      {
         if(ModificarCompraSemPosicao())
            {
               return true;
            }
         return false;
      }
   return false;
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool  ProcessarModificacaoVenda()
{
   if(closeprice > Sellsubsicul || Sellsubsicul == 0)
      {
         return false;
      }
   if(controlsellmdf)
      {
         return false;
      }
   if(ExistePosicaoAberta(symboll))
      {
         if(ModificarVendaComPosicao())
            {
               return true;
            }
         return false;
      }
   else
      {
         if(ModificarVendaSemPosicao())
            {
               return true;
            }
         return false;
      }
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool ModificarVendaComPosicao()
{
   controlbuy = false;
   controlsell = false;
   controlsellmdf = true;
   controlbuymdf = false;
   atualizarompimento();
   if(Costura)
      {
         control_de_compra = false;
         control_de_venda = false;
      }
   if(bingala_de_baixa > espassao)
      {
         canaisv = (bingala_de_baixa / espassao);
         for(int i = (int) g_param_niveis  ; i <= canaisv ; i++)
            {
               PrecoDeCompra = PrecoDeVenda;
               PrecoDeVenda = PrecoDeVenda - pontosf;
               Buysubsicul = PrecoDeCompra + divisao;
               Buymodif = PrecoDeCompra;
               Sellsubsicul = PrecoDeVenda - divisao;
               SellModif = PrecoDeCompra;
            }
         if(ModifySellOrder())
            {
               return true;
            }
         return false;
      }
   else
      {
         if(ModifySellOrder())
            {
               PrecoDeCompra = PrecoDeVenda;
               PrecoDeVenda = PrecoDeVenda - pontosf;
               Buysubsicul = PrecoDeCompra + divisao;
               Buymodif = PrecoDeCompra;
               Sellsubsicul = PrecoDeVenda - divisao;
               SellModif = PrecoDeVenda;
               return true;
            }
         PrecoDeCompra = PrecoDeVenda;
         PrecoDeVenda = PrecoDeVenda - pontosf;
         Buysubsicul = PrecoDeCompra + divisao;
         Buymodif = PrecoDeCompra;
         Sellsubsicul = PrecoDeVenda - divisao;
         SellModif = PrecoDeVenda;
         return false;
      }
   return false;
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool  ModificarVendaSemPosicao()
{
   if(bingala_de_baixa > espassao)
      {
         canaisv = (bingala_de_baixa / espassao);
         for(int i = (int) g_param_niveis  ; i <= canaisv ; i++)
            {
               PrecoDeCompra = PrecoDeVenda;
               PrecoDeVenda = PrecoDeVenda - pontosf;
               Buytake = PrecoDeCompra + (pontosf * g_param_niveis);
               Buystop = PrecoDeCompra - pontosf;
               Buysubsicul = PrecoDeCompra + divisao;
               Buymodif = PrecoDeCompra;
               Selltake = PrecoDeVenda  - (pontosf * g_param_niveis);
               Sellestop = PrecoDeVenda + pontosf;
               Sellsubsicul = PrecoDeVenda - divisao;
               SellModif = PrecoDeVenda;
            }
      }
   else
      {
         PrecoDeCompra = PrecoDeVenda;
         PrecoDeVenda = PrecoDeVenda - pontosf;
         Buytake = PrecoDeCompra + (pontosf * g_param_niveis) ;
         Buystop = PrecoDeCompra - pontosf;
         Buysubsicul = PrecoDeCompra + divisao;
         Buymodif = PrecoDeCompra;
         Selltake = PrecoDeVenda  - (pontosf * g_param_niveis) ;
         Sellestop = PrecoDeVenda + pontosf;
         Sellsubsicul = PrecoDeVenda - divisao;
         SellModif = PrecoDeVenda;
      }
   if(Costura)
      {
         control_de_compra = false;
         control_de_venda = false;
      }
   controlbuy = false;
   controlsell = false;
   controlsellmdf = true;
   controlbuymdf = false;
   atualizarompimento();
   return true ;
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool ModificarCompraComPosicao()
{
   if(Costura)
      {
         control_de_venda = false;
         control_de_compra = false;
      }
   controlbuy = false;
   controlsell = false;
   controlbuymdf = true;
   controlsellmdf = false;
   atualizarompimento();
   if(bingala_de_alta > espassao)
      {
         canais = (bingala_de_alta / espassao);
         for(int i = (int) g_param_niveis  ; i <= canais ; i++)
            {
               PrecoDeVenda = PrecoDeCompra;
               PrecoDeCompra = PrecoDeCompra + pontosf;
               Buysubsicul = PrecoDeCompra + divisao;
               Buymodif = PrecoDeVenda;
               Sellsubsicul = PrecoDeVenda - divisao;
               SellModif = PrecoDeVenda;
            }
         if(ModifyBuyOrder())
            {
               return true;
            }
         return false ;
      }
   else
      {
         if(ModifyBuyOrder())
            {
               PrecoDeVenda = PrecoDeCompra;
               PrecoDeCompra = PrecoDeCompra + pontosf;
               Buysubsicul = PrecoDeCompra + divisao;
               Buymodif = PrecoDeCompra;
               Sellsubsicul = PrecoDeVenda - divisao;
               SellModif = PrecoDeVenda;
               return true ;
            }
         PrecoDeVenda = PrecoDeCompra;
         PrecoDeCompra = PrecoDeCompra + pontosf;
         Buysubsicul = PrecoDeCompra + divisao;
         Buymodif = PrecoDeCompra;
         Sellsubsicul = PrecoDeVenda - divisao;
         SellModif = PrecoDeVenda;
         return false ;
      }
   return false;
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool ModificarCompraSemPosicao()
{
   if(bingala_de_alta > espassao)
      {
         canais = (bingala_de_alta / espassao);
         for(int i = (int) g_param_niveis  ; i <= canais ; i++)
            {
               PrecoDeVenda = PrecoDeCompra;
               PrecoDeCompra = PrecoDeCompra + pontosf;
               Buytake = PrecoDeCompra + (pontosf * g_param_niveis);
               Buystop = PrecoDeCompra - pontosf;
               Buysubsicul = PrecoDeCompra + divisao;
               Buymodif = PrecoDeCompra;
               Selltake = PrecoDeVenda  - (pontosf * g_param_niveis) ;
               Sellestop = PrecoDeVenda + pontosf;
               Sellsubsicul = PrecoDeVenda - divisao;
               SellModif = PrecoDeVenda;
            }
      }
   else
      {
         PrecoDeVenda = PrecoDeCompra;
         PrecoDeCompra = PrecoDeCompra + pontosf;
         Buytake = PrecoDeCompra + (pontosf * g_param_niveis) ;
         Buystop = PrecoDeCompra - pontosf;
         Buysubsicul = PrecoDeCompra + divisao;
         Buymodif = PrecoDeCompra;
         Selltake = PrecoDeVenda  - (pontosf * g_param_niveis) ;
         Sellestop = PrecoDeVenda + pontosf;
         Sellsubsicul = PrecoDeVenda - divisao;
         SellModif = PrecoDeVenda;
      }
   if(Costura)
      {
         control_de_venda = false;
         control_de_compra = false;
      }
   controlbuy = false;
   controlsell = false;
   controlbuymdf = true;
   controlsellmdf = false;
   atualizarompimento();
   return true;
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
// 🌐 REGISTRO DE EVENTO PARA O APLICATIVO ANDROID
// ====================================================================
void RegistrarEventoNotificacaoApp(string mensagemNotificacao)
{
   ulong accountId = AccountInfoInteger(ACCOUNT_LOGIN);
   string symbol = Symbol();
   datetime nowTime = TimeCurrent();
   string payloadJson = "{" +
                        "\"event\":\"ordem_não_executada\"," +
                        "\"login\":" + IntegerToString(accountId) + "," +
                        "\"symbol\":\"" + symbol + "\"," +
                        "\"msg\":\"" + mensagemNotificacao + "\"," +
                        "\"timestamp\":" + IntegerToString((long)nowTime) +
                        "}";
   Print("📡 Evento MQL5 pronto para o App: ", payloadJson);
   EnviarPutHTTP(ObterEventosEndpointFirebase("ordem_não_executada"), payloadJson);
}


// ====================================================================
// 📨 FUNÇÃO DE ENVIO DE NOTIFICAÇÕES (TERMINAL, MOBILE E APP FIREBASE)
// ====================================================================
void enviarnotificacvao(string textoNotificacao)
{
// 1. Exibe no Terminal do MetaTrader 5
   Print("🔔 [NOTIFICAÇÃO EA FIMASTER]: ", textoNotificacao);
// 2. Envia notificação Push nativa para o MetaTrader Mobile (se configurado MetaQuotes ID)
   if( SendNotification("EA Fimaster [" + Symbol() + "]: " + textoNotificacao))
      {
         Print("notificaçao enviada");
      }
   else
      {
         Print("notificaçao recusada :", GetLastError());
      }
// 3. Registra evento no log interno de eventos para transmissão ao App Android via REST/Firebase
   RegistrarEventoNotificacaoApp(textoNotificacao);
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string ChartScreenShott()
{
   string periodo = EnumToString(_Period);
   datetime agora = TimeCurrent();
   string data_hora = TimeToString(agora, TIME_DATE | TIME_MINUTES | TIME_SECONDS);
   StringReplace(data_hora, ":", "-");
   StringReplace(data_hora, " ", "_");
   string nome_arquivo = "MT5_Upload\\grafico_upload.png";
   string caminho_arquivo = nome_arquivo;
   bool sucesso = ChartScreenShot(0, caminho_arquivo, 1024, 768, ALIGN_RIGHT);
   if(!sucesso)
      {
         Print("Erro ao tirar o screenshot.", GetLastError());
         //return;
      }
   Sleep(3000); // aguarda garantir que o arquivo foi criado
   string assunto = "Gráfico de " + symboll + " - " + periodo;
   string corpo   = "Segue o gráfico capturado em " + TimeToString(agora, TIME_DATE | TIME_MINUTES);
   return caminho_arquivo ;
}
string veja ;
// EA_Equador_StateMachine.mq5
// Implementa uma máquina de estados para a lógica das LINHAS_DE_EQUADOR
// Mantém a lógica funcional do teu bloco original, mas organizada em estados,
// funções isoladas e pontos únicos de alteração para comando_compra/comando_venda.
// Observação: adapte nomes de variáveis externas (closeprice, precocurrentevA, precocurrentecB,
// PrecoDeCompra, PrecoDeVenda, pontosf, expansao, meio, etc.) para as tuas variáveis reais do EA.
// -------- ENUMS / TIPOS --------
enum EST_EQUADOR
{
   EQ_NEUTRO = 0,

// atualizações das linhas
   EQ_ATUALIZAR_ALTA,
   EQ_ATUALIZAR_BAIXA,

// estados da zona de trade quando TENDENCIA == ALTA
   EQ_ALTA_Z1,
   EQ_ALTA_Z2,
   EQ_ALTA_Z3,

// estados da zona de trade quando TENDENCIA == BAIXA
   EQ_BAIXA_Z1,
   EQ_BAIXA_Z2,
   EQ_BAIXA_Z3,

};
enum COMANDO
{
   CMD_NENHUM,
   CMD_COMPRA,
   CMD_VENDA
};
// -------- VARIÁVEIS DE ESTADO (GLOBAL CONTROLADO) --------
EST_EQUADOR estado_equador = EQ_NEUTRO; // único ponto de verdade para "eq*"
// -------- HELPERS --------
void MudarEstado(EST_EQUADOR novo)
{
   if(estado_equador == novo)
      {
         return;
      }
   Print("Estado equador -> ", novo);
// Atualiza o estado
   EST_EQUADOR anterior = estado_equador;
   estado_equador = novo;
// JSON Payload para mudança de estado do Equador
   string alertMsg = StringFormat("Equador alterado de %s para %s", EnumToString(anterior), EnumToString(novo));
   string payload = StringFormat(
                       "{\"event\":\"mudanca_equador\",\"symbol\":\"%s\",\"anterior\":\"%s\",\"novo\":\"%s\",\"msg\":\"%s\",\"timestamp\":%d}",
                       _Symbol,
                       EnumToString(anterior),
                       EnumToString(novo),
                       alertMsg,
                       (int)TimeCurrent()
                    );
   EnviarPutHTTP(ObterEventosEndpointFirebase("mudanca_equador"), payload);
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void AplicarComando(COMANDO cmd)
{
// único lugar que altera comando_compra / comando_venda
   comando_compra = false;
   comando_venda = false;
   if(cmd == CMD_COMPRA)
      {
         comando_compra = true;
      }
   else if(cmd == CMD_VENDA)
      {
         comando_venda = true;
      }
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool EspacoCompraInsuficiente()
{
   return ((equador_semanal_alta - PrecoDeCompra) < pontosf);
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool EspacoVendaInsuficiente()
{
   return ((PrecoDeVenda - equador_semanal_baixa) < pontosf);
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
COMANDO AvaliarComandoCompra(bool virada)
{
   if(EspacoCompraInsuficiente())
      {
         if(virada)
            {
               return CMD_VENDA;
            }
         return CMD_NENHUM;
      }
   return CMD_COMPRA;
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
COMANDO AvaliarComandoVenda(bool virada)
{
   if(EspacoVendaInsuficiente())
      {
         if(virada)
            {
               return CMD_COMPRA;
            }
         return CMD_NENHUM;
      }
   return CMD_VENDA;
}
// -------- MANIPULADORES DE ATUALIZAÇÃO DAS LINHAS --------
void HandleAtualizarAlta()
{
// corresponde ao teu if(precocurrentecB >= equador_semanal_alta)
// atualiza flags e linhas
// no teu código original: eq4=false; eq2=false; eq5=true; eq8=true; etc.
// Aqui mapeamos essas "flags" para estado: após atualizar, vamos para um estado inicial de decisão
   equador_semanal_baixa = equador_semanal_alta;
   equador_semanal_alta = equador_semanal_baixa + expansao;
   equador_diario_centro = equador_semanal_alta - meio;
   criarlinhaequador_alta(equador_semanal_alta);
   criarlinhaequador_cento(equador_diario_centro);
// após atualização, vamos para estado neutro de decisão
   MudarEstado(EQ_ALTA_Z1);
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void HandleAtualizarBaixa()
{
   equador_semanal_alta = equador_semanal_baixa;
   equador_semanal_baixa = equador_semanal_alta - expansao;
   equador_diario_centro = equador_semanal_alta - meio;
   criarlinhaequador_baixa(equador_semanal_baixa);
   criarlinhaequador_cento(equador_diario_centro);
   MudarEstado(EQ_BAIXA_Z1);
}
// -------- ESTADOS DE DECISAO: TENDENCIA ALTA --------
void Estado_Alta_Z1()
{
   if(precocurrentevA < equador_diario_centro)
      {
         COMANDO cmd = AvaliarComandoCompra(g_param_virada_jogo);
         AplicarComando(cmd);
         MudarEstado(EQ_ALTA_Z2);
      }
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void Estado_Alta_Z2()
{
   if(precocurrentecB > equador_diario_centro)
      {
         COMANDO cmd = AvaliarComandoCompra(g_param_virada_jogo);
         AplicarComando(cmd);
         MudarEstado(EQ_ALTA_Z3);
      }
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void Estado_Alta_Z3()
{
   if(precocurrentevA < equador_diario_centro)
      {
         COMANDO cmd = AvaliarComandoVenda(g_param_virada_jogo);
         AplicarComando(cmd);
         MudarEstado(EQ_ALTA_Z2);
      }
}
// -------- ESTADOS DE DECISAO: TENDENCIA BAIXA --------
void Estado_Baixa_Z1()
{
   if(precocurrentecB > equador_diario_centro)
      {
         COMANDO cmd = AvaliarComandoVenda(g_param_virada_jogo);
         AplicarComando(cmd);
         MudarEstado(EQ_BAIXA_Z2);
      }
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void Estado_Baixa_Z2()
{
   if(precocurrentevA < equador_diario_centro)
      {
         COMANDO cmd = AvaliarComandoVenda(g_param_virada_jogo);
         AplicarComando(cmd);
         MudarEstado(EQ_BAIXA_Z3);
      }
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void Estado_Baixa_Z3()
{
   if(precocurrentecB > equador_diario_centro)
      {
         COMANDO cmd = AvaliarComandoCompra(g_param_virada_jogo);
         AplicarComando(cmd);
         MudarEstado(EQ_BAIXA_Z2);
      }
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void ProcessarEquador()
{
   if(!g_param_linhas_eq)
      {
         return;
      }
   if(precocurrentecB > equador_semanal_alta)
      {
         MudarEstado(EQ_ATUALIZAR_ALTA);
      }
   else if(precocurrentevA < equador_semanal_baixa)
      {
         MudarEstado(EQ_ATUALIZAR_BAIXA);
      }
// dispatcher do estado
   switch(estado_equador)
      {
      case EQ_ATUALIZAR_ALTA:
         HandleAtualizarAlta();
         break;
      case EQ_ATUALIZAR_BAIXA:
         HandleAtualizarBaixa();
         break;
      case EQ_ALTA_Z1:
         Estado_Alta_Z1();
         break;
      case EQ_ALTA_Z2:
         Estado_Alta_Z2();
         break;
      case EQ_ALTA_Z3:
         Estado_Alta_Z3();
         break;
      case EQ_BAIXA_Z1:
         Estado_Baixa_Z1();
         break;
      case EQ_BAIXA_Z2:
         Estado_Baixa_Z2();
         break;
      case EQ_BAIXA_Z3:
         Estado_Baixa_Z3();
         break;
      case EQ_NEUTRO:
      default:
         // lógica inicial: se houve atualização de linhas, pode querer entrar no primeiro estado
         if(g_param_tendencia == TENDENCIA_DE_ALTA)
            {
               if(precocurrentecB > equador_diario_centro)
                  {
                     MudarEstado(EQ_ALTA_Z2);
                  }
               else
                  {
                     MudarEstado(EQ_ALTA_Z1);
                  }
            }
         else if(g_param_tendencia == TENDENCIA_DE_BAIXA)
            {
               if(precocurrentecB > equador_diario_centro)
                  {
                     MudarEstado(EQ_BAIXA_Z1);
                  }
               else
                  {
                     MudarEstado(EQ_BAIXA_Z2);
                  }
            }
         break;
      }
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
//// Variável para armazenar o ID do último negócio correspondente ao símbolo
//ulong lastDealId = 0;
//// Obter o número total de negócios históricos
//int totalDeals = HistoryDealsTotal();
//// Loop por cada negociação histórica
//for(int i = 0; i < totalDeals; i++)
//  {
//// Obtemos o ID do negócio
//   ulong deal_id = HistoryDealGetTicket(i);
//// Verifica o símbolo da negociação
//   if(HistoryDealGetString(deal_id, DEAL_SYMBOL) == symboll)
//     {
//      // Atualiza o último negócio correspondente
//      lastDealId = deal_id;
//     }
//// Chamamos a função CheckDealReason e exibimos o resultado
//   string motivo = CheckDealReason(deal_id);
//   PrintFormat("Negociação %d: %s", deal_id, motivo);
//  }
//// Verifica se encontramos uma negociação do símbolo desejado
//if(lastDealId != 0)
//  {
//// Chamamos a função CheckDealReason e exibimos o resultado
//   string motivo = CheckDealReason(lastDealId);
//   PrintFormat("Última Negociação para %s: %d: %s", symboll, lastDealId, motivo);
//  }
//else
//  {
//   PrintFormat("Não há negociações históricas para o símbolo %s.", symboll);
//  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void  MOVEAVERG()
{
   if(!TEMA)
      {
         return;
      }
// Verificar se há barras suficientes
   if(Bars(Symbol(), PERIOD_CURRENT) < SlowPeriod + 5)
      {
         return;
      }
// Verificar se os indicadores estão prontos
   if(!IndicatorIsReady(handleTEMAfast) || !IndicatorIsReady(handleTEMAslow))
      {
         return;
      }
// Buffers locais
// temaFastBuffer[3];
// temaSlowBuffer[3];
// Copiar 3 valores das TEMA
   if(CopyBuffer(handleTEMAfast, 0, 0, 3, temaFastBuffer) != 3 ||
         CopyBuffer(handleTEMAslow,  0, 0, 3, temaSlowBuffer) != 3)
      {
         //Print("❌ Erro ao copiar dados dos TEMA.");
         return;
      }
// [0] vela atual, [1] vela fechada, [2] vela anterior fechada
   double fastAtual     = temaFastBuffer[0];
   double fastAnterior  = temaFastBuffer[1];
   double fastPenultima = temaFastBuffer[2];
   double slowAtual     = temaSlowBuffer[0];
   double slowAnterior  = temaSlowBuffer[1];
   double slowPenultima = temaSlowBuffer[2];
// Confirmar cruzamento com base nas últimas 2 velas fechadas
   bool cruzamentoAltaConfirmado  = (fastPenultima < slowPenultima) && (fastAnterior > slowAnterior);
   bool cruzamentoBaixaConfirmado = (fastPenultima > slowPenultima) && (fastAnterior < slowAnterior);
   if(cruzamentoAltaConfirmado)
      {
         // controlbuy = true;
         //   controlsell = false;
         // //Print("🔼 Cruzamento confirmado para CIMA  ");
         if(ExistePosicaoAberta(symboll))
            {
               // Fecha a posição do símbolo especificado
               if(ExistePosicaoAberta(symboll) && PositionGetString(POSITION_SYMBOL) == symboll)
                  {
                     ulong   ticket  = PositionGetInteger(POSITION_TICKET);
                     trade.PositionClose(ticket);
                  }
            }
      }
   else if(cruzamentoBaixaConfirmado)
      {
         //  controlbuy = false;
         /// controlsell = true;
         //  //Print("🔽 Cruzamento confirmado para BAIXO em ");
         // Fecha a posição do símbolo especificado
         if(ExistePosicaoAberta(symboll) && PositionGetString(POSITION_SYMBOL) == symboll)
            {
               ulong   ticket  = PositionGetInteger(POSITION_TICKET);
               trade.PositionClose(ticket);
            }
      }
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void calculaTAMANHOdavela()
{
   if(PrecoDeCompra == 0)
      {
         return;
      }
   MqlRates rates[1];    // Obter a última vela
   int copied = CopyRates(symboll, PeriodoOperacional, 0, 1, rates);// Copiar os dados da última vela para a matriz 'rates'
   if(copied > 0)
      {
         // Última vela
         double lastOpen = rates[0].open;
         double lastClose = rates[0].close;
         // Calcular o tamanho da vel
         if(lastOpen < lastClose)
            {
               tamanho_DA_vela_para_compra = MathAbs(PrecoDeCompra - lastClose) / Point();        //  função que calcula o tamanho de vela de compra
               bingala_de_alta = (int) MathAbs(tamanho_DA_vela_para_compra);                // bengala de alta         Print("tamanho_DA_vela_para_compra: ", bingala_de_alta);
            }
         if(lastOpen > lastClose)
            {
               tamanho_DA_vela_para_venda = MathAbs(PrecoDeVenda - lastClose) / Point();
               //  função que calcula o tamanho de vela de venda         Print("tamanho_DA_vela_para_venda: ", (bingala_de_baixa));
               bingala_de_baixa = (int) MathAbs(tamanho_DA_vela_para_venda); // bengala de alta
            }
      }
   else
      {
         Print("Erro ao copiar os dados da vela: ", GetLastError());
      }
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void AtualizarPrecosBase()
{
////Print("espassaoxx .", espassao);
   current_time = TimeLocal();                                    // tempo local
   symboll = Symbol(); // simbolo
   currentTime = TimeCurrent();// tempo LOCAL
   current = TimeLocal();  // tempo LOCAL
   totalPositions = PositionsTotal() ;
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------
int pntosDEvelaC ;
int pntosDEvelaV;
int pontsDEentrada;
void atualizarompimento()
{
   if(PrecoDeCompra == 0)
      {
         return;
      }
   if(g_param_ea_auto == true)
      {
         //precodiferentec = MathAbs(PrecoDeCompra - closeprice) Point(); //  pontos de vela para entrada de compra
         dedoc = PrecoDeCompra + ((PrecoDeCompra -  PrecoDeVenda) / 8); // PTS: PARA ENTRADA
         dedov = PrecoDeVenda - ((PrecoDeCompra -  PrecoDeVenda) / 8);
         condicao2 = (closeprice > dedoc)  ?  false : (g_param_rompimento_c) ; // condiçao para rompimento da vela de compra
         condicao = (closeprice < dedov) ? false : (g_param_rompimento_v);
         precodiferentev = MathAbs(closeprice - PrecoDeVenda) / Point();  //  pontos de vela para entrada  de venda
         precodiferentec = MathAbs(PrecoDeCompra - closeprice) / Point(); //  pontos de vela para entrada de compra
         pntosDEvelaC = (int) precodiferentec;
         pntosDEvelaV = (int)precodiferentev ;
         pontsDEentrada = (int)(PrecoDeCompra - PrecoDeVenda) / 8 ;
      }
   else
      {
         precodiferentev = MathAbs(closeprice - PrecoDeVenda) / Point();  //  pontos de vela para entrada  de venda
         precodiferentec = MathAbs(PrecoDeCompra - closeprice) / Point(); //  pontos de vela para entrada de compra
         pntosDEvelaC = (int) precodiferentec;
         pntosDEvelaV = (int)precodiferentev ;
         pontsDEentrada = (int) g_param_dedo ;
         condicao2 = (g_param_rompimento_c) ? (precodiferentec < g_param_dedo) : true ; // condiçao para rompimento da vela de compra
         condicao = (g_param_rompimento_v) ? (precodiferentev < g_param_dedo) : true ;
      }
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void linhass()
{
   if(!caneta)
      {
         return;
      }
   if(g_param_auto_surfada)
      {
         return;
      }
   if(closeprice > pc)
      {
         criar_linha_subsicol(linhasubsiculc);
         criar_linha_de_compra(linhabuy) ;
      }
//+------------------------------------------------------------------+
//| CRIAÇÃO DE LINHAS                                                |
//+------------------------------------------------------------------+
   if(closeprice > linhabuy)
      {
         pc = pc + Pontos ;
         pv = pv + Pontos ;
         Pontos = pc - pv;
         divisao = Pontos / 2;
         linhabuy = pc + Pontos;
         linhasubsiculc = pc + divisao;
         linhasell = pv - Pontos;
         linhasubsiculv = pv - divisao;
      }
//+------------------------------------------------------------------+
//| CRIAÇÃO DE LINHAS |                                              |
//+------------------------------------------------------------------+
   if(closeprice < pv)
      {
         criar_linha_subsicol(linhasubsiculv);
         criar_linha_venda(linhasell);
      }
//+------------------------------------------------------------------+
//| CRIAÇÃO DE LINHAS |                                              |
//+------------------------------------------------------------------+
   if(closeprice < linhasubsiculv)
      {
         pc = pc - Pontos ;
         pv = pv - Pontos ;
         Pontos = pc - pv;
         divisao = Pontos / 2;
         linhasell = pv - Pontos;
         linhasubsiculv = pv - divisao;
         linhabuy = pc + Pontos;
         linhasubsiculc = pc + divisao;
      }
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string ValidarParametros()
{
   if(g_param_estrategia == F_SURFADA)
      {
         return ("Estrategia F_SURFADA em atualização");
      }
// 1. g_param_senha
   if(StringLen(g_param_senha) == 0)
      {
         return ("coloque a senha e volte à tentar novamente");
      }
// 2. LINHAS DE EQUADOR
   if(g_param_linhas_eq)
      {
         if(g_param_equador_baixa >= g_param_equador_alta)
            {
               return ("verifique os preços de linhas de equador e volte à tentar novamente");
            }
         if(g_param_equador_alta <= 0 || g_param_equador_baixa <= 0)
            {
               return ("coloque os preços de linha de equador e volte à tentar novamente");
            }
      }
// 3. LOTE
   if(g_param_lote <= 0)
      {
         return ("coloque o lote e volte à tentar novamente");
      }
// 4. NÍVEIS
   if(g_param_niveis <= 0)
      {
         return ("verifique se o nives >= 1 e volte à tentar novamente");
      }
// 5. TAKE COMPRA
   if(g_param_posicao_take && g_param_buy_take > 0 && g_param_buy_take < g_param_compra)
      {
         return ("take de compra deve ser maior que preço de compra");
      }
// 6. TAKE VENDA
   if(g_param_posicao_take && g_param_sell_take > 0 && g_param_sell_take > g_param_venda)
      {
         return ("take de venda deve ser menor que preço de venda");
      }
// 7. RISCO DIÁRIO
   if(g_param_gerenc_diario)
      {
         if(g_param_porcentos <= 0)
            {
               return ("limite de perda diário inválido");
            }
         if(g_param_porcentosg <= 0)
            {
               return ("limite de ganho diário inválido");
            }
      }
// 8. RISCO SEMANAL
   if(g_param_gerenc_semanal)
      {
         if(g_param_porcentoo <= 0)
            {
               return ("limite de perda semanal inválido");
            }
         if(g_param_porcentoss <= 0)
            {
               return ("limite de ganho semanal inválido");
            }
      }
// 9. AUTO MODE
   if(g_param_ea_auto)
      {
         if(g_param_expansao_min > g_param_expansao_max ||
               g_param_expansao_min * 2 >= g_param_expansao_max)
            {
               return ("expansão inválida (min deve ser < max e max >= 2x min)");
            }
         if(g_param_auto_periodo == HORA_1 && g_param_auto_surfada)
            {
               return ("auto surfada não compatível com H1");
            }
         if(g_param_auto_periodo == MANUAL && g_param_auto_surfada && (g_param_compra <= 0 || g_param_venda <= 0))
            {
               return ("defina compra e venda manualmente");
            }
         if(g_param_auto_periodo == SESSOES && g_param_auto_surfada &&
               !g_param_sessao_asia && !g_param_sessao_londres && !g_param_sessao_ny)
            {
               return ("habilite pelo menos uma sessão");
            }
      }
   else
      {
         if(g_param_compra <= 0)
            {
               return ("coloque o preço de compra");
            }
         if(g_param_venda <= 0)
            {
               return ("coloque o preço de venda");
            }
         if(g_param_compra <= g_param_venda)
            {
               return ("compra deve ser maior que venda");
            }
         if(g_param_santo <= 0)
            {
               return ("configure pontos de saída");
            }
         if(g_param_dedo <= 0)
            {
               return ("configure pontos de entrada");
            }
      }
   return"" ;
}
long account_number;
//+------------------------------------------------------------------+
//|  inicializaçao do robô =
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//| Inicializa o Timer de monitoramento (Chamar no OnInit do EA)      |
//+------------------------------------------------------------------+
void InicializarTimerNotificacao(int segundos)
{
   EventSetTimer(segundos);
   Print("⏰ Timer de Notificações Inicializado com intervalo de ", segundos, " segundo(s).");
// Envia o primeiro sinal online imediatamente
   NotificarEAOnline();
   CriarPainelVisualStatus();
   SincronizarParametrosDoApp();
}
//+------------------------------------------------------------------+
//| Desativa o Timer de monitoramento (Chamar no OnDeinit do EA)    |
//+------------------------------------------------------------------+
void FinalizarTimerNotificacao()
{
   EventKillTimer();
   Print("⏰ Timer de Notificações Encerrado.");
   DestruirPainelVisualStatus();
}
//+------------------------------------------------------------------+
//| Evento Timer do EA - Processa Heartbeat e Alteraçoes de Posições |
//+------------------------------------------------------------------+
void OnTimer()
{
   if(veja == "Tester")
      return;
// 1. Notifica periodicamente que o EA está online (Heartbeat a cada 60 segundos)
   static datetime last_heartbeat = 0;
   datetime agora = TimeCurrent();
   if(agora - last_heartbeat >= 50)
      {
         NotificarEAOnline();
         last_heartbeat = agora;
      }
// 1. Sincroniza parâmetros enviados pelo App a cada 5 segundos
   if(agora - g_last_config_check >= 5)
      {
         VerificarComandoCapturaTela();
         VerificarEEnviarHistoricoFinanceiro();
         SincronizarParametrosDoApp();
         g_last_config_check = agora;
         CriarPainelVisualStatus();
      }
// 3. Monitora alterações de posições abertas no terminal
   static bool estavaComPosicaoAberta = false;
   bool temPosicao = ExistePosicaoAberta(symboll);
   if(temPosicao != estavaComPosicaoAberta)
      {
         string statusMsg = temPosicao ? "Nova posição aberta no ativo!" : "Posições encerradas.";
         Print("🔄 Mudança de Posição (Conta MT5: ", ObterContaMt5Login(), ", Ativo: ", symboll, "): ", statusMsg);
         // Envia notificação de alteração de posição
         string payload = StringFormat(
                             "{\"event\":\"posicao_alterada\",\"login\":%s,\"symbol\":\"%s\",\"tem_posicao\":%s,\"msg\":\"%s\",\"timestamp\":%d}",
                             ObterContaMt5Login(),
                             symboll,
                             temPosicao ? "true" : "false",
                             statusMsg,
                             (int)agora
                          );
         EnviarPutHTTP(ObterEventosEndpointFirebase("posicao_alterada"), payload);
         estavaComPosicaoAberta = temPosicao;
         // CAPTURA AUTOMÁTICA DO GRÁFICO AO ABRIR OU FECHAR ORDEM
         CapturarGraficoComObjetos();
      }
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int OnInit()
{
   if(StringLen(ValidarParametros()) != 0)
      {
         MessageBox(ValidarParametros(), "parâmetros invalidado", MB_ICONERROR);
         return(INIT_PARAMETERS_INCORRECT);
      }
   veja = TerminalInfoString(TERMINAL_NAME);
//--- Conta demo, de torneio ou real
   ENUM_ACCOUNT_TRADE_MODE account_type = (ENUM_ACCOUNT_TRADE_MODE)AccountInfoInteger(ACCOUNT_TRADE_MODE);
//--- Agora transforma o valor da enumeração em uma forma inteligível
   string trade_mode;
   switch(account_type)
      {
      case  ACCOUNT_TRADE_MODE_DEMO:
         trade_mode = "demo";
         break;
      case  ACCOUNT_TRADE_MODE_CONTEST:
         trade_mode = "concurso";
         break;
      default:
         trade_mode = "real";
         break;
      }
   LoadBlockData();
   account_number = AccountInfoInteger(ACCOUNT_LOGIN);
   AccountNumber = IntegerToString(account_number);
   if(veja != "Tester")
      {
         Print("▶️ [FIMASTER] Iniciando sistema de autenticação segura...");
         // ID da Conta MT5 (Deixe vazio para usar o número atual da conta)
         string mt5Id = AccountNumber;
         if(StringLen(InpEaPassword) == 0)
            {
               Print("❌ [FALHA] Por favor, insira a senha de ativação do EA nos parâmetros!");
               return(INIT_FAILED);
            }
         // Executa o fluxo de autenticação sequencial
         bool autenticado = ExecutarAutenticacaoMql5(mt5Id, InpEaPassword);
         if(autenticado)
            {
               Print("🎉 [SUCESSO] Robô autenticado e licenciado com sucesso para a conta MT5: ", mt5Id);
               // O seu código do Robô (inicialização de indicadores, painéis, etc.) inicia aqui!
            }
         else
            {
               Print("❌ [BLOQUEADO] Licença Inválida ou Falha na Autenticação para a conta MT5: ", mt5Id);
               Alert("FiMaster EA: Autenticação Falhou! Verifique os logs e as suas credenciais.");
               return(INIT_FAILED);
            }
         //ENUM_LICENSE_STATUS st = CheckLicense(SENHA);
         //if(st != LICENSE_OK)
         //  {
         //   Print("❌ LICENÇA NEGADA. STATUS: ", st);
         //   Alert("Licença inválida ou expirada");
         //   return(INIT_FAILED); }
      }
//--- enviamos a notificação
   InicializarTimerNotificacao(1);
//+------------------------------------------------------------------+
//|
   SetIndexBuffer(0, temaFastBuffer, INDICATOR_DATA);
   SetIndexBuffer(1, temaSlowBuffer, INDICATOR_DATA);
   PlotIndexSetInteger(0, PLOT_DRAW_TYPE, DRAW_LINE);
   PlotIndexSetInteger(1, PLOT_DRAW_TYPE, DRAW_LINE);
   PlotIndexSetInteger(0, PLOT_LINE_COLOR, CorTEMA9);
   PlotIndexSetInteger(1, PLOT_LINE_COLOR, CorTEMA21);
   IndicatorSetString(INDICATOR_SHORTNAME, "TEMA 9 x TEMA 21");
   if(TEMA)
      {
         // Criar os handles dos indicadores
         handleTEMAfast = iTEMA(Symbol(), PeriodoOperacional, FastPeriod, 0, PRICE_CLOSE);
         handleTEMAslow = iTEMA(Symbol(), PeriodoOperacional, SlowPeriod, 0, PRICE_CLOSE);
         if(handleTEMAfast == INVALID_HANDLE || handleTEMAslow == INVALID_HANDLE)
            {
               //Print("❌ Erro ao criar os indicadores TEMA.");
               return INIT_FAILED;
            }
      }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
   if(veja == "Tester")
      {
         ChartSetInteger(idd, CHART_COLOR_BACKGROUND, clrBlack); // COR DE FUNDO
         ChartSetInteger(idd, CHART_COLOR_GRID, clrNONE); // GRADE
         ChartSetInteger(idd, CHART_COLOR_CHART_UP, clrLime); // BARA DE ALTA
         ChartSetInteger(idd, CHART_COLOR_CHART_DOWN, clrRed); // BARA DE BAIXA
         ChartSetInteger(idd, CHART_COLOR_CANDLE_BULL, clrLime);
         ChartSetInteger(idd, CHART_COLOR_CANDLE_BEAR, clrRed);
         ChartSetInteger(idd, CHART_COLOR_BID, clrLightSlateGray);
         ChartSetInteger(idd, CHART_COLOR_FOREGROUND, 0, clrBlack);
         ChartSetInteger(idd, CHART_FOREGROUND, 0, true);
         ChartSetInteger(idd, CHART_SHIFT, 0, true);
         ChartSetInteger(idd, CHART_SHOW_OHLC, 0, true);
         ChartSetInteger(idd, CHART_SHOW_PRICE_SCALE, true);
      }
//  ChartScreenShot(0, "C:\\MT5_Upload\\grafico_upload.png", 1024, 768, ALIGN_RIGHT);   hashRecalculado = CalculateHashWithSalt(SENHA, pepper, salte, interar);
   ddd = (int)SymbolInfoInteger(symboll, SYMBOL_DIGITS);
   MathSrand(GetTickCount());
   pontt = SymbolInfoDouble(Symbol(), SYMBOL_POINT);
   decimal = (int) SymbolInfoInteger(Symbol(), SYMBOL_DIGITS);
   contrat = SYMBOL_TRADE_CONTRACT_SIZE;
   santinho = SymbolInfoDouble(_Symbol, SYMBOL_POINT);       // configuração para pontos de santo
   if(mostrarobjetos == true)
      {
         tmp_placar = true;
         tmp_placarx = true ;
         tmp_placarw = true ;
         tmp_placarfw = true ;
         tmp_placarfl = true ;
         placar = true;
         placarx = true ;
         placarw = true ;
         placarfw = true ;
         placarfl = true ;
      }
   else
      {
         inib = false;
         tmp_placar = false;
         tmp_placarx = false ;
         tmp_placarw = false ;
         tmp_placarfw = false ;
         tmp_placarfl = false ;
         placar = false;
         placarx = false ;
         placarw = false ;
         placarfw = false ;
         placarfl = false ;
      }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
   equador_semanal_baixa =  g_param_equador_baixa;
   equador_semanal_alta =  g_param_equador_alta;
   expansao = g_param_equador_alta - g_param_equador_baixa;;
   meio = expansao / 2 ;
   equador_diario_centro = equador_semanal_alta - meio ;
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
   criarlinhaequador_baixa(equador_semanal_baixa);
   criarlinhaequador_cento(equador_diario_centro);
   criarlinhaequador_alta(equador_semanal_alta);
   criarlinhaequador_cento(equador_diario_centro);
//+------------------------------------------------------------------+
//|   inicialização de preços
//+------------------------------------------------------------------+
   if(g_param_auto_surfada == true)
      {
         Costura = false;
      }
   if(g_param_ea_auto == true && (g_param_auto_periodo == MANUAL && g_param_auto_surfada == true))
      {
         var1 = g_param_compra;
         var2 = g_param_venda;
         PrecoDeCompra = var1;
         PrecoDeVenda = var2;
         pontosf = (var1 - var2) ;
         espas = MathAbs(PrecoDeCompra - PrecoDeVenda) / Point();
         espassao  = (int) espas;
         divisao = pontosf / 2;
         Buytake = PrecoDeCompra + (pontosf * g_param_niveis);
         Buystop = PrecoDeCompra - pontosf;
         Buysubsicul = PrecoDeCompra + divisao;
         Buymodif = PrecoDeCompra;
         Selltake = PrecoDeVenda - (pontosf * g_param_niveis);
         Sellestop = PrecoDeVenda + pontosf;
         Sellsubsicul = PrecoDeVenda - divisao;
         SellModif = PrecoDeVenda;
         sasa  = MathAbs(((PrecoDeCompra -  PrecoDeVenda) / 12) / Point()); // PTS: PARA santo
         fora = santinho * sasa;
         Costura = false;
         tempoInicioCiclo = iTime(symboll, PeriodoOperacional, 1);
         mcompra = PrecoDeCompra;
         mvenda = PrecoDeVenda;
         msbcompra = Buysubsicul;
         msubvenda = Sellsubsicul;
         mtakebuy = Buytake;
         mtakesel = Selltake;
         AVANCA = true;
         if(!JcicloAtivo)
            {
               CriarGrupo1(PrecoDeCompra, PrecoDeVenda, PrecoDeCompra - divisao);
            }
      }
   else if(! g_param_ea_auto)
      {
         var1 = g_param_compra;
         var2 = g_param_venda;
         PrecoDeCompra = var1;
         PrecoDeVenda = var2;
         pontosf = (var1 - var2) ;
         espas = MathAbs(PrecoDeCompra - PrecoDeVenda) / Point();
         espassao  = (int) espas;
         divisao = pontosf / 2;
         Buytake = PrecoDeCompra + (pontosf * g_param_niveis);
         Buystop = PrecoDeCompra - pontosf;
         Buysubsicul = PrecoDeCompra + divisao;
         Buymodif = PrecoDeCompra;
         Selltake = PrecoDeVenda - (pontosf * g_param_niveis);
         Sellestop = PrecoDeVenda + pontosf;
         Sellsubsicul = PrecoDeVenda - divisao;
         SellModif = PrecoDeVenda;
         Costura = g_param_costurar;
      }
//+------------------------------------------------------------------+
//|
//+------------------------------------------------------------------+
// Obter a hora da vela atual
//+------------------------------------------------------------------+
//|  | inicialização de preços de linha de compra e subcículo de compra
//+------------------------------------------------------------------+
   MagicNumber = GerarMagicNumberPorSimbolo();
   pc = PrecoDeCompra ;
   pv = PrecoDeVenda ;
   Pontos = pc - pv;
   divisao = Pontos / 2;
   linhabuy = pc + Pontos;
   linhasubsiculc = pc + divisao;
   linhasell = pv - Pontos;
   linhasubsiculv = pv - divisao;
   double subb = pc - divisao;
   double ssanto = divisao  / 3 / Point();
   fora = santinho * g_param_santo;   //  fórmula de santo
   symboll = Symbol();                                        // Definir o símbolo e o período
   ConverterSessoes();
   AtualizarPrecosBase();
   if(g_param_gmail)
      {
         EnviarEmailInicializacao();
      }
//+------------------------------------------------------------------+
//| | chamada  para criação de linha de compra e venda
//+------------------------------------------------------------------+
   if(!g_param_auto_surfada)
      {
         criar_linha_venda1(pv);
         criar_linha_de_compra1(pc);
         criar_linha_subsicol1(subb);
      }
   string nom = AccountInfoString(ACCOUNT_NAME);
   /*
       string chart_name="test_Object";
       Print("Vamos tentar criar um objeto gráfico com o nome ",chart_name);
    //--- Se tal objeto não existir - criá-lo  if(ObjectFind(0,chart_name)<0)
      ObjectCreate(0,chart_name,OBJ_CHART,0,0,0,0,0);
    //--- Define o ativo
       ObjectSetString(0,chart_name,OBJPROP_SYMBOL,symboll);
    //--- Define a coordenada X do ponto de ancoragem
       ObjectSetInteger(0,chart_name,OBJPROP_XDISTANCE,100);
    //--- Define a coordenada Y do ponto de ancoragem
       ObjectSetInteger(0,chart_name,OBJPROP_YDISTANCE,100);
    //--- Define a largura do gráfico
       ObjectSetInteger(0,chart_name,OBJPROP_XSIZE,400);
    //--- Define a altura
       ObjectSetInteger(0,chart_name,OBJPROP_YSIZE,300);
    //--- Define a janela de tempo
       ObjectSetInteger(0,chart_name,OBJPROP_PERIOD,PeriodoOperacional);
    //--- Define escala (de 0 a 5)
       ObjectSetDouble(0,chart_name,OBJPROP_SCALE,4);
    //--- Desativa a seleção por mouse
       ObjectSetInteger(0,chart_name,OBJPROP_SELECTABLE,true);

    //+---------------------------------------------------------------------------+
    //| Função define se arrastar os níveis de negociação no gráfico com o mouse  |
    //| é permitido.                                                              |
    //+---------------------------------------------------------------------------+
       ChartSetInteger(0,CHART_DRAG_TRADE_LEVELS,0,false);

       //+------------------------------------------------------------------+
    //| Ativa/desativa a exibição do painel "Negociar à um clique"       |
    //| no gráfico                                                       |
    //+------------------------------------------------------------------+

       */ ChartSetInteger(idd, CHART_SHOW_ONE_CLICK, 0, false);
   ChartSetInteger(0, CHART_DRAG_TRADE_LEVELS, 0, false);
   CheckNewHourAndDrawLines();
   string payloadEvent = StringFormat(
                            "{\"event\":\"ordem_executada\",\"tipo\":\"COMPRA\",\"symbol\":\"%s\",\"ticket\":%d,\"price\":%.5f,\"volume\":%.2f,\"sl\":%.5f,\"tp\":%.5f,\"alvo_mt\":%.2f,\"protecao_mt\":%.2f,\"lucro_pct\":%.2f,\"perda_pct\":%.2f,\"login\":%s,\"timestamp\":%d,\"msg\":\"📈 Ordem de Compra executada! Bilhete #%d\"}",
                            Symbol(), (long)BilheteDeCompra, preco_de_abertura_de_compra, g_param_lote, nivelstoplos_buy, takbuy, cb, cv, lucro, perdas, ObterContaMt5Login(), (int)TimeCurrent(), (long)BilheteDeCompra
                         );
   EnviarPutHTTP(ObterEventosEndpointFirebase("ordem_executada"), payloadEvent);
   return(INIT_SUCCEEDED);
}
//++++++++++++-------------------------------------------------------+
//| Expert deinitialization function |
//+------------------------------------------------------------------+
void deletgarobjetos()
{
   if(veja != "Tester")
      {
         // eliminação de linhas ao encerrar o   robô
         ObjectsDeleteAll(0, "LINHA_DE_COMPRA_", 0, OBJ_HLINE);
         ObjectsDeleteAll(0, "LINHA_DE_COMPRA_", 0, OBJ_TREND);
         ObjectsDeleteAll(0, "LINHA_DE_COMPRA_", 0, OBJ_ARROW_LEFT_PRICE);
         ObjectsDeleteAll(0, "SUBSICOL_", 0, OBJ_HLINE);
         ObjectsDeleteAll(0, "SUBSICOL_", 0, OBJ_TREND);
         ObjectsDeleteAll(0, "SUBSICOL_", 0, OBJ_ARROW_LEFT_PRICE);
         ObjectsDeleteAll(0, "LINHA_DE_VENDA_", 0, OBJ_HLINE);
         ObjectsDeleteAll(0, "LINHA_DE_VENDA_", 0, OBJ_TREND);
         ObjectsDeleteAll(0, "LINHA_DE_VENDA_", 0, OBJ_ARROW_LEFT_PRICE);
         ObjectsDeleteAll(0, "LINHA_DE_EQUADOR_", 0, OBJ_HLINE);
         ObjectsDeleteAll(0, "LINHA_DE_EQUADOR_50%_", 0, OBJ_HLINE);
         ObjectDelete(0, "FloatingProfitText");
         ObjectDelete(0, "ToggleFloatingProfit");
         Comment("  ");
         ObjectsDeleteAll(0, "compra_", 0, OBJ_TREND);
         ObjectsDeleteAll(0, "venda_", 0, OBJ_TREND);
         ObjectsDeleteAll(0, "entresiclo", 0, OBJ_TREND);
      }
   ChartSetInteger(idd, CHART_SHOW_ONE_CLICK, 0, true);
   ChartSetInteger(0, CHART_DRAG_TRADE_LEVELS, 0, true);
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
{
   deletgarobjetos();
   FinalizarTimerNotificacao();
}
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
{
   if(MagicNumber == MagicNumber)
      {
         // CheckAlertAndLog( GetFloatingProfit());
         precocurrentecB = SymbolInfoDouble(_Symbol, SYMBOL_BID);         //   preço corrente de beat
         precocurrentevA = SymbolInfoDouble(_Symbol, SYMBOL_ASK);         //   preço corrente de ask
         // total de posiçoes
         if(g_param_posicao_take == true)
            {
               if(g_param_sell_take > 0)
                  {
                     if(precocurrentevA <= g_param_sell_take)
                        {
                           control_de_venda = true;
                        }
                  }
               if(g_param_buy_take > 0)
                  {
                     if(precocurrentecB >= g_param_buy_take)
                        {
                           control_de_compra = true;
                        }
                  }
            }
         if(ExistePosicaoAberta(symboll))
            {
               if(mostrarobjetos == true)
                  {
                     if(g_param_gerenc_diario == true)
                        {
                           placar = true;
                           placarx = true ;
                           placarw = true ;
                           placarfw = true ;
                           placarfl = true ;
                        }
                     else
                        {
                           placar = false;
                           placarx = false ;
                           placarw = false ;
                           placarfw = false ;
                           placarfl = false ;
                        }
                     if(g_param_gerenc_semanal == true)
                        {
                           tmp_placar = true;
                           tmp_placarx = true ;
                           tmp_placarw = true ;
                           tmp_placarfw = true ;
                           tmp_placarfl = true ;
                        }
                     else
                        {
                           inib = true;
                           tmp_placar = false;
                           tmp_placarx = false ;
                           tmp_placarw = false ;
                           tmp_placarfw = false ;
                           tmp_placarfl = false ;
                        }
                  }
            }
         //   //Print("Existe uma posição aberta para o símbolo: ", symboll);
         else
            {
               funcao_verifica_meta_ou_perda_atingida();
               UpdateWeeklyResult();//   //Print("Nenhuma posição aberta para o símbolo: ", symboll);
            }
         //+------------------------------------------------------------------+
         //|    atualização do preço de compra
         //+------------------------------------------------------------------+
         if(precocurrentecB >= takbuy)
            {
               if(!segundo_control_de_takbuy)
                  {
                     PrecoDeVenda = PrecoDeCompra - pontosf;
                     Buytake = PrecoDeCompra + (pontosf * g_param_niveis);
                     Buystop = PrecoDeCompra - pontosf;
                     Buysubsicul = PrecoDeCompra + divisao;
                     Buymodif = PrecoDeCompra;
                     Selltake = PrecoDeVenda - (pontosf * g_param_niveis);
                     Sellestop = PrecoDeVenda + pontosf;
                     Sellsubsicul = PrecoDeVenda - divisao;
                     SellModif = PrecoDeVenda;
                     segundo_control_de_takbuy = true;
                  }
            }
         //+------------------------------------------------------------------+
         //|  atualização de preço de venda
         //+------------------------------------------------------------------+
         if(precocurrentevA <= taksell)
            {
               if(!segundo_control_de_taksell)
                  {
                     PrecoDeCompra = PrecoDeVenda + pontosf;
                     Buytake = PrecoDeCompra + (pontosf * g_param_niveis);
                     Buystop = PrecoDeCompra - pontosf;
                     Buysubsicul = PrecoDeCompra + divisao;
                     Buymodif = PrecoDeCompra;
                     Selltake = PrecoDeVenda - (pontosf * g_param_niveis);
                     Sellestop = PrecoDeVenda + pontosf;
                     Sellsubsicul = PrecoDeVenda - divisao;
                     SellModif = PrecoDeVenda;
                     segundo_control_de_taksell = true;
                  }
            }
         // }
         //+------------------------------------------------------------------+
         //|     atualização de de controle de venda   e de compra
         //+------------------------------------------------------------------+
         if(closeprice < PrecoDeVenda)
            {
               if(precocurrentecB || precocurrentevA <= nivelstoplos_buy)
                  {
                     if(totalPositions == 0)
                        {
                           if(atualizarcompr == true)
                              {
                                 controlsell = false;
                                 Print("venda aberta");
                                 atualizarcompr = false;
                                 atualizarvenda = true;
                              }
                        }
                  }
            }
         if(closeprice > PrecoDeCompra)
            {
               if(precocurrentecB || precocurrentevA >= nivelstoplos_sell)
                  {
                     if(totalPositions == 0)
                        {
                           if(atualizarvenda == true)
                              {
                                 controlbuy = false;
                                 Print("compra aberta");
                                 atualizarcompr = true;
                                 atualizarvenda = false;
                              }
                        }
                  }
            }
         //+------------------------------------------------------------------+
         closeprice = iClose(symboll, PeriodoOperacional, 1);            // fechamento de vela
         if(!Costura)
            if(ExistePosicaoAberta(symboll) ||  control_de_venda == true ||  control_de_compra == true)
               {
                  control_de_venda = true;
                  control_de_compra = true;
               }
         if(PodeExecutarNovoCandle())
            {
               AtualizarLinhas();
            }
         //+------------------------------------------------------------------+
         Automatico();
         DisplayFloatingProfit();
         CreateToggleButton();
         //+------------------------------------------------------------------+
         CheckNewHourAndDrawLines();
         ProcessarEquador();
         linhass();
         AtualizarPrecosBase();
         AUTO_SURFE();
         calculaTAMANHOdavela();
         atualizarompimento();
         MaquinaDeEstado();
         MOVEAVERG();
      }
}
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
