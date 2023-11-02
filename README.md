# KBZPay In-App Payment

KBZPay payment with Flutter

## README

1. You need KBZPay Merchant Account and related account and app information. So, contact KBZ bank
2. After contacting KBZ bank, they will give you UAT account, UAT app for android
   and ios, app_id and merchant information.
3. [Here](https://wap.kbzpay.com/pgw/uat/api/#/en/dashboard) is the official KBZPay payment integration documentation. You should read `In App Payment` section.
4. In KBZPay docs, they will say `Merchant Key`, `Sign Key` or `App Key`. Don't get confused and please remember, they are the same. But `Merchant Code` is difference with `Merchant Key`. 🥹

## Android

Download the current KBZPay SDK in the Frontend SDK section of SDK & Demo tab
as [here](https://wap.kbzpay.com/pgw/uat/api/#/en/docs/InApp/in-app-download-en). Sometimes download
link fails, please contact the bank at this time or get the SDK(v1.1.0) in the project of example.

`Since Android Studio 4.2 you need to manually perform these steps in order to add .jar/.aar files`

1.  Open the android folder of your flutter project
2.  In the android root folder create a single folder for `kbz-pay-app`, place the corresponding Android Archive(aar) file and create an empty `build.gradle` file, like on the folder structure below:

      <pre>
        .
        └── flutter_project/
            └── android/
                ├── app
                ├── gradle
                └── kbz-pay-app/
                    ├── kbzsdk_x.x.x.aar
                    └── build.gradle
      </pre>

    **In `kbzsdk_x.x.x.aar`, x.x.x means the SDK version.**

3.  Content of the `android/kbz-pay-app/build.gradle` file:

    ```gradle
    configurations.maybeCreate("default")
    artifacts.add("default", file('kbzsdk_x.x.x.aar'))
    ```

    **Please careful the file name of Android Archive file. It must be the same of the kbz SDK file name. There are two KBZPay SDKs archive file for UAT and Production. Please config the correct SDK in order of your development process.🎯**

4.  In the android root folder find `settings.gradle` file, open it and add this `":kbz-pay-app"`

    ```gradle
    // you will already have like this or any more
    include ":app"

    // After adding, may be like that
    include ":app", ":kbz-pay-app"
    ```

5.  A payment completion message is sent by calling back the activity in the app. Create an activity in the project of `AndroidManifest.xml` file to receive payment results.

    ```xml
    <application>
         <!-- ... other config -->
      <activity
            android:name="com.kbzbank.payment.sdk.callback.CallbackResultActivity"
            android:exported="true" />
    </application>
    ```

    **If the preceding procedure is not performed, the payment completion message may not be received in production but works on development. 👨🏻‍💻**

### _Notice:_

-   There are two KBZPay SDKs for UAT and Production. Please config the correct SDK in order of your development process.🎯

## iOS

### Configure `Info.plist`

We'll need to configure our `Info.plist` to support the iOS SDK. There are two things we need to
add:

1. Add `kbzpay` to `LSApplicationQueriesSchemes`

    **We'll need this to check if the KBZPay main application is installed.
    The `LSApplicationQueriesSchemes` key in `Info.plist` allows your application to perform this
    check. To set this up, add this to your `Info.plist`:**

    ```plist
    <key>LSApplicationQueriesSchemes</key>
    <array>
      <string>kbzpay</string>
    </array>
    ```

2. Add a `App Bundle Identifier` in `CFBundleURLTypes` as URL Schema

    In order for `KBZ` to send users `back to your application` with payment result status, we need to set up a `URI scheme` in our `Info.plist`. To do this, we'll need our Bundle ID and Redirect URI. It will serve as a `Deep Linking` in flutter. You should learn about this topic.

    ```plist
    <key>CFBundleURLTypes</key>
    <array>
    <dict>
      <key>CFBundleURLName</key>
      <string>[ANY_URL_NAME]</string>
      <key>CFBundleURLSchemes</key>
      <array>
         <string>[YOUR_APP_BUNDLE_IDENTIFIER]</string>
      </array>
    </dict>
    </array>
    ```

**Notice: If there are any update of KBZPay iOS SDK, you need to download current ` Customer SDK`(Version 1.3.0)
in [here](https://wap.kbzpay.com/pgw/uat/api/#/en/docs/InApp/in-app-download-en)**

And then, re-place production framework and simulator framework
in `kbz_pay/ios/Frameworks/KBZPayAPPPay.xcframework` and if you need to re-config, research and do it again.

## HowToUse

```dart

final _flutterKbzPayPlugin = KbzAppPayment();

void pay({required String prePayId, required String merchantKey}) {
    final order = _buildOrderInfo(prePayId, merchantKey);

    /// In iOS, you require appScheme because KBZPay callback to openUrl of your app for payment status
    _flutterKbzPayPlugin.startPay(
       orderInfo: order.$1,
       sign: order.$2,
       appScheme: "com.flutter.kbzpay.jackwill",
    );
}

/// Payment Status (Works only Android. In iOS, you can listen status from deep link)
Stream<dynamic> onPayStatus() {
    return _flutterKbzPayPlugin.onPayStatus();
}

/// Actually, you don't need this method. Required infos are given by server-side. This is just for demo.
(String, String) _buildOrderInfo(String prePayId, String merchantKey) {
    final orderInfo =
      "appid=${info.appId}&merch_code=${info.merchCode}&nonce_str=${RandomGen.I.nonceStr(
      20)}&prepay_id=$prePayId&timestamp=${RandomGen.I.timeStamp()}";

    final sign = SHA.I.getSHA256Str("$orderInfo&key=$merchantKey");
    return (orderInfo, sign);
}

```

In iOS, `onPayStatus` can't work so, listen by the deeplink.

Example of deeplink
is `com.flutter.kbzpay.jackwill://?EXTRA_RESULT=0&EXTRA_ORDER_ID=01003203060026798916`.

`EXTRA_RESULT` of the status -

-   0：Pay for success，
-   3：Payment failed, the remaining fields are reserved by KBZPay for later addition

**You can also read my research, [How to write flutter plugin](HowTo.md). These content of my
research may be wrong, just a research!**

<hr>

**Feel Free to Code**

_Happy Coding ...<br>
Jack Will_
