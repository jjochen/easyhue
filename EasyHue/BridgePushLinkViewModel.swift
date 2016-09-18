//
//  BridgePushLinkViewModel.swift
//  EasyHue
//
//  Created by Jochen Pfeiffer on 25.02.16.
//  Copyright © 2016 Jochen Pfeiffer. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

internal class BridgePushLinkViewModel: ViewModel
{
    // MARK: Variables
    fileprivate let _pushLinkProgress = Variable<Float>(0)
    
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
    
    
    // TODO: handle notifications with rx bindings
    
    // MARK: Notifications
    fileprivate func registerForNotifications()
    {
        let notificationManager = PHNotificationManager.default();
        notificationManager?.register(self, with:#selector(authenticationSuccess), forNotification:PUSHLINK_LOCAL_AUTHENTICATION_SUCCESS_NOTIFICATION)
        notificationManager?.register(self, with:#selector(authenticationFailed), forNotification:PUSHLINK_LOCAL_AUTHENTICATION_FAILED_NOTIFICATION)
        notificationManager?.register(self, with:#selector(noLocalConnection), forNotification:PUSHLINK_NO_LOCAL_CONNECTION_NOTIFICATION)
        notificationManager?.register(self, with:#selector(noLocalBridge), forNotification:PUSHLINK_NO_LOCAL_BRIDGE_KNOWN_NOTIFICATION)
        notificationManager?.register(self, with:#selector(buttonNotPressed), forNotification:PUSHLINK_BUTTON_NOT_PRESSED_NOTIFICATION)
    }
    
    func deregisterForNotifications()
    {
        let notificationManager = PHNotificationManager.default();
        notificationManager?.deregisterObject(forAllNotifications: self);
    }
    
    func authenticationSuccess(_ notifiction: Notification)
    {
        deregisterForNotifications()
        
    }
    
    func authenticationFailed(_ notifiction: Notification)
    {
        deregisterForNotifications()
        failWithError(PUSHLINK_TIME_LIMIT_REACHED, description: "Authentication failed: time limit reached.")
    }
    
    func noLocalConnection(_ notifiction: Notification)
    {
        deregisterForNotifications()
        failWithError(PUSHLINK_NO_CONNECTION, description: "Authentication failed: No local connection to bridge.")
    }
    
    func noLocalBridge(_ notifiction: Notification)
    {
        deregisterForNotifications()
        failWithError(PUSHLINK_NO_LOCAL_BRIDGE, description: "Authentication failed: No local bridge found.")
    }
    
    func buttonNotPressed(_ notifiction: Notification)
    {
        let userInfo: NSDictionary? = (notifiction as NSNotification).userInfo as NSDictionary?
        let progressPercentage = userInfo?["progressPercentage"]
        if (progressPercentage == nil)
        {
            return
        }
        
        _pushLinkProgress.value = (progressPercentage as! NSNumber).floatValue / Float(100)
    }
    
    fileprivate func failWithError(_ errorCode: CLErrorCode, description: String)
    {
        let userInfo = [NSLocalizedDescriptionKey: description]
        let error: PHError = PHError(domain: SDK_ERROR_DOMAIN, code: Int(errorCode.rawValue), userInfo: userInfo)
//        delegate?.pushlinkFailed(error)
    }
    

}
