//
//  BridgeSelectionViewModel.swift
//  EasyHue
//
//  Created by Jochen Pfeiffer on 19.03.16.
//  Copyright © 2016 Jochen Pfeiffer. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa


internal class BridgeSelectionViewModel: ViewModel
{
    // MARK: Input
    let hueSDK: PHHueSDK
    
    // MARK: Output
    private let _availableBridges = Variable<[NSObject : AnyObject]>([:])
    internal var availableBridges: Driver<[NSObject : AnyObject]> {
        return _availableBridges.asDriver()
    }
    
    
    // MARK: Variables
    
    private var _bridgeSearch: PHBridgeSearching?
    
    
    // MARK: - Livecycle
    
    init(hueSDK: PHHueSDK) {
        self.hueSDK = hueSDK
    }
    
    
    // MARK: - Bridges
    
    internal func searchForBridgeLocal()
    {
        _bridgeSearch = PHBridgeSearching(upnpSearch: true, andPortalSearch: true, andIpAdressSearch: true)
        _bridgeSearch!.startSearchWithCompletionHandler { (bridgesFound: [NSObject : AnyObject]!) -> Void in
            self._availableBridges.value = bridgesFound
        }
        
    }
    
}