//
//  Validator.swift
//  MoyaDemo
//
//  Created by ahmed.bahnasy on 5/28/19.
//  Copyright © 2019 ahmed.bahnasy. All rights reserved.
//

import Foundation

class ValidationError: Error {
    var message: String
    
    init(_ message: String) {
        self.message = message
    }
}

protocol ValidatorConvertible {
    func validated(_ value: String) throws -> String
}


enum ValidatorType {
    case email
    case password
    case requiredField(field: String)
}

enum VaildatorFactory {
    static func validatorFor(type: ValidatorType) -> ValidatorConvertible {
        switch type {
        case .requiredField(let fieldName): return RequiredFieldValidator(fieldName)
        case .email: return EmailValidator()
        case .password: return PasswordValidator()
        }
    }
}

enum RegEx: String {
    case email = "^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}$" // Email
    case password = "^.{6,15}$" // Password length 6-15
    //Change RegEx according to your Requirement
}

enum ErrorMessages: String {
    case inValidEmail = "Invalid email. Please try again."
    case inValidPSW = "Invalid password. Please try again."
}

struct RequiredFieldValidator: ValidatorConvertible {
    private let fieldName: String
    
    init(_ field: String) {
        fieldName = field
    }
    
    func validated(_ value: String) throws -> String {
        guard !value.isEmpty else {
            throw ValidationError("Required field " + fieldName)
        }
        return value
    }
}

struct EmailValidator: ValidatorConvertible {
    func validated(_ value: String) throws -> String {
        do {
            if try NSRegularExpression(pattern: RegEx.email.rawValue, options: .caseInsensitive).firstMatch(in: value, options: [], range: NSRange(location: 0, length: value.count)) == nil {
                throw ValidationError(ErrorMessages.inValidEmail.rawValue)
            }
        } catch {
            throw ValidationError(ErrorMessages.inValidEmail.rawValue)
        }
        return value
    }
}

struct PasswordValidator: ValidatorConvertible {
    func validated(_ value: String) throws -> String {
        guard value != "" else {throw ValidationError("Password is Required")}
        guard value.count >= 6 else { throw ValidationError("Password must have at least 6 characters") }
        
        do {
            if try NSRegularExpression(pattern: "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{6,}$",  options: .caseInsensitive).firstMatch(in: value, options: [], range: NSRange(location: 0, length: value.count)) == nil {
                throw ValidationError("Password must be more than 6 characters, with at least one character and one numeric character")
            }
        } catch {
            throw ValidationError("Password must be more than 6 characters, with at least one character and one numeric character")
        }
        return value
    }
}

