//
//  MyCodeTests.m
//  MyCodeTests
//
//  Created by mac on 2019/6/13.
//  Copyright © 2019 mycode. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MethodsClassObjc.h"


@interface MyCodeTests : XCTestCase

@end

@implementation MyCodeTests

- (void)setUp {
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testExample {
    [self testFunction];
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}


-(void)testFunction{
    
    NSString *str = [MethodsClassObjc replaceEmptyStr:@"aaa"];
//    XCTAssert(@"",str,@"替换空")
}



- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
