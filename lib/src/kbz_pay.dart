import "package:kbz_pay/models/kbz_pay_abstract.dart";
import "package:kbz_pay/models/kbz_pay_platform_interface.dart";

class FlutterKbzPay extends FlutterKbzPayAbstract {
  @override
  Future<String> sayHello(String name) {
    return FlutterKbzPayPlatform.instance.sayHello(name);
  }

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

  @override
  Future<void> startPayIos() async {
    await FlutterKbzPayPlatform.instance.startPayIos();
  }
}
