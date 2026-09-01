// event_client_registroEventfimaste.mqh
#property strict

// Gera event_id canônico: "<timestamp>-<md5(timestamp-login-event)>"
string GenerateEventId(string login, long timestamp, string evt) {
   string base = IntegerToString(timestamp) + "-" + login + "-" + evt;
   uchar src[]; StringToCharArray(base, src, 0, WHOLE_ARRAY);
   uchar digest[];
   if(CryptEncode(CRYPT_HASH_MD5, src, NULL, digest) <= 0) {
      return IntegerToString(timestamp) + "-" + "err";
   }
   string hex = "";
   for(int i=0;i<ArraySize(digest);i++) hex += StringFormat("%02x", digest[i]);
   return IntegerToString(timestamp) + "-" + hex;
}

// SHA256 wrapper (returns hex)
string Sha256Hex(string input) {
   uchar data[]; StringToCharArray(input, data, 0, WHOLE_ARRAY);
   uchar out[];
   if(CryptEncode(CRYPT_HASH_SHA256, data, NULL, out) <= 0) return "";
   string hex=""; for(int i=0;i<ArraySize(out);i++) hex+=StringFormat("%02x", out[i]);
   return hex;
}

// HMAC-SHA256 implementation (key, message -> hex)
string HmacSha256Hex(string key, string message) {
   // Block size for SHA256 = 64 bytes
   int BS = 64;
   // Convert to bytes
   uchar kbytes[]; StringToCharArray(key, kbytes, 0, WHOLE_ARRAY);
   uchar keyBlock[]; ArrayResize(keyBlock, BS);
   int klen = ArraySize(kbytes);
   if(klen > BS) {
      // key = SHA256(key)
      string kh = Sha256Hex(key);
      uchar kb2[]; StringToCharArray(kh, kb2, 0, WHOLE_ARRAY);
      for(int i=0;i<BS;i++) keyBlock[i] = (i < ArraySize(kb2) ? kb2[i] : 0);
   } else {
      for(int i=0;i<BS;i++) keyBlock[i] = (i < klen ? kbytes[i] : 0);
   }
   // ipad = key xor 0x36; opad = key xor 0x5c
   uchar ipad[]; uchar opad[]; ArrayResize(ipad, BS); ArrayResize(opad, BS);
   for(int i=0;i<BS;i++) { ipad[i] = keyBlock[i] ^ 0x36; opad[i] = keyBlock[i] ^ 0x5C; }
   // inner = SHA256(ipad || message)
   string msg = message;
   uchar mbytes[]; StringToCharArray(msg, mbytes, 0, WHOLE_ARRAY);
   uchar innerBuf[]; ArrayResize(innerBuf, BS + ArraySize(mbytes));
   for(int i=0;i<BS;i++) innerBuf[i] = ipad[i];
   for(int i=0;i<ArraySize(mbytes);i++) innerBuf[BS+i] = mbytes[i];
   uchar innerHash[]; CryptEncode(CRYPT_HASH_SHA256, innerBuf, NULL, innerHash);
   // outer = SHA256(opad || innerHash)
   uchar outerBuf[]; ArrayResize(outerBuf, BS + ArraySize(innerHash));
   for(int i=0;i<BS;i++) outerBuf[i] = opad[i];
   for(int i=0;i<ArraySize(innerHash);i++) outerBuf[BS+i] = innerHash[i];
   uchar outerHash[]; CryptEncode(CRYPT_HASH_SHA256, outerBuf, NULL, outerHash);
   string hex=""; for(int i=0;i<ArraySize(outerHash);i++) hex+=StringFormat("%02x", outerHash[i]);
   return hex;
}

// Monta JSON básico (use JAson.mqh or similar if preferred)
string BuildEventJson(string event, string login, long timestamp, string event_id, string msg, string symbol, double price) {
   string s = "{";
   s += "\"event\":\"" + event + "\",";
   s += "\"login\":\"" + login + "\",";
   s += "\"timestamp\":" + IntegerToString(timestamp) + ",";
   s += "\"event_id\":\"" + event_id + "\"";
   if(StringLen(msg)>0) s += ",\"msg\":\"" + msg + "\"";
   if(StringLen(symbol)>0) s += ",\"symbol\":\"" + symbol + "\"";
   if(price!=0.0) s += ",\"price\":" + DoubleToString(price, 8);
   s += "}";
   return s;
}

// Envia JSON ao gateway com header X-Signature: sha256=<hex>
int SendEventToGateway(string endpoint, string jsonPayload, string secret, int timeout_ms=5000) {
   string signature = HmacSha256Hex(secret, jsonPayload);
   string headers = "Content-Type: application/json\r\nX-Signature: sha256=" + signature + "\r\n";
   char post[]; StringToCharArray(jsonPayload, post);
   char result[]; string result_headers;
   int res = WebRequest("POST", endpoint, headers, timeout_ms, post, result, result_headers);
   if(res==-1) {
      Print("WebRequest failed, GetLastError=", GetLastError());
      return -1;
   }
   string resp = CharArrayToString(result);
   Print("Gateway response (", res, "): ", resp);
   return res;
}
