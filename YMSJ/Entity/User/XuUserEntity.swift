//
//  XuUserEntity.swift
//  YMSJ
//
//  Created by  abcxdx@sina.com on 2018/1/20.
//  Copyright © 2018年 xdxbus@sina.com. All rights reserved.
//

import UIKit

enum XuUserType {
    case NormalUser
    case AdministratorUser
    case BusinessUser
}

class XuUserEntity: XuDBEntity {
    
    let user_id = 0
    var user_name:String?
    var pass_word:String?
    var user_type:XuUserType = .NormalUser
}
