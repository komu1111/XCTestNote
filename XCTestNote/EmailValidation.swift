//
//  EmailValidation.swift
//  XCTestNote
//
//  Created by Shohei Komura on 2017/05/04.
//  Copyright © 2017年 Shohei Komura. All rights reserved.
//

import Foundation

protocol Validator {
    associatedtype Validation
    
    func validate(validate: Validation) -> Bool
}


struct EmailValidation: Validator {
    typealias Validation = String
    
    func validate(validate: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return predicate.evaluate(with: validate)
    }
}

