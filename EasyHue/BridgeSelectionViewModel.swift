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
    let hueSDK: PHHueSDKType
    let bridgeSearch: PHBridgeSearchingType
    var refreshTaps = PublishSubject<Void>()
    
    // MARK: Output
    internal let availableBridges: Driver<[BridgeInfo]>
    internal let loading: Driver<Bool>
    
    
    // MARK: - Livecycle
    
    init(hueSDK: PHHueSDKType, bridgeSearch: PHBridgeSearchingType) {
        self.hueSDK = hueSDK
        self.bridgeSearch = bridgeSearch
        
        let loading = ActivityIndicator()
        self.loading = loading.asDriver()
        
        let availableBridges = bridgeSearch
            .rx_startSearch()
            .trackActivity(loading)
        let refreshAvailableBridges = refreshTaps
            .flatMapLatest { _ -> Observable<[BridgeInfo]> in
                return availableBridges
            }
            .shareReplay(1)
        self.availableBridges = [availableBridges, refreshAvailableBridges]
            .toObservable()
            .merge()
            .asDriver(onErrorJustReturn: [])
    }
}
