//
//  Persone.swift
//  AVSoft_TestTask
//
//  Created by Tianid on 13.11.2019.
//  Copyright © 2019 Tianid. All rights reserved.
//

import Foundation


class Persone: Codable {
    
    var primaryAttributes: PrimaryAttributes
    var secondaryAttributes: [SecondaryAttributes]? = []
    
    
    init(name: String, secondName: String, lastName: String) {
        primaryAttributes = PrimaryAttributes(name: name, secondName: secondName, lastName: lastName )
    }
    
}
