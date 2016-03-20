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

extension PHBridgeSearching: PHBridgeSearchingProtocol {
    func rx_startSearch() -> Observable<[BridgeInfo]> {
        return Observable.create { observer in
            self.startSearchWithCompletionHandler { bridgesFound -> () in
                let result = bridgesFound.map({ (id, ip) -> BridgeInfo in
                    return BridgeInfo(id: id.description, ip: ip.description)
                })
                observer.on(.Next(result))
                observer.on(.Completed)
            }
            return AnonymousDisposable {
                self.cancelSearch()
            }
        }
    }
}

