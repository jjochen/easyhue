//
//  BridgePushLinkViewController.swift
//  EasyHue
//
//  Created by Jochen Pfeiffer on 24.02.16.
//  Copyright © 2016 Jochen Pfeiffer. All rights reserved.
//

import UIKit


protocol BridgePushLinkViewControllerDelegate
{
    func pushlinkSuccess()
    func pushlinkFailed(error: PHError)
}


class BridgePushLinkViewController: UIViewController
{
    var hueSDK: PHHueSDK?
    var delegate: BridgePushLinkViewControllerDelegate?
    @IBOutlet weak var progressView: UIProgressView!
    
    init?(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?, hueSDK: PHHueSDK, delegate: BridgePushLinkViewControllerDelegate)
    {
        self.hueSDK = hueSDK
        self.delegate = delegate
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func startPushLinking()
    {
        if (hueSDK == nil)
        {
            return
        }
        
        registerForNotifications()
        hueSDK?.startPushlinkAuthentication()
    }
    
    
    func registerForNotifications()
    {
        let notificationManager = PHNotificationManager.defaultManager();
        notificationManager.registerObject(self, withSelector:Selector("authenticationSuccess:"), forNotification:PUSHLINK_LOCAL_AUTHENTICATION_SUCCESS_NOTIFICATION)
        notificationManager.registerObject(self, withSelector:Selector("authenticationFailed:"), forNotification:PUSHLINK_LOCAL_AUTHENTICATION_FAILED_NOTIFICATION)
        notificationManager.registerObject(self, withSelector:Selector("noLocalConnection:"), forNotification:NO_LOCAL_AUTHENTICATION_NOTIFICATION)
        notificationManager.registerObject(self, withSelector:Selector("noLocalBridge:"), forNotification:PUSHLINK_NO_LOCAL_CONNECTION_NOTIFICATION)
        notificationManager.registerObject(self, withSelector:Selector("notAuthenticated:"), forNotification:PUSHLINK_NO_LOCAL_BRIDGE_KNOWN_NOTIFICATION)
        notificationManager.registerObject(self, withSelector:Selector("buttonNotPressed:"), forNotification:PUSHLINK_BUTTON_NOT_PRESSED_NOTIFICATION)
    }
    
    func deregisterForNotifications()
    {
        let notificationManager = PHNotificationManager.defaultManager();
        notificationManager.deregisterObjectForAllNotifications(self);
    }
    
    func authenticationSuccess(notifiction: NSNotification)
    {
        deregisterForNotifications()
        
        delegate?.pushlinkSuccess()
    }
    
    func authenticationFailed(notifiction: NSNotification)
    {
        deregisterForNotifications()
        failWithError(PUSHLINK_TIME_LIMIT_REACHED, description: "Authentication failed: time limit reached.")
    }
    
    func noLocalConnection(notifiction: NSNotification)
    {
        deregisterForNotifications()
        failWithError(PUSHLINK_NO_CONNECTION, description: "Authentication failed: No local connection to bridge.")
    }
    
    func noLocalBridge(notifiction: NSNotification)
    {
        deregisterForNotifications()
        failWithError(PUSHLINK_NO_LOCAL_BRIDGE, description: "Authentication failed: No local bridge found.")
    }
    
    func buttonNotPressed(notifiction: NSNotification)
    {
        let userInfo: NSDictionary? = notifiction.userInfo as NSDictionary?
        let progressPercentage = userInfo?["progressPercentage"]
        if (progressPercentage == nil)
        {
            return
        }
        
        let progressBarValue = (progressPercentage! as! NSNumber).floatValue / Float(100)
        self.progressView.progress = progressBarValue
        print("progress: \(progressBarValue)")
    }
    
    func failWithError(errorCode: CLErrorCode, description: String)
    {
        if (delegate == nil)
        {
            return
        }
        let userInfo = [NSLocalizedDescriptionKey: description]
        let error: PHError = PHError(domain: SDK_ERROR_DOMAIN, code: Int(errorCode.rawValue), userInfo: userInfo)
        delegate?.pushlinkFailed(error)
    }
    
   
  
}

