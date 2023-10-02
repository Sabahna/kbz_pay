/// KBZ pay api endpoint is separated by UAT and Production. So, this factory class will be separated between these different APIs.
class PaymentOrderEndpoint {
  factory PaymentOrderEndpoint({required bool isProduction}) {
    if (isProduction) {
      return PaymentOrderEndpoint._(
        isProduction: isProduction,
        queryOrder: "https://api.kbzpay.com/payment/gateway/queryorder",
        closeOrder: "https://api.kbzpay.com/payment/gateway/closeorder",
        refundOrder: "https://api.kbzpay.com:8008/payment/gateway/refund",
        createOrder: "https://api.kbzpay.com/payment/gateway/precreate",
      );
    } else {
      return PaymentOrderEndpoint._(
        isProduction: isProduction,
        queryOrder: "http://api.kbzpay.com/payment/gateway/uat/queryorder",
        closeOrder: "https://api.kbzpay.com/payment/gateway/uat/closeorder",
        refundOrder: "https://api.kbzpay.com:8008/payment/gateway/uat/refund",
        createOrder: "https://api.kbzpay.com/payment/gateway/uat/precreate",
      );
    }
  }

  PaymentOrderEndpoint._({
    required this.queryOrder,
    required this.closeOrder,
    required this.refundOrder,
    required this.createOrder,
    required this.isProduction,
  });

  final bool isProduction;
  final String createOrder;
  final String queryOrder;
  final String closeOrder;
  final String refundOrder;
}
