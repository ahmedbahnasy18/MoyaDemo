//
//  AuthNetworking.swift
//  MoyaDemo
//
//  Created by ahmed.bahnasy on 1/27/19.
//  Copyright © 2019 ahmed.bahnasy. All rights reserved.
//

import Foundation
import Moya

enum AuthNetworking {
    case validateUserName(userName: String)
    case profile(userId: String)
}

extension AuthNetworking: TargetType {
    var baseURL: URL {
        switch self {
        case .validateUserName(_):
            return URL(string: URls.validateUsername)!
        case .profile(_):
            return URL(string: URls.user)!
        }
    }
    
    var path: String {
        switch self {
        case .validateUserName(_):
           return "/validate_username"
        case .profile(let userId):
            return "/profile/\(userId)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .validateUserName(_):
            return .get
        case .profile(_):
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .validateUserName(let userName):
            return .requestParameters(parameters: ["name": userName], encoding: URLEncoding.queryString)
        case .profile(_):
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .validateUserName(_):
            return nil
        case .profile(_):
            return ["Content-Type": "application/json"]
        }
    }
    
    
}
