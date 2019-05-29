//
//  Validation.swift
//  Validations
//
//  Created by ahmed.bahnasy on 5/28/19.
//  Copyright © 2019 Sierra 2. All rights reserved.
//


import Foundation


// MARK:- Enums
enum ValidationType {
    case email
    case password
    case phoneNo
}
enum ValidationResult {
    case success
    case failure(ErrorMessage)
}
enum RegEX: String {
    case email = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}" // Email
    case password = "^.{6,15}$" // Password length 6-15
    case phoneNo = "[0-9]{10,14}" // PhoneNo 10-14 Digits
}
enum ErrorMessage: String {
    case inValidEmail = "InvalidEmail"
    case inValidPhone = "Invalid Phone"
    case inValidPSW = "Invalid Password"
    case empty = "Empty"
    func localized() -> String {
        return NSLocalizedString(self.rawValue, comment: "")
    }
}

class Validation {
    
    // MARK:- Singleton
    public static let shared = Validation()
    private init() {}
    
    //MARK:- Methods
    func validate(values: (type: ValidationType, inputValue: String)...) -> ValidationResult {
        for valueToBeChecked in values {
            switch valueToBeChecked.type {
            case .email:
                if let tempValue = isValidString((valueToBeChecked.inputValue, .email, .empty, .inValidEmail)) {
                    return tempValue
                }
            case .phoneNo:
                if let tempValue = isValidString((valueToBeChecked.inputValue, .phoneNo, .empty, .inValidPhone)) {
                    return tempValue
                }
            case .password:
                if let tempValue = isValidString((valueToBeChecked.inputValue, .password, .empty, .inValidPSW)) {
                    return tempValue
                }
            }
        }
        return .success
    }
    
    func isValidString(_ input: (text: String, regex: RegEX, emptyMessage: ErrorMessage, invalidMessage: ErrorMessage)) -> ValidationResult? {
        if input.text.isEmpty {
            return .failure(input.emptyMessage)
        } else if isValidRegEx(input.text, input.regex) != true {
            return .failure(input.invalidMessage)
        }
        return nil
    }
    
    func isValidRegEx(_ testStr: String, _ regex: RegEX) -> Bool {
        let stringTest = NSPredicate(format:"SELF MATCHES %@", regex.rawValue)
        let result = stringTest.evaluate(with: testStr)
        return result
    }
}
