source 'https://github.com/jjochen/podspecs.git'
source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '9.0'
use_frameworks!
inhibit_all_warnings!


target 'EasyHue' do
    pod 'PhilipsHueSDK-iOS'
    pod 'RxSwift'
    pod 'RxCocoa'
    #pod 'RxViewModel'
    pod 'RxOptional'
    pod 'RxDataSources'
    pod 'RealmSwift'
    pod 'SVProgressHUD'
    pod 'SnapKit'

    target 'EasyHueTests' do
        inherit! :search_paths
        pod 'Quick'
        pod 'Nimble'
        pod 'RxTests'
        #pod 'RxNimble'
        pod 'RxBlocking'
    end
end


