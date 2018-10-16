//
//  Constants.swift
//  Kappa
//
//  Created by Nima on 10/15/17.
//  Copyright © 2017 Nima. All rights reserved.
//

import Foundation


struct CellID{
    static let SLIDE_SHOW = "C0"
    static let HOME = "C1"
}

class CardName{
    
    static let names = ["Blue_Back", "Blue_Top", "Red_Top", "Red_Back", "Green_Top", "Green_Back", "Grey_Top", "Grey_Back"]
    
    static var random: String{
        get{
            return names[Int(arc4random_uniform(UInt32(names.count)))]
        }
    }
}
