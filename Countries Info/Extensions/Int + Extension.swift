//
//  Int + Extension.swift
//  Countries Info
//
//  Created by Ayokunle Fatokimi on 22/08/2024.
//

import Foundation

extension Int {
    
    // MARK: Real Numbers
    static var one: Int {
        return 1 as Int
    }
    
    static var two: Int {
        return 2 as Int
    }
    
    // Comma Delimiter Method
    func addCommaDelimiter() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.groupingSeparator = ","
        return numberFormatter.string(from: .init(value: self)) ?? "\(self)"
    }
    
}

extension UInt {
    
    static var image200: UInt {
        return 200 as UInt
    }
}
