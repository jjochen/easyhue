//
//  BridgeInfoTests.swift
//  EasyHue
//
//  Created by Jochen Pfeiffer on 20.03.16.
//  Copyright © 2016 Jochen Pfeiffer. All rights reserved.
//

import XCTest
import Nimble
@testable import EasyHue

class BridgeInfoTests: XCTestCase {
    
    var bridgeInfo: BridgeInfo!
    let ip = "some_ip"
    let id = "some_id"
    
    override func setUp() {
        super.setUp()
        bridgeInfo = BridgeInfo(id: id, ip: ip)
    }
    
    override func tearDown() {
        self.bridgeInfo = nil
        super.tearDown()
    }
    
    func testBridgeInfo_initialization() {
        expect(self.bridgeInfo.id).to(equal(id))
        expect(self.bridgeInfo.ip).to(equal(ip))
    }
    
    func testBridgeInfo_description() {
        expect(self.bridgeInfo.description).to(equal("Bridge some_id @ some_ip"))
    }
}
