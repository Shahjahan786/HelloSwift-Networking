//
//  ApiError.swift
//  HelloSwift
//
//  Created by Shahjahan Samon on 08/08/2019.
//  Copyright © 2019 Shahjahan Samon. All rights reserved.
//

import Foundation
class ApiError : Error, Codable, CustomStringConvertible{
    var path :String = "";
    var error :String = "";
    var message :String = "";
    var timestamp :String = "";
 
}
