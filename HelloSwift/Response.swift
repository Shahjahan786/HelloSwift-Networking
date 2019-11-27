//
//  Response.swift
//  HelloSwift
//
//  Created by Shahjahan Samon on 08/08/2019.
//  Copyright © 2019 Shahjahan Samon. All rights reserved.
//

import Foundation

class Response<T : Codable>  : Codable, CustomStringConvertible {
    var status: String = ""
    var message: String  = ""
    var data: T? = nil
    var error: ApiError? = nil
}
