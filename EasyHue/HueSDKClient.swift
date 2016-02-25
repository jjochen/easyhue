//
//  HueClient.swift
//  EasyHue
//
//  Created by Jochen Pfeiffer on 23.02.16.
//  Copyright © 2016 Jochen Pfeiffer. All rights reserved.
//

import Foundation

class HueSDKClient: NSObject {
    
    let sdk: PHHueSDK
    
    override init() {
        sdk = PHHueSDK()
        super.init()
        registerForNotifications()
        sdk.enableLogging(true)
        sdk.startUpSDK()
    }
    
    
// MARK: Notifications
    
    func registerForNotifications() {
        
        let notificationManager = PHNotificationManager.defaultManager();
        notificationManager.registerObject(self, withSelector:Selector("localConnection:"), forNotification:LOCAL_CONNECTION_NOTIFICATION)
        notificationManager.registerObject(self, withSelector:Selector("noLocalConnection:"), forNotification:NO_LOCAL_CONNECTION_NOTIFICATION)
        notificationManager.registerObject(self, withSelector:Selector("notAuthenticated:"), forNotification:NO_LOCAL_AUTHENTICATION_NOTIFICATION)
    }
    
    func localConnection(notifiction: NSNotification) {
        
    }
    
    func noLocalConnection(notifiction: NSNotification) {
        
    }
    func notAuthenticated(notifiction: NSNotification) {
        
    }
    
    
// MARK: Heartbeat
    
    func enableLocalHeartbeat() {
        /***************************************************
         The heartbeat processing collects data from the bridge
         so now try to see if we have a bridge already connected
         *****************************************************/
    
        let cache: PHBridgeResourcesCache? = PHBridgeResourcesReader.readBridgeResourcesCache()
        
        if cache != nil && cache!.bridgeConfiguration != nil && cache!.bridgeConfiguration!.ipaddress != nil {
            sdk.enableLocalConnection()
            
        } else {
            
            searchForBridgeLocal()
        }
    }
    
    func disableLocalHeartbeat() {
        sdk.disableLocalConnection()
    }
    
    
    func searchForBridgeLocal() {
        
    }
}

