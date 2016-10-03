//
//  Country.swift
//  SwiftCountryPicker
//
//  Created by Gregg Luskin on 9/30/16.
//  Copyright © 2016 Gregg Luskin. All rights reserved.
//

import Foundation

public class Country: NSObject {
    
    public let name: String!
    public let code: String!
    public let phoneCode: String!
    
    override public var description: String {
        return "\(name) = \(code) | \(phoneCode)"
    }
    
    init(name: String, code: String, phoneCode: String) {
        self.name = name
        self.code = code
        self.phoneCode = phoneCode
        super.init()
    }
}
