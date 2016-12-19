//
//  RxBridgeFinderDelegateProxy.swift
//  EasyHue
//
//  Created by Jochen Pfeiffer on 05/12/2016.
//  Copyright © 2016 Jochen Pfeiffer. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import UIKit
import SwiftyHue

public class RxBridgeFinderDelegateProxy : DelegateProxy, DelegateProxyType, BridgeFinderDelegate {
    
    public let bridgesSubject = PublishSubject<[HueBridge]>()
    
    
    // MARK: delegate methods
    
    public func bridgeFinder(_ finder: BridgeFinder, didFinishWithResult bridges: [HueBridge]) {
        bridgesSubject.on(.next(bridges))
        // TODO !!!
        //self._forwardToDelegate?.bridgeFinder(finder, didFinishWithResult: bridges)
    }
    
    
    // MARK: delegate proxy
    
    public override class func createProxyForObject(_ object: AnyObject) -> AnyObject {
        let bridgeFinder = (object as! BridgeFinder)
        return castOrFatalError(bridgeFinder.createRxDelegateProxy())
    }
    
    public class func setCurrentDelegate(_ delegate: AnyObject?, toObject object: AnyObject) {
        let bridgeFinder: BridgeFinder = castOrFatalError(object)
        bridgeFinder.delegate = castOptionalOrFatalError(delegate)
    }
    
    public class func currentDelegateFor(_ object: AnyObject) -> AnyObject? {
        let bridgeFinder: BridgeFinder = castOrFatalError(object)
        return bridgeFinder.delegate
    }
    
    deinit {
        bridgesSubject.on(.completed)
    }
    
}
