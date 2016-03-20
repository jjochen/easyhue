Pod::Spec.new do |s|
  s.name         = "PhilipsHueSDK-iOS"
  s.version      = "1.11.2"
  s.license      = { :type => "MIT", :file => "ACKNOWLEDGEMENTS.md"}
  s.summary      = "The Software Development Kit for Philips Hue on iOS (beta)"
  s.homepage     = "https://github.com/PhilipsHue/PhilipsHueSDK-iOS-OSX"
  s.author       = "Philips"
  s.requires_arc = true

  s.ios.deployment_target = '8.1'

  s.source       = { :git => "https://github.com/PhilipsHue/PhilipsHueSDK-iOS-OSX.git", :tag => "v1.11.2beta" }

  s.vendored_frameworks = 'HueSDK_iOS.framework'

  s.dependency 'CocoaLumberjack', '~> 1.8'

  s.xcconfig  =   { 'FRAMEWORK_SEARCH_PATHS' =>  '$(PODS_ROOT)/PhilipsHueSDK-iOS/' }

  s.compiler_flags = '-ObjC'
end