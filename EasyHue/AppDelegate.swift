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
    let hueSDK = PHHueSDK()
    var viewModel: AppViewModel?
    let disposeBag = DisposeBag()

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool
    {
        self.configureAppearence()
        self.setupViewModel()
        self.setupBindings()
        self.setupRootViewController()

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

    
    // MARK: - View Model / Bindings
    
    private func setupRootViewController() {
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let bridgeSelectionViewController: BridgeSelectionViewController = storyboard.instantiateViewControllerWithIdentifier("BridgeSelection") as! BridgeSelectionViewController
        bridgeSelectionViewController.viewModel = self.viewModel?.brideSelectionViewModel()
        
        self.window?.rootViewController = bridgeSelectionViewController
        self.window?.makeKeyAndVisible()
        
    }
    
    private func setupViewModel() {
        self.hueSDK.startUpSDK()
        self.hueSDK.enableLogging(false)
        self.viewModel = AppViewModel(hueSDK: self.hueSDK)
    }
    
    private func setupBindings() {

    }
    
    // MARK: - Appearence 
    
    private func configureAppearence() {
        SVProgressHUD.setDefaultMaskType(.Clear)
        SVProgressHUD.setBackgroundColor(UIColor(white: 0, alpha: 0.4))
        SVProgressHUD.setForegroundColor(UIColor(white: 1, alpha: 0.9))
    }
}
