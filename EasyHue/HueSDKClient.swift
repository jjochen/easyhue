//
//  HueClient.swift
//  EasyHue
//
//  Created by Jochen Pfeiffer on 23.02.16.
//  Copyright © 2016 Jochen Pfeiffer. All rights reserved.
//

import Foundation


class HueSDKClient: NSObject
{
    override init()
    {
        self.hueSDK = PHHueSDK()
        self.hueSDK.startUpSDK()
        self.hueSDK.enableLogging(true)
        super.init()
        
        registerForNotifications()
    }
    
    private let hueSDK: PHHueSDK
    private var bridgeSearch: PHBridgeSearching?
    
    // MARK: Heartbeat
    
    func enableLocalHeartbeat()
    {
        let cache: PHBridgeResourcesCache? = PHBridgeResourcesReader.readBridgeResourcesCache()
        
        if cache != nil && cache!.bridgeConfiguration != nil && cache!.bridgeConfiguration!.ipaddress != nil
        {
            self.hueSDK.enableLocalConnection()
        }
        else
        {
            searchForBridgeLocal()
        }
    }
    
    func disableLocalHeartbeat()
    {
        self.hueSDK.disableLocalConnection()
    }
    
    // MARK: Bridge Management
    
    internal func searchForBridgeLocal()
    {
        disableLocalHeartbeat()
        self.bridgeSearch = PHBridgeSearching(upnpSearch: true, andPortalSearch: true, andIpAdressSearch: true)
        bridgeSearch?.startSearchWithCompletionHandler { (bridgesFound: [NSObject : AnyObject]!) -> Void in
            print(bridgesFound)
        }
        
    }
    
    internal func startPushLinking()
    {
        self.hueSDK.startPushlinkAuthentication()
    }
 
    func useBridge(bridgeId: String!, ipAddress: String!) {
        self.hueSDK.setBridgeToUseWithId(bridgeId, ipAddress: ipAddress)
        
        self.enableLocalHeartbeat()
    }
}



private extension HueSDKClient
{
    func registerForNotifications()
    {
        let notificationManager = PHNotificationManager.defaultManager();
        notificationManager.registerObject(self, withSelector:Selector("localConnection:"), forNotification:LOCAL_CONNECTION_NOTIFICATION)
        notificationManager.registerObject(self, withSelector:Selector("noLocalConnection:"), forNotification:NO_LOCAL_CONNECTION_NOTIFICATION)
        notificationManager.registerObject(self, withSelector:Selector("notAuthenticated:"), forNotification:NO_LOCAL_AUTHENTICATION_NOTIFICATION)

    }
    
    func localConnection(notifiction: NSNotification)
    {
        
    }
    
    func noLocalConnection(notifiction: NSNotification)
    {
        
    }
    
    func notAuthenticated(notifiction: NSNotification)
    {
        
    }
}


