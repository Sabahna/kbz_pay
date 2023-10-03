abstract class FlutterKbzPayAbstract {
  Future<String> startPay({
    required String orderInfo,
    required String sign,
    String? signType,
  });

  /// Payment Status
  ///
  /// COMPLETED = 1
  ///
  /// FAIL = 2
  ///
  /// CANCEL = 3
  Stream<dynamic> onPayStatus();
}
