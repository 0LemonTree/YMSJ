//
//  XuSqliteSingletonUniteTest.swift
//  YMSJTests
//
//  Created by  abcxdx@sina.com on 2017/12/21.
//  Copyright © 2017年 xdxbus@sina.com. All rights reserved.
//

import XCTest
@testable import YMSJ

class XuSqliteSingletonUniteTest: XCTestCase {
    
    let sqlitesingleton = XuSqliteSingleton.sqliteSingleton
    
    override func setUp() {
        super.setUp()
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testCreateDBSuccess() {
        
        let filePath = sqlitesingleton.databasePath(path: "")
        
        XCTAssertTrue(sqlitesingleton.checkFileExists(filePath: filePath!), "数据库文件创建失败")
        XCTAssertNotNil(sqlitesingleton.dataBase, "database 创建失败")
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
