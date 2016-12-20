//
//  TestHelpers.swift
//  EasyHue
//
//  Created by Jochen Pfeiffer on 27.03.16.
//  Copyright © 2016 Jochen Pfeiffer. All rights reserved.
//

import Foundation
import Quick
import Nimble
import RxBlocking
import RxSwift
import SwiftyHue
@testable import EasyHue


let bridgeMock1 = HueBridge(ip: "ip_1", deviceType: "deviceType_1", friendlyName: "friendlyName_1", modelDescription: "modelDescription_1", modelName: "modelName_1", serialNumber: "serialNumber_1", UDN: "UDN_1", icons: []);
let bridgeMock2 = HueBridge(ip: "ip_2", deviceType: "deviceType_2", friendlyName: "friendlyName_2", modelDescription: "modelDescription_2", modelName: "modelName_2", serialNumber: "serialNumber_2", UDN: "UDN_2", icons: []);


// This is handy so we can write expect(o) == 1 instead of expect(o.value) == 1 or whatever.
public func equalFirst<T: Equatable>(_ expectedValue: T?) -> MatcherFunc<Observable<T>> {
    return MatcherFunc { actualExpression, failureMessage in
        
        failureMessage.postfixMessage = "equal <\(expectedValue)>"
        let actualValue = try actualExpression.evaluate()?.toBlocking().first()
        
        let matches = actualValue == expectedValue
        return matches
    }
}

public func equalFirst<T: Equatable>(_ expectedValue: T?) -> MatcherFunc<Variable<T>> {
    return MatcherFunc { actualExpression, failureMessage in
        
        failureMessage.postfixMessage = "equal <\(expectedValue)>"
        let actualValue = try actualExpression.evaluate()?.value
        
        let matches = actualValue == expectedValue && expectedValue != nil
        return matches
    }
}

public func equalFirst<T: Equatable>(_ expectedValue: T?) -> MatcherFunc<Observable<Optional<T>>> {
    return MatcherFunc { actualExpression, failureMessage in
        
        failureMessage.postfixMessage = "equal <\(expectedValue)>"
        let actualValue = try actualExpression.evaluate()?.toBlocking().first()
        
        switch actualValue {
        case .none:
            return expectedValue == nil
        case .some(let wrapped):
            return wrapped == expectedValue
        }
    }
}

public func equalFirst<T: Equatable>(_ expectedValue: T?) -> MatcherFunc<Variable<Optional<T>>> {
    return MatcherFunc { actualExpression, failureMessage in
        
        failureMessage.postfixMessage = "equal <\(expectedValue)>"
        let actualValue = try actualExpression.evaluate()?.value
        
        switch actualValue {
        case .none:
            return expectedValue == nil
        case .some(let wrapped):
            return wrapped == expectedValue
        }
    }
}

public func ==<T: Equatable>(lhs: Expectation<Observable<T>>, rhs: T?) {
    lhs.to(equalFirst(rhs))
}

public func ==<T: Equatable>(lhs: Expectation<Variable<T>>, rhs: T?) {
    lhs.to(equalFirst(rhs))
}

public func ==<T: Equatable>(lhs: Expectation<Observable<Optional<T>>>, rhs: T?) {
    lhs.to(equalFirst(rhs))
}

public func ==<T: Equatable>(lhs: Expectation<Variable<Optional<T>>>, rhs: T?) {
    lhs.to(equalFirst(rhs))
}

