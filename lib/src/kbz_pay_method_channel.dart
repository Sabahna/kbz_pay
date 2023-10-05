import "package:flutter/services.dart";
import "package:kbz_pay/models/kbz_pay_platform_interface.dart";

/// An implementation of [FlutterKbzPayPlatform] that uses method channels.
class MethodChannelFlutterKbzPay extends FlutterKbzPayPlatform {
  /// The method channel used to interact with the native platform.
  final _methodChannel = const MethodChannel("com.flutter.kbz.pay");

  /// Event channel to listen stream data
  final EventChannel _eventChannel =
      const EventChannel("com.flutter.kbz.pay/pay_status");

  /// Stream Payment status
  static Stream<dynamic>? _streamPayStatus;

  @override
  Future<String> startPay(
    String orderInfo,
    String sign,
    String signType,
    String? appScheme,
  ) async {
    return await _methodChannel.invokeMethod("startPay", {
      "orderInfo": orderInfo,
      "sign": sign,
      "signType": signType,
      "appScheme": appScheme,
    });
  }

  @override
  Stream<dynamic> onPayStatus() {
    _streamPayStatus = _eventChannel.receiveBroadcastStream();
    return _streamPayStatus!;
  }
}
