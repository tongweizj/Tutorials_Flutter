import 'dart:convert';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:steel_crypt/steel_crypt.dart';

class Credential {
  static String toHexString(bytes) {
    String ret = '';
    for (int i = 0; i < bytes.length; i++) {
      ret += bytes[i].toRadixString(16).padLeft(2, '0');
    }
    return ret;
  }

  static String encrypt(username, key, text) {
    final keyGen = CryptKey();
    final nonce = keyGen.genDart(len: 16);
    final aes = AesCrypt(key: base64.encode(key), padding: PaddingAES.none);
    var crypted = aes.gcm.encrypt(inp: text, iv: nonce);
    Uint8List result = base64.decode(crypted);
    Uint8List encrypted = result.sublist(0, result.length - 16);
    Uint8List authTag = result.sublist(result.length - 16);

    final credential = {};
    credential['username'] = username;
    credential['password'] = toHexString(encrypted);
    credential['nonce'] = toHexString(base64.decode(nonce));
    credential['authTag'] = toHexString(authTag);
    AsciiCodec a = new AsciiCodec();
    return toHexString(a.encode(json.encode(credential)));
  }

  static String generate(username, password) {
    final key1 = md5.convert(utf8.encode('login:' + username.toUpperCase()));
    AsciiCodec a = new AsciiCodec();
    final key = a.encode(toHexString(key1.bytes));
    return Credential.encrypt(username, key, password);
  }
}
