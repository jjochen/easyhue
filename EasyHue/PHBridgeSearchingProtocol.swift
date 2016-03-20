//
//  PHBridgeSearchingProtocol.swift
//  EasyHue
//
//  Created by Jochen Pfeiffer on 20.03.16.
//  Copyright © 2016 Jochen Pfeiffer. All rights reserved.
//

import Foundation
import RxSwift

protocol PHBridgeSearchingProtocol {
    func rx_startSearch() -> Observable<[BridgeInfo]>
}