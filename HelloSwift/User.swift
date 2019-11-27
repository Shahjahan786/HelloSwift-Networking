//
//  User.swift
//  HelloSwift
//
//  Created by Shahjahan Samon on 08/08/2019.
//  Copyright © 2019 Shahjahan Samon. All rights reserved.
//

import Foundation
class User : Codable, CustomStringConvertible{
    
    var username: String = ""
    var name: String = ""
    var enabled = false
    var accountNonExpired = false
    var accountNonLocked = false
    var credentialsNonExpired = false
  
}
