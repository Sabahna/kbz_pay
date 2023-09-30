import "package:flutter/foundation.dart";
import "package:flutter/services.dart";
import "package:flutter_kbz_pay/models/flutter_kbz_pay_platform_interface.dart";

/// An implementation of [FlutterKbzPayPlatform] that uses method channels.
class MethodChannelFlutterKbzPay extends FlutterKbzPayPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel("com.flutter.kbz.pay");

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
    return "hay";
  }
}
