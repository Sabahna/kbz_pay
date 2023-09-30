abstract class FlutterKbzPayAbstract {
  /// #### Recommend for demonstration
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
}
