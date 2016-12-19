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
import SwiftyHue


internal class BridgeSelectionViewModel: ViewModel
{
    // MARK: Input
    var bridgeFinder: BridgeFinder
    var refreshTaps = PublishSubject<Void>()
    
    // MARK: Output
    internal let availableBridges: Driver<[HueBridge]>
    internal let loading: Driver<Bool>
    
    // MARK: - Livecycle
    
    init(bridgeFinder: BridgeFinder) {
        self.bridgeFinder = bridgeFinder
        
        let loading = ActivityIndicator()
        self.loading = loading.asDriver()
        
        let availableBridges = bridgeFinder
            .rx
            .bridges
            .trackActivity(loading)
        
        let refreshAvailableBridges = self.refreshTaps
            .flatMapLatest { _ -> Observable<[HueBridge]> in
                return availableBridges
            }
            .shareReplay(1)
        
        self.availableBridges = Observable
            .from([availableBridges, refreshAvailableBridges])
            .merge()
            .asDriver(onErrorJustReturn: [])
    }
    
    public func startSearch()
    {
        self.bridgeFinder.start()
    }
}
