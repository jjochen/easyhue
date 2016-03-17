//
//  AppDelegate.swift
//  EasyHue
//
//  Created by Jochen Pfeiffer on 23.02.16.
//  Copyright © 2016 Jochen Pfeiffer. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let hueSDK = PHHueSDK()
    var viewModel: AppViewModel?
    let disposeBag = DisposeBag()

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool
    {
        self.hueSDK.startUpSDK()
        self.hueSDK.enableLogging(false)
        
        self.viewModel = AppViewModel(hueSDK: self.hueSDK)
        self.viewModel?.searchForBridgeLocal()
        
        self.viewModel?.availableBridges
            .driveNext { bridges in
                print(bridges)
            }
            .addDisposableTo(disposeBag)
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        
    }

    func applicationDidEnterBackground(application: UIApplication) {
        
    }

    func applicationWillEnterForeground(application: UIApplication) {
        
    }

    func applicationDidBecomeActive(application: UIApplication) {
    }

    func applicationWillTerminate(application: UIApplication) {
    }

    
    private func showBridgePushLinkViewController() {
        
    }
    
    private func showBridgeSelectionViewController() {
        
    }
    
    private func showLoadingIndicator()
    {
        SVProgressHUD.show()
    }
}
