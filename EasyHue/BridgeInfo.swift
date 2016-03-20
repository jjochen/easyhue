//
//  BridgeInfo.swift
//  EasyHue
//
//  Created by Jochen Pfeiffer on 20.03.16.
//  Copyright © 2016 Jochen Pfeiffer. All rights reserved.
//

import Foundation

public class BridgeInfo {
    
    let id: String
    let ip: String
    
    init(id: String, ip: String) {
        self.id = id
        self.ip = ip
    }
}