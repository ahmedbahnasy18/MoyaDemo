//
//  AuthProvider.swift
//  MoyaDemo
//
//  Created by ahmed.bahnasy on 1/27/19.
//  Copyright © 2019 ahmed.bahnasy. All rights reserved.
//

import UIKit

class AuthProvider {
    // MARK:- Singleton
    private init() {}
    static let shared = AuthProvider()

    
    func validateUserName(username: String, completion:@escaping (_ error: Error?, _ UsernameValidationResponse: UserNameValidationResponse?) -> ()) {
        AuthAPI.validateUserName(userName: username) { (error, response) in
            if let error = error {
                completion(error, nil)
            } else if let response = response{
                completion(nil, response)
            }
        }
    }

    func getUserProfileWithoutToken(userId: String, completion:@escaping (_ error: Error?, _ userResponse: UserResponse?) -> ()) {
        AuthAPI.getUserProfileWithoutToken(userId: userId) { (error, response) in
            if let error = error {
                completion(error, nil)
            } else if let response = response {
                completion(nil, response)
            }
        }
    }
}
