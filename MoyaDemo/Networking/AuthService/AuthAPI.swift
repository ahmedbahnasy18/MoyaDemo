//
//  AuthAPI.swift
//  MoyaDemo
//
//  Created by ahmed.bahnasy on 1/27/19.
//  Copyright © 2019 ahmed.bahnasy. All rights reserved.
//

import UIKit
import Moya
import Moya_ObjectMapper

class AuthAPI: NSObject {
    static private let moyaProvider = MoyaProvider<AuthNetworking>()
    
    static func validateUserName(userName: String, completion:@escaping (_ error: Error?, _ usernameValidationResponse: UserNameValidationResponse?) -> ()) {
        
        self.moyaProvider.request(.validateUserName(userName: userName)) { (result) in
            switch result {
            case .failure(let error):
                completion(error, nil)
            case .success(let moyaResponse):
                let response = try! moyaResponse.mapObject(UserNameValidationResponse.self)
                completion(nil, response)
            }
        }
    }
    
    static func getUserProfileWithoutToken(userId: String, completion:@escaping (_ error: Error?, _ userResponse: UserResponse?) -> ()) {
        self.moyaProvider.request(.profile(userId: userId)) { (result) in
            switch result {
            case .failure(let error):
                completion(error, nil)
            case .success(let moyaResponse):
                let response = try! moyaResponse.mapObject(UserResponse.self)
                completion(nil, response)
            }
        }
    }
}
