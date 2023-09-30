import "package:flutter_kbz_pay/models/flutter_kbz_pay_abstract.dart";
import "package:flutter_kbz_pay/models/flutter_kbz_pay_platform_interface.dart";

class FlutterKbzPay extends FlutterKbzPayAbstract {
  @override
  Future<String> startPayDemo({
    required String merchCode,
    required String appId,
    required String signKey,
    required String orderId,
    required double amount,
    required String title,
    required String notifyURL,
    required bool isProduction,
    String? urlScheme,
  }) {
    return FlutterKbzPayPlatform.instance.startPayDemo(
      merchCode: merchCode,
      appId: appId,
      signKey: signKey,
      orderId: orderId,
      amount: amount,
      title: title,
      notifyURL: notifyURL,
      isProduction: isProduction,
    );
  }
}
