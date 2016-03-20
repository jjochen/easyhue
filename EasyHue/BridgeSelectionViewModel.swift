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
    internal let availableBridges: Driver<Array<BridgeInfo>>
//    internal let loading: Driver<Bool>
    
    // MARK: Variables
    
    private let bridgeSearch = PHBridgeSearching(upnpSearch: true, andPortalSearch: true, andIpAdressSearch: true)
    
    
    // MARK: - Livecycle
    
    init(hueSDK: PHHueSDK) {
        self.hueSDK = hueSDK
        self.availableBridges = self.bridgeSearch.rx_startSearch().asDriver(onErrorJustReturn: [])
        
    }
    
}
