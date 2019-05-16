//
//  UserNameValidationResponse.swift
//
//  Created by ahmed.bahnasy on 1/27/19
//  Copyright (c) . All rights reserved.
//

import Foundation
import ObjectMapper

public class UserNameValidationResponse: Mappable {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let data = "data"
    static let retcode = "retcode"
    static let context = "context"
    static let msg = "msg"
  }

  // MARK: Properties
  public var data: String?
  public var retcode: Int?
  public var context: String?
  public var msg: String?

  // MARK: ObjectMapper Initializers
  /// Map a JSON object to this class using ObjectMapper.
  ///
  /// - parameter map: A mapping from ObjectMapper.
  public required init?(map: Map){

  }

  /// Map a JSON object to this class using ObjectMapper.
  ///
  /// - parameter map: A mapping from ObjectMapper.
  public func mapping(map: Map) {
    data <- map[SerializationKeys.data]
    retcode <- map[SerializationKeys.retcode]
    context <- map[SerializationKeys.context]
    msg <- map[SerializationKeys.msg]
  }

}
