# Flutter KBZ Pay

KBZ Bank payment with Flutter

## README

1. You need KBZ Merchant Account and related account and app information. So, contact KBZ bank
2. After contacting KBZ bank, they will give you UAT test bank account, UAT testing app for android
   and ios, app_id and merchant information.
3. [Here](https://wap.kbzpay.com/pgw/uat/api/#/en/dashboard) is the official KBZ payment integration
   documentation. You should read `In App Payment` section.
4. In KBZPay docs, they will say `Merchant Key`, `Sign Key` or `App Key`. Don't get confused and
   please remember, they are the same. 🥹

## Android

Download the current KBZPay SDK in the Frontend SDK section of SDK & Demo tab
as [here](https://wap.kbzpay.com/pgw/uat/api/#/en/docs/InApp/in-app-download-en). Sometimes download
link fails, please contact the bank at this time or get the SDK(v1.1.0) in the project of example.

`Since Android Studio 4.2 you need to manually perform these steps in order to add .jar/.aar files`

1. Open the android folder of your flutter project
2. In the android root folder create a single folder for `kbz-pay-app`, place the corresponding aar
   file and create an empty `build.gradle` file, like on the folder structure below:

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

3. Content of the `android/kbz-pay-app/build.gradle` file:
   ```gradle
   configurations.maybeCreate("default")
   artifacts.add("default", file('kbzsdk_x.x.x.aar'))
   ```
   Please careful the file name of Android Archive file.
4. In the android root folder find `settings.gradle` file, open it and add this `":kbz-pay-app"`
   ```gradle
   // you will already have like this or any more
   include ":app"
   
   // After adding, may be like that
   include ":app", ":kbz-pay-app"
   ```

**Notice:**

- There are two KBZPay SDKs for UAT and Production. Please use SDK in order of your development
  process.🎯

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

2. Add a `Custom URI Scheme` in `CFBundleURLTypes`

   In order for `KBZ` to send users `back to your application`, we need to set up
   a `Custom URI scheme` in
   our `Info.plist`. To do this, we'll need our Bundle ID and Redirect URI. It will serve as
   a `Deep Linking` in flutter. You should learn about this topic.

   ```plist
   <key>CFBundleURLTypes</key>
   <array>
     <dict>
       <key>CFBundleURLName</key>
       <string>[ANY_URL_NAME]</string>
       <key>CFBundleURLSchemes</key>
       <array>
         <string>[YOUR_SCHEME]</string>
       </array>
     </dict>
   </array>
   ```

**Notice: If there are any update of KBZPay iOS SDK, you need to download current ` Customer SDK`
in [here](https://wap.kbzpay.com/pgw/uat/api/#/en/docs/InApp/in-app-download-en)**

And then, re-place production framework and simulator framework
in `kbz_pay/ios/Frameworks/KBZPayAPPPay.xcframework` and if you need to re-config, research and do
it again.

**You can also read my research, [How to write flutter plugin](HowTo.md). These content of my
research may be wrong, just a research!**

<hr>

**Feel Free to Code**

*Happy Coding ...<br>
Jack*