//
//  SVProgressHUD+Rx.swift
//  EasyHue
//
//  Created by Jochen Pfeiffer on 18/09/2016.
//  Copyright © 2016 Jochen Pfeiffer. All rights reserved.
//

import Foundation
import SVProgressHUD
import RxSwift
import RxCocoa

extension SVProgressHUD {
    
    /**
     Bindable sink for SVProgressHUD show/hide methods.
     */
    public class var rx_animating: AnyObserver<Bool> {
        return AnyObserver { event in
            MainScheduler.ensureExecutingOnScheduler()
            
            switch (event) {
            case .next(let value):
                if value {
                    SVProgressHUD.show()
                } else {
                    SVProgressHUD.dismiss()
                }
            case .error(let error):
                let error = "Binding error to UI: \(error)"
                #if DEBUG
                    rxFatalError(error)
                #else
                    print(error)
                #endif
            case .completed:
                break
            }
        }
    }
}
