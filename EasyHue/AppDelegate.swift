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

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool
    {
        SVProgressHUD.configureForEasyHue()
        setupViewModel()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
    }

    
    // MARK: - Private Methods
    
    fileprivate func setupViewModel() {
        guard let appViewController = window?.rootViewController as? AppViewController else { return }
        let viewModel = AppViewModel()
        appViewController.viewModel = viewModel
    }

}
