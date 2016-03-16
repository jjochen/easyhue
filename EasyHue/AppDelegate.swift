//
//  AppDelegate.swift
//  EasyHue
//
//  Created by Jochen Pfeiffer on 23.02.16.
//  Copyright © 2016 Jochen Pfeiffer. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let hueSDKClient: HueSDKClient = HueSDKClient()
    let viewModel: AppViewModel = AppViewModel()

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool
    {
        
        self.hueSDKClient.searchForBridgeLocal()
        
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        
    }

    func applicationDidEnterBackground(application: UIApplication) {
        self.hueSDKClient.disableLocalHeartbeat()
    }

    func applicationWillEnterForeground(application: UIApplication) {
        self.hueSDKClient.enableLocalHeartbeat()
    }

    func applicationDidBecomeActive(application: UIApplication) {
    }

    func applicationWillTerminate(application: UIApplication) {
    }


}
