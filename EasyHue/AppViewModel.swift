//
//  MainViewModel.swift
//  EasyHue
//
//  Created by Jochen Pfeiffer on 27.02.16.
//  Copyright © 2016 Jochen Pfeiffer. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class AppViewModel : ViewModel
{
    // MARK: - Input
    
    let hueSDK: PHHueSDK
    
    
    // MARK: - Livecycle
    
    init(hueSDK: PHHueSDK) {
        self.hueSDK = hueSDK
    }
    
    
    // MARK: - View Models
    
    func bridgeSelectionViewModel() -> BridgeSelectionViewModel {
        let bridgeSearch = PHBridgeSearching(upnpSearch: true, andPortalSearch: true, andIpAdressSearch: true)
        return BridgeSelectionViewModel(hueSDK: self.hueSDK, bridgeSearch: bridgeSearch!)
    }
    
}
