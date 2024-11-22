//
//  String + Extension.swift
//  Countries Info
//
//  Created by Ayokunle Pro on 9/1/24.
//

import Foundation

extension String? {
    static var orNA: String {
        "n/a"
    }
}

extension String {
    func localize() -> Self {
        NSLocalizedString(
            self,
            tableName: "Localizable",
            bundle: .main,
            value: self,
            comment: self
        )
    }
}
