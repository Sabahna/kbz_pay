import 'dart:convert';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';

class SHA {
  factory SHA() {
    return I;
  }

  SHA._();

  static final SHA I = SHA._();

  String getSHA256Str(String str) {
    var encodeStr = "";
    try {
      final bytes = utf8.encode(str);
      final digest = sha256.convert(bytes);
      encodeStr = _byte2Hex(Uint8List.fromList(digest.bytes));
    } catch (e) {
      print(e);
    }
    print("sha256 sign $encodeStr");
    return encodeStr;
  }

  String _byte2Hex(Uint8List bytes) {
    var stringBuffer = StringBuffer();
    String temp;
    for (var i = 0; i < bytes.length; i++) {
      temp = bytes[i].toRadixString(16);
      if (temp.length == 1) {
        stringBuffer.write("0");
      }
      stringBuffer.write(temp);
    }
    return stringBuffer.toString();
  }
}
