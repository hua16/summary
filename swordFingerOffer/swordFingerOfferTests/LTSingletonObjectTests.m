//
//  LTSingletonObjectTests.m
//  swordFingerOfferTests
//
//  Created by xulihua on 2018/6/24.
//  Copyright © 2018年 huage. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "LTSingletonObject.h"

@interface LTSingletonObjectTests : XCTestCase

@end

@implementation LTSingletonObjectTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testSingletonObjectSame {
    LTSingletonObject *object1 = [LTSingletonObject shareInstance];
    LTSingletonObject *object2 = [LTSingletonObject shareInstance];
    XCTAssertTrue(object1 == object2, @"singleton is error!");
} 

@end
