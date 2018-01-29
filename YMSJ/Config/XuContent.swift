//
//  XuContent.swift
//  YMSJ
//
//  Created by  abcxdx@sina.com on 2017/12/5.
//  Copyright © 2017年 xdxbus@sina.com. All rights reserved.
//

import UIKit
import FMDB
import SnapKit
import Whisper

/*
 * sqlite 5 种数据类型
 */
enum XuSqlTypes:String {
    case sqlText     = "TEXT"
    case sqlInteger = "INTEGER"
    case sqlRreal    = "REAL"
    case sqlBlob     = "BLOB"
    case sqlNull     = "NULL"
}

enum XuErrorCode:Error {
    case UserNameError       // 用户名错误
    case PassWordError       // 密码错误
    case CanNotFindDataBase  // 数据库未发现
}

let xu_debug = true
let messageShowTime = 3.0

let xu_main_bgColor = UIColor(red: 208/255.0, green: 210/255.0, blue: 220/255.0, alpha: 1)
let xu_main_color = UIColor.blue
//class XuContent {}


