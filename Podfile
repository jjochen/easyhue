source 'https://github.com/jjochen/podspecs.git'
source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '9.0'
use_frameworks!
inhibit_all_warnings!


target 'EasyHue' do
    pod 'PhilipsHueSDK-iOS'
    pod 'RxSwift', '~> 3.0.0-beta.1'
    pod 'RxCocoa', '~> 3.0.0-beta.1'
    #pod 'RxViewModel'
    #pod 'RxOptional'
    pod 'RxDataSources', '~> 1.0.0-beta.2'
    #pod 'RealmSwift'
    pod 'SVProgressHUD'
    #pod 'SnapKit'

    target 'EasyHueTests' do
        inherit! :search_paths
        pod 'Quick'
        pod 'Nimble'
        pod 'RxTests', '~> 3.0.0-beta.1'
        #pod 'RxNimble'
        pod 'RxBlocking', '~> 3.0.0-beta.1'
    end
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '3.0'
        end
    end
end

