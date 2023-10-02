import 'package:dio/dio.dart';

class Payment {
  final dio = Dio();

  String uatApi = "http://api.kbzpay.com/payment/gateway/uat/precreate";

  dynamic preCreate() {
    return {
      "Request": {
        "method": "kbz.payment.precreate",
        "timestamp": "1696089607",
        "notify_url": "https://wowme.tech",
        "nonce_str": "5K8264ILTKCH16CQ2502SI8ZNMTM67VS",
        "sign_type": "SHA256",
        "sign":
            "DD5D74E941D4E87ED04600D61CC8FAF8CBA53B1D12C0EA2B7867591F1166B056",
        "version": "1.0",
        "biz_content": {
          "merch_order_id": "201907152017001",
          "merch_code": "200290",
          "appid": "kp7536cbbc95ce4fe8bcc2505a6ff15c",
          "trade_type": "APP",
          "total_amount": "100",
          "trans_currency": "MMK",
          "timeout_express": "100m"
        }
      }
    };
  }

  void sendPreCreate() async {
    final request = await dio.request(
      uatApi,
      data: preCreate(),
      options: Options(method: "POST"),
    );

    print(request.data);
  }

  String orderInfo() {
    return "prepay_id=KBZ0061079afb5f05506105bd229747b28e5f223050699&merch_code=200290&appid=kp7536cbbc95ce4fe8bcc2505a6ff15c&timestamp=1696089607&nonce_str=5K8264ILTKCH16CQ2502SI8ZNMTM67VS";
  }

  final scheme = "tech.wowme.app.ios.user";
}
