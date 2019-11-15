//
//  Structs.swift
//  AVSoft_TestTask
//
//  Created by Tianid on 13.11.2019.
//  Copyright © 2019 Tianid. All rights reserved.
//

import Foundation


struct PrimaryAttributes: Codable {
    var name: String
    var secondName: String
    var lastName: String
}


struct SecondaryAttributes: Codable {
    var attributeName: String
    var attributeValue: String
}
