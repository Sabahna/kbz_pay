abstract class FlutterKbzPayAbstract {
  /// Start pay
  ///
  /// [appScheme] only need for iOS
  Future<String> startPay({
    required String orderInfo,
    required String sign,
    String? signType,

    /// For only iOS
    String? appScheme,
  });

  /// Payment Status (Only Android, you can listen status in iOS from deep link)
  ///
  /// COMPLETED = 1
  ///
  /// FAIL = 2
  ///
  /// CANCEL = 3
  ///
  /// There is no status when pre-created id is already used
  Stream<dynamic> onPayStatus();
}
