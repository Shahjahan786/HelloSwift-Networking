//
//  AccessToken.swift
//  HelloSwift
//
//  Created by Shahjahan Samon on 08/08/2019.
//  Copyright © 2019 Shahjahan Samon. All rights reserved.
//

import Foundation

class AccessToken : Codable, CustomStringConvertible{
    
    
    var accessToken: String = ""
    var refreshToken: String = ""
    var tokenType: String = ""
    var expiresIn: Int = 0
    var scope: String = ""
    var user: String = ""
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
        case tokenType = "token_type"
        case expiresIn = "expires_in"
        case scope
        case user
    }

}

extension CustomStringConvertible{
    
    var description: String {
        let name = type(of: self);
        var desc = "\(name) {\n";
        let selfMirror = Mirror(reflecting: self);
        
        for child in selfMirror.children {
            if let key = child.label {
                desc += "\t\(key): \(child.value),\n"
            }
        }
        
        desc += "\n}";
        
        return desc;
      
    }
    
}

