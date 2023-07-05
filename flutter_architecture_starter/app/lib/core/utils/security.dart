import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:tuple/tuple.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

/// aes加解密
class IotKeyLock {
  /// BASE64编码
  static String encodeBase64(String data){
    var content = utf8.encode(data);
    // print(content);
    var digest = base64Encode(content);
    return digest;
  }
  /// SHA256
  String duSHA256(String input) {
    String salt = 'EIpWsyfiy@R@X#qn17!StJNdZK1fFF8iV6ffN!goZkqt#JxO'; // 加盐
    var bytes = utf8.encode(input + salt);
    var digest = sha256.convert(bytes);

    return digest.toString();
  }

  // static const MethodChannel _channel = const MethodChannel('luci_thermal_personal_app');
  // ///解密
  // static Future<Uint8List> decrypt(
  //     Uint8List data, Uint8List key, Uint8List iv) async {
  //   final Uint8List result = await _channel
  //       .invokeMethod('decrypt', {"data": data, "key": key, "iv": iv});
  //   return result;
  // }
  // ///加密
  // static Future<Uint8List> encrypt(
  //     Uint8List data, Uint8List key, Uint8List iv) async {
  //   final Uint8List result = await _channel
  //       .invokeMethod('encrypt', {"data": data, "key": key, "iv": iv});
  //   return result;
  // }
}


String encryptAESCryptoJS(String plainText, String passphrase) {
  try {
    final salt = genRandomWithNonZero(8);
    var keyndIV = deriveKeyAndIV(passphrase, salt);
    final key = encrypt.Key(keyndIV.item1);
    final iv = encrypt.IV(keyndIV.item2);

    final encrypter = encrypt.Encrypter(
        encrypt.AES(key, mode: encrypt.AESMode.cbc, padding: "PKCS7"));
    final encrypted = encrypter.encrypt(plainText, iv: iv);
    Uint8List encryptedBytesWithSalt = Uint8List.fromList(
        createUint8ListFromString("Salted__") + salt + encrypted.bytes);
    return base64.encode(encryptedBytesWithSalt);
  } catch (error) {
    throw error;
  }
}

String decryptAESCryptoJS(String encrypted, String passphrase) {
  try {
    Uint8List encryptedBytesWithSalt = base64.decode(encrypted);

    Uint8List encryptedBytes =
        encryptedBytesWithSalt.sublist(16, encryptedBytesWithSalt.length);
    final salt = encryptedBytesWithSalt.sublist(8, 16);
    var keyndIV = deriveKeyAndIV(passphrase, salt);
    final key = encrypt.Key(keyndIV.item1);
    final iv = encrypt.IV(keyndIV.item2);

    final encrypter = encrypt.Encrypter(
        encrypt.AES(key, mode: encrypt.AESMode.cbc, padding: "PKCS7"));
    final decrypted =
        encrypter.decrypt64(base64.encode(encryptedBytes), iv: iv);
    return decrypted;
  } catch (error) {
    throw error;
  }
}

Tuple2<Uint8List, Uint8List> deriveKeyAndIV(String passphrase, Uint8List salt) {
  var password = createUint8ListFromString(passphrase);
  Uint8List concatenatedHashes = Uint8List(0);
  Uint8List currentHash = Uint8List(0);
  bool enoughBytesForKey = false;
  Uint8List preHash = Uint8List(0);

  while (!enoughBytesForKey) {
    int preHashLength = currentHash.length + password.length + salt.length;
    if (currentHash.length > 0)
      preHash = Uint8List.fromList(
          currentHash + password + salt);
    else
      preHash = Uint8List.fromList(
          password + salt);

    currentHash = md5.convert(preHash).bytes;
    concatenatedHashes = Uint8List.fromList(concatenatedHashes + currentHash);
    if (concatenatedHashes.length >= 48) enoughBytesForKey = true;
  }

  var keyBtyes = concatenatedHashes.sublist(0, 32);
  var ivBtyes = concatenatedHashes.sublist(32, 48);
  return new Tuple2(keyBtyes, ivBtyes);
}

Uint8List createUint8ListFromString(String s) {
  var ret = new Uint8List(s.length);
  for (var i = 0; i < s.length; i++) {
    ret[i] = s.codeUnitAt(i);
  }
  return ret;
}

Uint8List genRandomWithNonZero(int seedLength) {
  final random = Random.secure();
  const int randomMax = 245;
  final Uint8List uint8list = Uint8List(seedLength);
  for (int i=0; i < seedLength; i++) {
    uint8list[i] = random.nextInt(randomMax)+1;
  }
  return uint8list;
}