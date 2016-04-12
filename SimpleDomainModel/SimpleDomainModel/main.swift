//
//  main.swift
//  SimpleDomainModel
//
//  Created by Ted Neward on 4/6/16.
//  Copyright © 2016 Ted Neward. All rights reserved.
//

import Foundation

print("Hello, World!")

public func testMe() -> String {
  return "I have been tested"
}

public class TestMe {
  public func Please() -> String {
    return "I have been tested"
  }
}

////////////////////////////////////
// Money
//
public struct Money {
  public var amount : Int
  public var currency : String
  
  public func convert(to: String) -> Money {
    //1 USD = .5 GBP (2 USD = 1 GBP) 1 USD = 1.5 EUR (2 USD = 3 EUR) 1 USD = 1.25 CAN (4 USD = 5 CAN)
    switch(to){
        case "USD":
        switch(currency){
            case "USD":
                return self
            case "GBP":
                return Money(amount: Int(Double(amount)*2), currency: "USD")
            case "EUR":
                return Money(amount: Int(Double(amount)*2/3), currency: "USD")
            case "CAN":
                return Money(amount: Int(Double(amount)*4/5), currency: "USD")
            default:
                print("Invalid currency")
        }
        
        case "GBP":
            switch(currency){
            case "USD":
                return Money(amount: Int(Double(amount)*1/2), currency: "GBP")
            case "GBP":
                return self
            case "EUR":
                return Money(amount: Int(Double(amount)*1/3), currency: "GBP")
        case "CAN":
                return Money(amount: Int(Double(amount)*2/5), currency: "GBP")
        default:
            print("Invalid currency")
        }
        
        case "EUR":
        switch(currency){
        case "USD":
            return Money(amount: Int(Double(amount)*3/2), currency: "EUR")
        case "GBP":
            return Money(amount: Int(Double(amount)*3), currency: "EUR")
        case "EUR":
            return self
        case "CAN":
            return Money(amount: Int(Double(amount)*6/5), currency: "EUR")
        default:
            print("Invalid currency")
        }
        
        case "CAN":
        switch(currency){
            case "USD":
                return Money(amount: Int(Double(amount)*5/4), currency: "CAN")
            case "GBP":
                return Money(amount: Int(Double(amount)*5/2), currency: "CAN")
            case "EUR":
                return Money(amount: Int(Double(amount)*5/6), currency: "CAN")
            case "CAN":
                return self
            default:
                print("Invalid currency")
        }
        
        default:
            print("Invalid currency")
    }
    return self //invalid currency
  }
  
  public func add(to: Money) -> Money {
    return Money(amount: convert(to.currency).amount + to.amount, currency: to.currency)
  }
  public func subtract(from: Money) -> Money {
    return Money(amount: convert(from.currency).amount + from.amount, currency: from.currency)
  }
}

////////////////////////////////////
// Job
//
public class Job {
  public var title : String
  public var type : JobType
    
  public enum JobType {
    case Hourly(Double)
    case Salary(Int)
  }
  
  public init(title : String, type : JobType) {
    self.title = title
    self.type = type
  }
  
  public func calculateIncome(hours: Int) -> Int {
    switch(type){
        case .Salary(let sal):
            return sal
        case .Hourly(let wage):
            return Int(wage * Double(hours))
    }
  }
  
  public func raise(amt : Double) {
    switch(type){
        case .Salary(let sal):
            type = JobType.Salary(sal+Int(amt))
        case .Hourly(let wage):
            type = JobType.Hourly(wage+amt)
    }
  }
}

////////////////////////////////////
// Person
//
public class Person {
  public var firstName : String = ""
  public var lastName : String = ""
  public var age : Int = 0
  public var jobTitle : String = ""
  public var jobType : Job.JobType = .Salary(0)
  public var theSpouse : Person? //the actual person that is stored that property invokes

  public var job : Job? {
    get {
        if(jobTitle == ""){
            return nil
        }
        else{
            return Job(title: jobTitle, type: jobType)
        }
    }
    
    set(value) {
        if(age >= 16){ //won't set a job if too young
            jobTitle = (value?.title)!
            jobType = (value?.type)!
        }
    }
  }
  
  public var spouse : Person? {
    get {
        return theSpouse
    }
    set(value) {
        if(age >= 18){ //won't work if person is too young
            theSpouse = value!
        }
    }
  }
  
  public init(firstName : String, lastName: String, age : Int) {
    self.firstName = firstName
    self.lastName = lastName
    self.age = age
  }
  
  public func toString() -> String {
    return "[Person: firstName:\(firstName) lastName:\(lastName) age:\(age) job:\(job?.title) spouse:\(spouse?.firstName)]"
  }
}

////////////////////////////////////
// Family
//
public class Family {
  private var members : [Person] = []

  public init(spouse1: Person, spouse2: Person) {
    if(spouse1.spouse == nil && spouse2.spouse == nil){
        spouse1.spouse = spouse2
        spouse2.spouse = spouse1
        members.append(spouse1)
        members.append(spouse2)
    }
    else{
        print("One of them already has a spouse!")
    }
  }
  
  public func haveChild(child: Person) -> Bool {
    for member in members{
        if(member.age >= 21){ //if old enough to have a child
            members.append(child)
            return true
        }
    }
    return false
  }
  
  public func householdIncome() -> Int {
    var sum : Int = 0
    for member in members{
        if(member.job != nil){
            sum += (member.job?.calculateIncome(2000))! //Assuming hourly workers are working full time (approx 2000 hours a year)
        }
    }
    return sum
  }
}





