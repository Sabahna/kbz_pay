import 'package:flutter_kbz_pay_example/demo/SHA.dart';
import 'package:flutter_kbz_pay_example/demo/random_gen.dart';
import 'package:flutter_kbz_pay_example/demo/secure_info.dart';
import 'package:kbz_pay/kbz_pay.dart';

class StartPay {
  final SecureInfo info;

  StartPay({required this.info});

  final _flutterKbzPayPlugin = KbzAppPayment();

  void pay({required String prePayId, required String merchantKey}) {
    final order = _buildOrderInfo(prePayId, merchantKey);

    /// In iOS, you require appScheme because KBZPay callback openUrl of your app for payment status
    _flutterKbzPayPlugin.startPay(
      orderInfo: order.$1,
      sign: order.$2,
      appScheme: "com.flutter.kbzpay.jackwill",
    );
  }

  Stream<dynamic> onPayStatus() {
    return _flutterKbzPayPlugin.onPayStatus();
  }

  /// Actually, you don't need this method. Required info are given by server-side. This is just for demo.
  (String, String) _buildOrderInfo(String prePayId, String merchantKey) {
    final orderInfo =
        "appid=${info.appId}&merch_code=${info.merchCode}&nonce_str=${RandomGen.I.nonceStr(20)}&prepay_id=$prePayId&timestamp=${RandomGen.I.timeStamp()}";

    final sign = SHA.I.getSHA256Str("$orderInfo&key=$merchantKey");
    return (orderInfo, sign);
  }
}
