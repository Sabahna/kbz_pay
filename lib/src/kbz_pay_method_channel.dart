import "package:flutter/services.dart";
import "package:kbz_pay/models/kbz_pay_platform_interface.dart";

/// An implementation of [FlutterKbzPayPlatform] that uses method channels.
class MethodChannelFlutterKbzPay extends FlutterKbzPayPlatform {
  /// The method channel used to interact with the native platform.
  final _methodChannel = const MethodChannel("com.flutter.kbz.pay");

  @override
  Future<String> sayHello(String name) async {
    return await _methodChannel.invokeMethod("sayHello", {"name": name});
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
  }) async {
    // await _methodChannel.invokeMethod('createPay', {
    //   'merch_code': merchCode,
    //   'appid': appId,
    //   'sign_key': signKey,
    //   'url_scheme': urlScheme,
    //   'order_id': orderId,
    //   'amount': amount,
    //   'title': title,
    //   'is_production': isProduction,
    //   "notify_url": notifyURL,
    //   'callback_info': Platform.isAndroid ? "android" : "iphone"
    // });
    return "hay";
  }

  @override
  Future<void> startPayIos() async {
    await _methodChannel.invokeMethod("testPay");
  }
}
