//
//  BridgeSelectionViewModelSpecs.swift
//  EasyHue
//
//  Created by Jochen Pfeiffer on 27.03.16.
//  Copyright © 2016 Jochen Pfeiffer. All rights reserved.
//

import Quick
import RxSwift
import Nimble
import RxBlocking
import RxTests
@testable import EasyHue


class BridgeSelectionViewModelSpec: QuickSpec {
    
    override func spec() {
        describe("bridge selection view model") {
            var viewModel: BridgeSelectionViewModel!
            var disposeBag: DisposeBag!
            beforeEach {
                let hueSDK = PHHueSDKStub()
                let bridgeSearch = PHBridgeSearchingStub()
                viewModel = BridgeSelectionViewModel(hueSDK: hueSDK, bridgeSearch: bridgeSearch)
                disposeBag = DisposeBag()
            }
            
            afterEach {
                viewModel = nil
            }
            
            context("available bridges") {
                it("") {
                    
                    var bridges: [BridgeInfo]!
                    viewModel.availableBridges.driveNext { result in
                        bridges = result
                    }
                    .addDisposableTo(disposeBag)
                    
                    expect(bridges).toEventually(contain(bridgeMock1))
                    expect(bridges).toEventually(contain(bridgeMock2))
                }
            }
            
            context("invalid credentials") {
                
                beforeEach {
                   
                }
                it("disables login") {
//                    expect(try! viewModel.loginEnabled.toBlocking().first()).toEventually(equal(false))
                }
            }
        }
    }
}