//
//  Barcode.swift
//  SwiftGS1Barcode
//
//  Created by Toni Hoffmann on 26.06.17.
//  Copyright © 2017 Toni Hoffmann. All rights reserved.
//

import Foundation

protocol Barcode {
    /* *********** Properties *********** */
    var raw: String? {get set}
    
    /* *********** Initializers *********** */
    init()
    init(raw: String)
    
    /* *********** Functions *********** */
    func validate() throws -> Bool
    func parse() throws
}
