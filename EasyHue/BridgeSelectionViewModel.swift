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
    let hueSDK: PHHueSDKProtocol
    let bridgeSearch: PHBridgeSearchingProtocol
    
    // MARK: Output
    internal let availableBridges: Driver<[BridgeInfo]>
    internal let loading: Driver<Bool>
    
    
    // MARK: - Livecycle
    
    init(hueSDK: PHHueSDKProtocol, bridgeSearch: PHBridgeSearchingProtocol) {
        self.hueSDK = hueSDK
        self.bridgeSearch = bridgeSearch
        
        let loading = ActivityIndicator()
        self.loading = loading.asDriver()
        
        let availableBridges: Observable<[BridgeInfo]> = bridgeSearch.rx_startSearch()
            .trackActivity(loading)
        self.availableBridges = availableBridges.asDriver(onErrorJustReturn: [])
    }    
}
