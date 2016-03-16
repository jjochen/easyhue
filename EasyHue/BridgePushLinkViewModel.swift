//
//  BridgePushLinkViewModel.swift
//  EasyHue
//
//  Created by Jochen Pfeiffer on 25.02.16.
//  Copyright © 2016 Jochen Pfeiffer. All rights reserved.
//

import Foundation
import RxSwift

internal class BridgePushLinkViewModel: NSObject
{
    // MARK: Variables
    private let _pushLinkProgress = Variable<Float>(0)
    
    // MARK: Inputs
    let hueSDK: PHHueSDK
    
    // MARK: Outputs
    var pushLinkProgress: Observable<Float> {
        return _pushLinkProgress.asObservable()
    }
    
    
    // MARK: Lifecycle
    
    init(hueSDK: PHHueSDK)
    {
        self.hueSDK = hueSDK
    }
    
    
    internal func startPushLinking()
    {
        registerForNotifications()
        hueSDK.startPushlinkAuthentication()
    }
    
    // MARK: Notifications
    private func registerForNotifications()
    {
        let notificationManager = PHNotificationManager.defaultManager();
        notificationManager.registerObject(self, withSelector:Selector("authenticationSuccess:"), forNotification:PUSHLINK_LOCAL_AUTHENTICATION_SUCCESS_NOTIFICATION)
        notificationManager.registerObject(self, withSelector:Selector("authenticationFailed:"), forNotification:PUSHLINK_LOCAL_AUTHENTICATION_FAILED_NOTIFICATION)
        notificationManager.registerObject(self, withSelector:Selector("noLocalConnection:"), forNotification:PUSHLINK_NO_LOCAL_CONNECTION_NOTIFICATION)
        notificationManager.registerObject(self, withSelector:Selector("noLocalBridge:"), forNotification:PUSHLINK_NO_LOCAL_BRIDGE_KNOWN_NOTIFICATION)
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
        
        _pushLinkProgress.value = (progressPercentage as! NSNumber).floatValue / Float(100)
    }
    
    private func failWithError(errorCode: CLErrorCode, description: String)
    {
        let userInfo = [NSLocalizedDescriptionKey: description]
        let error: PHError = PHError(domain: SDK_ERROR_DOMAIN, code: Int(errorCode.rawValue), userInfo: userInfo)
//        delegate?.pushlinkFailed(error)
    }
    

}