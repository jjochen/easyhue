//
//  MainViewModel.swift
//  EasyHue
//
//  Created by Jochen Pfeiffer on 27.02.16.
//  Copyright © 2016 Jochen Pfeiffer. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class AppViewModel
{
    // MARK: - Input
    
    let hueSDK: PHHueSDK
    
    
    // MARK: - Livecycle
    
    init(hueSDK: PHHueSDK) {
        self.hueSDK = hueSDK
    }
    
    
    // MARK: - View Models
    
    func brideSelectionViewModel() -> BridgeSelectionViewModel {
        return BridgeSelectionViewModel(hueSDK: self.hueSDK)
    }
    
}