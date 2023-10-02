import "package:kbz_pay/src/kbz_pay_method_channel.dart";
import "package:plugin_platform_interface/plugin_platform_interface.dart";

abstract class FlutterKbzPayPlatform extends PlatformInterface {
  /// Constructs a FlutterKbzPayPlatform.
  FlutterKbzPayPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterKbzPayPlatform _instance = MethodChannelFlutterKbzPay();

  /// The default instance of [FlutterKbzPayPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterKbzPay].
  static FlutterKbzPayPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterKbzPayPlatform] when
  /// they register themselves.
  static set instance(FlutterKbzPayPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  /// ### For Testing
  ///
  Future<String> sayHello(String name);

  /// ### Recommend for demonstration
  /// This will pre-create the payment order and will request the authentication of the KBZ pay app
  Future<String> startPayDemo({
    required String merchCode,
    required String appId,
    required String signKey,
    required String orderId,
    required double amount,
    required String title,
    required String notifyURL,
    required bool isProduction,

    /// This url Scheme works only in iOS
    String? urlScheme,
  });

  /// Test start Pay
  ///
  Future<void> startPayIos();
}
