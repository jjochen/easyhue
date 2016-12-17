//
//  BridgePushLinkViewModel.swift
//  EasyHue
//
//  Created by Jochen Pfeiffer on 25.02.16.
//  Copyright © 2016 Jochen Pfeiffer. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

internal class BridgePushLinkViewModel: ViewModel
{
    // MARK: Variables
    fileprivate let _pushLinkProgress = Variable<Float>(0)
    
    // MARK: Inputs
//    let hueSDK: PHHueSDK
    
    // MARK: Outputs
    var pushLinkProgress: Observable<Float> {
        return _pushLinkProgress.asObservable()
    }
    
    
    // MARK: Lifecycle

    
    
    internal func startPushLinking()
    {
//        hueSDK.startPushlinkAuthentication()
    }
    
    

}
