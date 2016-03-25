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
import SVProgressHUD

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    lazy var hueSDK: PHHueSDK = {
        return PHHueSDK()
    }()

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool
    {
        SVProgressHUD.configureForEasyHue()
        setupViewModel()
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

    
    // MARK: - Private Methods
    
    private func setupViewModel() {
        guard let appViewController = window?.rootViewController as? AppViewController else { return }
        
        self.hueSDK.startUpSDK()
        self.hueSDK.enableLogging(false)
        let viewModel = AppViewModel(hueSDK: self.hueSDK)
        appViewController.viewModel = viewModel
    }

}
