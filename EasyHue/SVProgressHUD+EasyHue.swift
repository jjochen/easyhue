//
//  SVProgressHUD+EasyHue.swift
//  EasyHue
//
//  Created by Jochen Pfeiffer on 24.03.16.
//  Copyright © 2016 Jochen Pfeiffer. All rights reserved.
//

import Foundation
import SVProgressHUD

extension SVProgressHUD {
    class func configureForEasyHue() {
        SVProgressHUD.setDefaultMaskType(.clear)
        SVProgressHUD.setDefaultStyle(.dark)
    }
}
