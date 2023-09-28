import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_kbz_pay/flutter_kbz_pay.dart';
import 'package:flutter_kbz_pay/flutter_kbz_pay_platform_interface.dart';
import 'package:flutter_kbz_pay/flutter_kbz_pay_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterKbzPayPlatform
    with MockPlatformInterfaceMixin
    implements FlutterKbzPayPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final FlutterKbzPayPlatform initialPlatform = FlutterKbzPayPlatform.instance;

  test('$MethodChannelFlutterKbzPay is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterKbzPay>());
  });

  test('getPlatformVersion', () async {
    FlutterKbzPay flutterKbzPayPlugin = FlutterKbzPay();
    MockFlutterKbzPayPlatform fakePlatform = MockFlutterKbzPayPlatform();
    FlutterKbzPayPlatform.instance = fakePlatform;

    expect(await flutterKbzPayPlugin.getPlatformVersion(), '42');
  });
}
