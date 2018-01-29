//
//  XuSqliteSingleton.swift
//  YMSJ
//
//  Created by  abcxdx@sina.com on 2017/12/21.
//  Copyright © 2017年 xdxbus@sina.com. All rights reserved.
//

import FMDB
import Whisper

class XuSqliteSingleton {
    
    static let sqliteSingleton = XuSqliteSingleton()
    var dataBase:FMDatabase? = nil
    
    private init() {
        dataBase = FMDatabase(path: databasePath(path: ""))
        if !(dataBase?.open())! {
            
            let murur = Murmur(title: "数据库打开失败")
            Whisper.show(whistle: murur)
            Whisper.hide(whistleAfter: messageShowTime)
        }
    }
    
    func databasePath(path:String) -> String? {
        
        var docDir = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last
        
        path.isEmpty ? docDir?.append("/database") : docDir?.append(contentsOf: path)
        
        if var dir = docDir {
            if !checkDirExists(dirPath: dir) { return nil }
            dir.append("/main_database.sqlite")
            if !checkFileExists(filePath: dir) { return nil }
            print(dir)
            return dir
            
        } else {
            let murmur = Murmur(title: "主数据库创建失败，请退出应用重试")
            Whisper.show(whistle: murmur)
            Whisper.hide(whistleAfter: TimeInterval(messageShowTime))
        }
        
        return nil
    }
    
    func checkFileExists(filePath:String) -> Bool {
        let fileManager = FileManager.default
        guard fileManager.fileExists(atPath: filePath) else {
            fileManager.createFile(atPath: filePath, contents: nil, attributes: nil)
            return true
        }
        return true
    }
    
    func checkDirExists(dirPath:String) -> Bool {
        
        let fileManager = FileManager.default
        var dictory = ObjCBool(true)
        
        if !(fileManager.fileExists(atPath: dirPath, isDirectory: &dictory)) {
            do {
                try fileManager.createDirectory(atPath: dirPath, withIntermediateDirectories: true, attributes: nil)
            }catch let error as NSError {
                print(error.domain)
                return false
            }
        }
        
        return true
    }
}

