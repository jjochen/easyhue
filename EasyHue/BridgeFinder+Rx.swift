//
//  BridgeFinder+Rx.swift
//  EasyHue
//
//  Created by Jochen Pfeiffer on 06/12/2016.
//  Copyright © 2016 Jochen Pfeiffer. All rights reserved.
//

import Foundation
import RxSwift
import SwiftyHue
import RxCocoa

extension BridgeFinder {
    public func createRxDelegateProxy() -> RxBridgeFinderDelegateProxy {
        return RxBridgeFinderDelegateProxy(parentObject: self)
    }
    
}

extension Reactive where Base: BridgeFinder {

    public var delegate: DelegateProxy {
        return RxBridgeFinderDelegateProxy.proxyForObject(base)
    }
    
    public var bridges: Observable<[HueBridge]> {
        let proxy = RxBridgeFinderDelegateProxy.proxyForObject(base)
        return proxy.bridgesSubject
    }
    
    public func setDelegate(_ delegate: BridgeFinderDelegate)
        -> Disposable {
            return RxScrollViewDelegateProxy.installForwardDelegate(delegate, retainDelegate: false, onProxyForObject: self.base)
    }
}
