//
//  StreamHandler.swift
//  kbz_pay
//
//  Created by Jack Will on 10/4/23.
//

import Flutter
import KBZPayAPPPay.PaymentViewController
import UIKit

public class FlutterKbzPayPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "com.flutter.kbz.pay", binaryMessenger: registrar.messenger())
        let instance = FlutterKbzPayPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "startPay":
            startPay(call: call, result: result)

        default:
            result(FlutterMethodNotImplemented)
        }
    }

    private func startPay(call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let args = call.arguments as? [String: Any] else {
            result("There is no arguments")
            return
        }

        guard let orderInfo = args["orderInfo"] as? String else {
            return
        }
        guard let sign = args["sign"] as? String else {
            return
        }
        guard let signType = args["signType"] as? String else {
            return
        }
        guard let appScheme = args["appScheme"] as? String else {
            result("appScheme params need")
            return
        }

        let controller = PaymentViewController()

        // Original source code of Objective-C method is `startPayWithOrderInfo` and Swift naming convention override this method to `startPay`
        // https://stackoverflow.com/a/40164599/19999522
        controller.startPay(withOrderInfo: orderInfo, signType: signType, sign: sign, appScheme: appScheme)
    }

    // Original Method of Objective-C to Swift
    func startPayWithOrderInfo(orderInfo: String, signType: String, sign: String, appScheme: String) {
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
        print("finalURL :", finalURL)
        guard let url = URL(string: finalURL) else {
            return
        }
        if !UIApplication.shared.canOpenURL(url) {
            let alert = UIAlertController(title: "", message: "please install kbzpay app first", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { _ in
                let str = "itms-apps://itunes.apple.com/cn/app/id1398852297?mt=8"
                UIApplication.shared.open(URL(string: str)!) { _ in }
            }
            alert.addAction(defaultAction)

            var topRootViewController = UIApplication.shared.windows.first?.rootViewController as? UIViewController
            while (topRootViewController?.presentedViewController) != nil {
                topRootViewController = topRootViewController?.presentedViewController
            }
            topRootViewController?.present(alert, animated: true, completion: nil)
        } else {
            UIApplication.shared.open(url)
        }
    }
}
