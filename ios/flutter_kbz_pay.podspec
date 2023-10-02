#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint flutter_kbz_pay.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'flutter_kbz_pay'
  s.version          = '0.0.1'
  s.summary          = 'KBZ Bank payment with Flutter.'
  s.description      = <<-DESC
KBZ Bank payment with Flutter.
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Jack Will' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '11.0'
  s.ios.deployment_target = '11.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'x86_64' }
  s.swift_version = '5.0'

  #
  # Let's assume you are using only one KBZPayAppPay vendor framework and
  # your folder structure is like that -> 
  #
  # plugin
  #   |_  ios/KBZPayAppPay.xcframework
  #   |_  example/...
  #
  # In this situation, you can integrate your podspec below that
  #
  # s.preserve_paths = 'KBZPayAPPPay.xcframework/**/*'
  # s.xcconfig = { 'OTHER_LDFLAGS' => '-framework KBZPayAPPPay','ENABLE_BITCODE' => 'NO' }
  # s.vendored_frameworks = 'KBZPayAPPPay.xcframework'
  

  # Or if you are using many vendor frameworks and so you can integrate folder structure like ->
  #
  # plugin
  #   |_  ios/Frameworks
  #                 |_ KBZPayAppPay.xcframework
  #                 |_ Others...
  #   |_  example/...
  #
  s.preserve_paths = 'Frameworks/**/**/*'
  s.vendored_frameworks = 'Frameworks/**'
end
