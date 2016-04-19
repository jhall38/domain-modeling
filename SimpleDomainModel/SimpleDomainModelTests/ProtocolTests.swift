//
//  ProtocolTests.swift
//  SimpleDomainModel
//
//  Created by Joshua Hall on 4/19/16.
//  Copyright © 2016 Ted Neward. All rights reserved.
//

import XCTest

class ProtocolTests: XCTestCase {
    
    //Test for Mathematical Protocol
    func testMathematicalProtocol(){
        var test1 = Money(amount: 10, currency: "USD")
        var test2 = Money(amount: 50, currency: "USD")
        var test3 = test2.add(test1)
        XCTAssert(test3.amount == 60)
        XCTAssert(test3.currency == "USD")
        test3 = test3.subtract(test1)
        test3 = test3.subtract(test1)
        XCTAssert(test3.amount == 40)
        XCTAssert(test3.currency == "USD")
    }
    
    //Test for Description Protocol
    func testDescriptionPrtocol(){
        var testM = Money(amount: 10, currency: "USD")
        XCTAssert(testM.description == "USD10.0")
        
    }
    
    //Test for Extend Double
    func testExtendDouble(){
        var testM = Money(amount: 10, currency: "USD")
        var testD = 10.0.USD
        XCTAssert(testD.description == testM.description)
    }
    
}