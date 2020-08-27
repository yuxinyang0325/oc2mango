//
//  ArchiveTests.swift
//  oc2mangoLibTests
//
//  Created by Jiang on 2020/8/27.
//  Copyright © 2020 SilverFruity. All rights reserved.
//

import XCTest

class ArchiveTests: XCTestCase {
    let ocparser = Parser.shared()
    let convert = Convert()
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    func loadFileData(traget: AnyClass, filename: String)->Data?{
        let bundle = Bundle.init(for: traget)
        let path = bundle.path(forResource: filename, ofType: nil)
        let data = try? Data.init(contentsOf:URL.init(fileURLWithPath: path!))
        return data
    }
    func testArchive(){
        let sourceData = loadFileData(traget: ArchiveTests.classForCoder(), filename: "TestSource.imp")
        let source = String.init(data: sourceData ?? Data.init(), encoding: .utf8)
        let ast = ocparser.parseSource(source)
        var result = ""
        for node in ast.nodes {
            result.append(convert.convert(node))
        }
        let resultData = loadFileData(traget: FileTest.classForCoder(), filename: "ConvertOuput.txt")
        var resultStr = String.init(data: resultData ?? Data.init(), encoding: .utf8)!
        resultStr = resultStr.replacingOccurrences(of: ";", with: "")
        result = result.replacingOccurrences(of: ";", with: "")
        XCTAssert(result == resultStr,"\n"+result)
    }
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    
    
}
