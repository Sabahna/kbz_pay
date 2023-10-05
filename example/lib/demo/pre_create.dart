import 'dart:convert';

import 'package:flutter_kbz_pay_example/demo/SHA.dart';
import 'package:flutter_kbz_pay_example/demo/random_gen.dart';
import 'package:flutter_kbz_pay_example/demo/secure_info.dart';
import 'package:http/http.dart' as http;

/// Actually, pre-creating should be in server side. This is just for demo.
class PreCreate {
  PreCreate({
    required this.info,
  });

  final SecureInfo info;

  /// Override state
  late String nonceStr;
  late String timestamp;
  late String price;
  late String merchOrderId;

  /// const state
  final String uatApi = "http://api.kbzpay.com/payment/gateway/uat/precreate";
  final String notifyUrl = "https://example.tech";
  final String urlScheme = "com.flutter.kbzpay.jackwill";

  Future<dynamic> createPay({
    required String amount,
    required String merchOrderId,
  }) async {
    print("create pay api");
    final request = await http.post(Uri.parse(uatApi),
        body: jsonEncode(_createOrder(amount, merchOrderId)));

    print(request.body);
    return jsonDecode(request.body);
  }

  dynamic _createOrder(String amount, String merchOrder) {
    nonceStr = RandomGen.I.nonceStr(30);
    timestamp = RandomGen.I.timeStamp();
    price = amount;
    merchOrderId = merchOrder;
    return {
      "Request": {
        "method": "kbz.payment.precreate",
        "timestamp": timestamp,
        "notify_url": notifyUrl,
        "nonce_str": nonceStr,
        "sign_type": "SHA256",
        "sign": _createOrderSign(),
        "version": "1.0",
        "biz_content": {
          "merch_order_id": merchOrderId,
          "merch_code": info.merchCode,
          "appid": info.appId,
          "trade_type": "APP",
          "total_amount": amount,
          "trans_currency": "MMK",
          "timeout_express": "100m"
        }
      }
    };
  }

  String _createOrderSign() {
    final a =
        "appid=${info.appId}&merch_code=${info.merchCode}&merch_order_id=$merchOrderId&method=kbz.payment.precreate&nonce_str=$nonceStr&notify_url=$notifyUrl&timeout_express=100m&timestamp=$timestamp&total_amount=$price&trade_type=APP&trans_currency=MMK&version=1.0";

    final s = "$a&key=${info.merchKey}";

    return SHA.I.getSHA256Str(s);
  }
}
