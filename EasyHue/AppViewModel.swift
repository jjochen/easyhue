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
import SwiftyHue

class AppViewModel : ViewModel
{
    // MARK: - Input
    
    // MARK: - View Models
    
    func bridgeSelectionViewModel() -> BridgeSelectionViewModel {
        return BridgeSelectionViewModel()
    }
    
}
