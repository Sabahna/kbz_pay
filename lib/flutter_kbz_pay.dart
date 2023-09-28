
import 'flutter_kbz_pay_platform_interface.dart';

class FlutterKbzPay {
  Future<String?> getPlatformVersion() {
    return FlutterKbzPayPlatform.instance.getPlatformVersion();
  }
}
