import "dart:io";

import "package:kbz_pay/models/kbz_pay_abstract.dart";
import "package:kbz_pay/models/kbz_pay_platform_interface.dart";

class KbzAppPayment extends FlutterKbzPayAbstract {
  @override
  Future<String> startPay({
    required String orderInfo,
    required String sign,
    String? signType,
    String? appScheme,
  }) {
    assert(
      Platform.isIOS ? appScheme != null : true,
      "appScheme require in iOS",
    );
    return FlutterKbzPayPlatform.instance
        .startPay(orderInfo, sign, signType ?? "SHA256", appScheme);
  }

  @override
  Stream<dynamic> onPayStatus() {
    return FlutterKbzPayPlatform.instance.onPayStatus();
  }
}
