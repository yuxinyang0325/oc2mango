//
//  StatementTest.swift
//  oc2mangoLibTests
//
//  Created by Jiang on 2019/4/24.
//  Copyright © 2019年 SilverFruity. All rights reserved.
//

import XCTest

class StatementTest: XCTestCase {
    let ocparser = Parser.shared()!
    override func setUp() {
        
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    func testMethodCall() {
        let source =
"""
@implementation Demo
- (Demo *)objectMethods{
    [[NSObject new] test];
    [[self.x method].y method1];
    [[object setValue:self forKey:@"name"] test:@"string"];
    [[object valueForKey:@"key"] object];
    [object setCallBack:^(NSString *name){

    }];
}
@end
"""
        ocparser.parseSource(source)
        XCTAssert(ocparser.classImps.count > 0);
        let classImp : ClassImplementation  = ocparser.classImps!.firstObject as! ClassImplementation
        let methodImp : MethodImplementation = classImp.methodImps!.firstObject as! MethodImplementation
        let funcImp : FunctionImp = methodImp.imp;
        XCTAssert(funcImp.expressions.count == 5);
        print(funcImp.expressions);
    }
    func testIfStatement(){
        let source =
"""
@implementation Demo
- (Demo *)objectMethod{
    if (x >= 0){
        [[self.x method].y method];
    }
    
}
@end
"""
        ocparser.parseSource(source)
    }
    func testDoWhileStatement(){
        let source =
"""
@implementation Demo
- (Demo *)objectMethod{
    do{
        
    }while(x > 0 && x < 0)
}
@end
"""
        ocparser.parseSource(source)
    }
}
