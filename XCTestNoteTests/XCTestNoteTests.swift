//
//  XCTestNoteTests.swift
//  XCTestNoteTests
//
//  Created by Shohei Komura on 2017/05/04.
//  Copyright © 2017年 Shohei Komura. All rights reserved.
//

import XCTest
@testable import XCTestNote

class XCTestNoteTests: XCTestCase {
    
    let emailValidation = EmailValidation()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testEmailValidate() {
        print("正しい形式----------------")
        let firstEmail = "aaa@gmail.com"
        XCTAssertTrue(emailValidation.validate(validate: firstEmail))
        
//        print("間違った形式1----------------")
//        let secondEmail = "aaa@gmailcom"
//        XCTAssertTrue(emailValidation.validate(validate: secondEmail))
//        
//        print("間違った形式2----------------")
//
//        let thirdEmail = "aaa_gmail.com"
//        XCTAssertTrue(emailValidation.validate(validate: thirdEmail))
    }
    
    // HTTPリクエストの非同期テスト
    func testHTTPGetRequest() {
        let urlStr = "https://www.google.co.jp/"
        let url = URL(string: urlStr)
        //失敗時のエラーメッセージとしてdescriptionが表示される
        let expection = expectation(description: "GET \(String(describing: url))")
        
        let session = URLSession.shared
        let task = session.dataTask(with: url!) { data, response, error in
            XCTAssertNotNil(data, "data should not be nil")
            XCTAssertNil(error, "error should be nil")
            
            if let response = response as? HTTPURLResponse {
                XCTAssertEqual(response.statusCode, 200, "HTTP response status code should be 200")
            } else {
                XCTFail("Response was not NSHTTPURLResponse")
            }
            
            expection.fulfill() //fulfillが呼ばれないとタイムアウトされたとみなされ、指定した時間を超えるとテスト失敗
        }
        task.resume()
        
        waitForExpectations(timeout: 1, handler: { error in
            // テスト終了、タイムアウト時に必ず呼ばれる
            if let error = error {
                print("error: \(error)")
            }
            task.cancel()
        })
    }
    
    func testPerformanceMatrix() {
        measureMetrics(type(of: self).defaultPerformanceMetrics(), automaticallyStartMeasuring: false) {
            self.startMeasuring()
            // stopMeasuringが実行されるまでのパフォーマンスを計測する
            self.stopMeasuring()
        }
    
    }
}

