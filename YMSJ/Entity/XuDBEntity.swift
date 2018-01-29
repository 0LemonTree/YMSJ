//
//  XuDBEntity.swift
//  YMSJ
//
//  Created by  abcxdx@sina.com on 2018/1/10.
//  Copyright © 2018年 xdxbus@sina.com. All rights reserved.
//

import UIKit
import Whisper

class XuDBEntity: XuEntity {
    
    var foreignKey:[String]?      // foreign key
    
     init(foreignKey:[String]) {
        super.init()
        self.foreignKey = foreignKey
        createTable()
    }
    
    override init() {
        super.init()
        createTable()
    }
    
    func deleteData(deleteSql:String) -> Bool {
        return true
    }
    
    func insertData(insertSql:String) -> Bool {
        return true
    }
    
    func searchData(searchSql:String) -> [String] {
        return []
    }
    
    func createTable() {
        
        let mirror      = Mirror.init(reflecting: self)
        
        // 基类，无需创建表
        if (mirror.children.count == 1) && (mirror.children.first?.label?.elementsEqual("foreignKey"))! {
            return
        }
        
        let superMirror = Mirror.init(reflecting: self).superclassMirror
        
        var createTablestr    = "CREATE TABLE IF NOT EXISTS \(self.classForCoder)("
        var colsNamesAndTypes = sqlPropertiesStr(mirror: mirror)
        
        colsNamesAndTypes.append(sqlPropertiesStr(mirror: superMirror))
        
        createTablestr.append(colsNamesAndTypes)
        createTablestr.append(")")
        do {
       try XuSqliteSingleton.sqliteSingleton.dataBase?.executeUpdate(createTablestr, values: nil)
        } catch {
            let murur = Murmur(title: "\(self.classForCoder): 数据库创建失败, \(error.localizedDescription)")
            Whisper.show(whistle: murur)
            
            if xu_debug { print(error) }
        }
    }
    
    func sqlPropertiesStr(mirror:Mirror?) -> String {
        var colsNamesAndTypes = ""
        
        if let localMirror = mirror {
             for (index, element) in localMirror.children.enumerated() {
                let propertyMirror = Mirror.init(reflecting: element.value)
                let propertyType = convertToSqliteType(type: propertyMirror.subjectType)
                                
                if (element.label?.contains("id"))! {
                     colsNamesAndTypes.append("\(element.label!) \(XuSqlTypes.sqlInteger.rawValue) PRIMARY KEY AUTOINCREMENT")
                    
                } else if (element.label?.elementsEqual("foreignKey"))! {
                    if let fk = foreignKey {
                         colsNamesAndTypes.append("FOREIGN KEY \(fk[1]) REFERENCES \(fk[0])\(fk[1])")
                    }
                   
                } else {
                    colsNamesAndTypes.append("\(element.label!) \(propertyType)")
                }
                
                if index != (localMirror.children.count-1) {
                    colsNamesAndTypes.append(",")
                }
            }
        }
        
        return colsNamesAndTypes
    }
    
    func getForeignKey(type:NSObject, pkName:String) -> [String] {
        let foreignKeyArr = ["\(type.classForCoder)", pkName]
        
        return foreignKeyArr
    }
    
    func convertToSqliteType(type:Any.Type) -> String {
        
        switch type{
        case  is String.Type, is String?.Type:
            return XuSqlTypes.sqlText.rawValue
        case is Int.Type ,is Int?.Type , is UInt.Type , is UInt?.Type,is Bool.Type, is Bool?.Type:
            return XuSqlTypes.sqlInteger.rawValue
        case is Double.Type, is Double?.Type, is Float.Type, is Float?.Type:
            return XuSqlTypes.sqlRreal.rawValue
        default:
            return XuSqlTypes.sqlBlob.rawValue
        }
    }
}
