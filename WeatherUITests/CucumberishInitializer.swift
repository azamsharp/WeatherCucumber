//
//  CucumberishInitializer.swift
//  WeatherCucumberUITests
//
//  Created by Kenneth Poon on 5/3/18.
//  Copyright © 2018 Kenneth Poon. All rights reserved.
//

import XCTest
import Foundation
import Cucumberish

class CucumberishInitializer: NSObject {
    
    @objc class func setupCucumberish(){
        before({ _ in
            XCUIApplication().launch()
        })
        
        
        Given("I have a very cool app") { (args, userInfo) -> Void in
            self.waitForElementToAppear(XCUIApplication().textFields["nameTextField"])
        }
        
        When("^I type my name in the name text field") { (args, userInfo) -> Void in
            XCUIApplication().textFields["nameTextField"].tap()
            XCUIApplication().textFields["nameTextField"].typeText("John Doe")
        }
        
        Then("^Then I should see my name displayed in a label") { (args, userInfo) -> Void in
            
            self.waitForElementToAppear(XCUIApplication().otherElements["nameLabel"])
            let nameLabel = XCUIApplication().otherElements["nameLabel"]
            XCTAssertEqual(nameLabel.label, "John Doe")
        }
        
        /*
        Given("I am on Weather Search Screen") { (args, userInfo) -> Void in
            
            self.waitForElementToAppear(XCUIApplication().textFields["nameTextField"])
            //self.waitForElementToAppear(XCUIApplication().otherElements["WeatherSearchView"])
        }
        
        When("^I search for \"([^\\\"]*)\"$") { (args, userInfo) -> Void in
            let searchBar = XCUIApplication().textFields["nameTextField"]
            searchBar.tap()
            let text = (args?[0])!
            searchBar.typeText(text)
        }
        
        Then("^I should see Empty State on results$") { (args, userInfo) -> Void in
            self.waitForElementToAppear(XCUIApplication().otherElements["messageLabel"])
        } */
        
        let bundle = Bundle(for: CucumberishInitializer.self)
        Cucumberish.executeFeatures(inDirectory: "Features", from: bundle, includeTags: nil, excludeTags: nil)
        
    }
    
    
    class func waitForElementToAppear(_ element: XCUIElement){
        let result = element.waitForExistence(timeout: 5)
        guard result else {
            XCTFail("Element does not appear")
            return
        }
    }
    
    
    fileprivate class func getTags() -> [String]? {
        var itemsTags: [String]? = nil
        for i in ProcessInfo.processInfo.arguments {
            if i.hasPrefix("-Tags:") {
                let newItems = i.replacingOccurrences(of: "-Tags:", with: "")
                itemsTags = newItems.components(separatedBy: ",")
            }
        }
        return itemsTags
    } 
    
}
