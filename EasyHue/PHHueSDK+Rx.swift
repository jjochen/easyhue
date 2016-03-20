//
//  RxHueSDK.swift
//  EasyHue
//
//  Created by Jochen Pfeiffer on 19.03.16.
//  Copyright © 2016 Jochen Pfeiffer. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

extension PHBridgeSearching {
    public func rx_startSearch() -> Observable<Array<BridgeInfo>> {
        return Observable.create { observer in
            self.startSearchWithCompletionHandler { bridgesFound -> () in
                var result: Array<BridgeInfo> = []
                for bridge in bridgesFound {
                    let bridgeInfo = BridgeInfo(id: bridge.0.description, ip: bridge.1.description)
                    result += [bridgeInfo]
                }
                observer.on(.Next(result))
                observer.on(.Completed)
            }
            return NopDisposable.instance
        }
    }
}


public class BridgeInfo {
    
    let id: String
    let ip: String
    init(id: String, ip: String) {
        self.id = id
        self.ip = ip
    }
}
