import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_kbz_pay_platform_interface.dart';

/// An implementation of [FlutterKbzPayPlatform] that uses method channels.
class MethodChannelFlutterKbzPay extends FlutterKbzPayPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_kbz_pay');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
