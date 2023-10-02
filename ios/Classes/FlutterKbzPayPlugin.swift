import Flutter
import UIKit
import KBZPayAPPPay.PaymentViewController

public class FlutterKbzPayPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "com.flutter.kbz.pay", binaryMessenger: registrar.messenger())
    let instance = FlutterKbzPayPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "sayHello":

        result("Hello, welcome from Swift ")
    case "startPay":

        startPayWithOrderInfo(orderInfo: "prepay_id=KBZ0061079afb5f05506105bd229747b28e5f223050699&merch_code=200290&appid=kp7536cbbc95ce4fe8bcc2505a6ff15c&timestamp=1696089607&nonce_str=5K8264ILTKCH16CQ2502SI8ZNMTM67VS",signType: "SHA256",sign: "DD5D74E941D4E87ED04600D61CC8FAF8CBA53B1D12C0EA2B7867591F1166B056",appScheme: "tech.wowme.app.ios.user")
    case "testPay":
        let controller = PaymentViewController()

        // Original source code of Objective-C method is `startPayWithOrderInfo` and Swift naming convention override this method to `startPay`
        // https://stackoverflow.com/a/40164599/19999522
        controller.startPay(withOrderInfo:"prepay_id=KBZ0061079afb5f05506105bd229747b28e5f223050699&merch_code=200290&appid=kp7536cbbc95ce4fe8bcc2505a6ff15c&timestamp=1696089607&nonce_str=5K8264ILTKCH16CQ2502SI8ZNMTM67VS", signType: "SHA256",sign: "DD5D74E941D4E87ED04600D61CC8FAF8CBA53B1D12C0EA2B7867591F1166B056",appScheme: "tech.wowme.app.ios.user")

    default:
        result(FlutterMethodNotImplemented)
    }
  }

  func startPayWithOrderInfo(orderInfo:String, signType: String, sign:String, appScheme:String){
          let bundleId = Bundle.main.bundleIdentifier ?? ""
          print("bundleid:\(bundleId)")
          let userInfo = Bundle.main.infoDictionary
          print("userInfo:\(userInfo ?? [:])")
          let appVersion = Bundle.main.infoDictionary?["CFBundleVersion"] ?? ""
          print("appVersion:\(appVersion)")
          let appName = Bundle.main.infoDictionary?["CFBundleDisplayName"] ?? ""
          print("appName:\(appName)")
          let phoneVersion = "17.0"
          print("phoneVersion:\(phoneVersion)")
          let phoneModel = "iPhone 11"
          print("phoneModel:\(phoneModel)")

          let finalURL = "kbzpay://?\(orderInfo)&sign_type=\(signType)&sign=\(sign)&tradeType=\("APP")&bundleId=\(bundleId)&appVersion=\(appVersion)&appName=\(appName)&phoneVersion=\(appVersion)&phoneModel=\(phoneModel)&backUrlSchemes=\(appScheme)"
          print("finalURL :",finalURL)
          guard let url = URL(string: finalURL) else{
              return
          }
          if !UIApplication.shared.canOpenURL(url) {
              let alert = UIAlertController(title: "", message: "please install kbzpay app first",preferredStyle: .alert)
              let defaultAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { _ in
                  let str = "itms-apps://itunes.apple.com/cn/app/id1398852297?mt=8"
                  UIApplication.shared.open(URL(string: str)!){_ in }
              }
              alert.addAction(defaultAction)

              var topRootViewController = UIApplication.shared.windows.first?.rootViewController as? UIViewController
              while((topRootViewController?.presentedViewController) != nil){
                  topRootViewController = topRootViewController?.presentedViewController
              }
              topRootViewController?.present(alert, animated: true, completion: nil)
          }else{
              UIApplication.shared.open(url)
          }

      }
}
