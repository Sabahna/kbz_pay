import "package:kbz_pay/models/kbz_pay_abstract.dart";
import "package:kbz_pay/models/kbz_pay_platform_interface.dart";

class KbzAppPayment extends FlutterKbzPayAbstract {
  @override
  Future<String> startPay({
    required String orderInfo,
    required String sign,
    String? signType,
  }) {
    return FlutterKbzPayPlatform.instance
        .startPay(orderInfo, sign, signType ?? "SHA256");
  }

  @override
  Stream<dynamic> onPayStatus() {
    return FlutterKbzPayPlatform.instance.onPayStatus();
  }
}
