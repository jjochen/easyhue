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

extension PHBridgeSearching: PHBridgeSearchingType
{
    func rx_startSearch() -> Observable<[BridgeInfo]>
    {
        return Observable.create { observer in
            let cancel = Disposables.create {
                self.cancelSearch()
            }
            
            self.startSearch(completionHandler: { result in
                guard let bridgesFound = result else {return}
                if cancel.isDisposed {
                    return
                }
                let result: [BridgeInfo] = bridgesFound.map({ (key, value) -> BridgeInfo in
                    let emptyBridge = BridgeInfo(id: "", ip: "")
                    guard let id = (key as? String) else {return emptyBridge}
                    guard let ip = (value as? String) else {return emptyBridge}
                    return BridgeInfo(id: id, ip: ip)
                })
                observer.on(.next(result))
                observer.on(.completed)
            })
            
            return cancel
        }
    }
}

