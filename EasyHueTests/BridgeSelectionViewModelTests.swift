//
//  EasyHueTests.swift
//  EasyHueTests
//
//  Created by Jochen Pfeiffer on 23.02.16.
//  Copyright © 2016 Jochen Pfeiffer. All rights reserved.
//

import XCTest
import RxSwift
import RxCocoa
import Nimble
import SwiftyHue
@testable import EasyHue


class BridgeSelectionViewModelTests: XCTestCase {
    
    var viewModel: BridgeSelectionViewModel!
    var disposeBag: DisposeBag!
    
    
    override func setUp() {
        super.setUp()
        
        self.viewModel = BridgeSelectionViewModel(bridgeFinder: BridgeFinderStub())
        self.disposeBag = DisposeBag()
    }
    
    override func tearDown() {
        self.viewModel = nil
        super.tearDown()
    }
    
    func testAvailableBridges_returnsMockedBridges() {
        
        var bridges: [HueBridge]! = []
        self.viewModel.availableBridges.driveNext { result in
            bridges = result
        }.addDisposableTo(disposeBag)
        
        expect(bridges).toEventually(contain(bridgeMock1))
        expect(bridges).toEventually(contain(bridgeMock2))
    }
    
    func testLoading_returnsTrueWhileLoading() {
        
        var result = false
        self.viewModel.availableBridges.driveNext{_ in }.addDisposableTo(disposeBag)
        self.viewModel.loading.driveNext { loading in
            result = loading
        }.addDisposableTo(disposeBag)
        
        expect(result).to(beTrue())
        expect(result).toEventually(beFalse())
    }
}


private class  BridgeFinderStub: BridgeFinderType {
    func rx.bridges() -> Observable<[BridgeInfo]> {
        return Observable.create { observer in
            let queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
            let delay = dispatch_time(DISPATCH_TIME_NOW, Int64(0.1 * Double(NSEC_PER_SEC)))
            dispatch_after(delay, queue, {
                observer.on(.Next([bridgeMock1, bridgeMock2]))
                observer.on(.Completed)
            })
            return NopDisposable.instance
        }
    }
}
