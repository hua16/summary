//
//  03_01_FindDuplicationTests.m
//  swordFingerOfferTests
//
//  Created by xulihua on 2018/6/24.
//  Copyright © 2018年 huage. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "FindDuplication.h"

@interface _3_01_FindDuplicationTests : XCTestCase

@end

@implementation _3_01_FindDuplicationTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)test1 {
    NSArray *numbers = @[@2, @1, @3, @1, @4];
    NSArray *duplications = @[@1];
    [self judugeTestName:@"test1" numbers:numbers expected:duplications validArgument:YES];
}


- (void)test2 {
    NSArray *numbers = @[@2, @4, @3, @1, @4];
    NSArray *duplications = @[@4];
    [self judugeTestName:@"test2" numbers:numbers expected:duplications validArgument:YES];
}


- (void)test3 {
    NSArray *numbers = @[@2, @4, @2, @1, @4];
    NSArray *duplications = @[@2, @4];
    [self judugeTestName:@"test3" numbers:numbers expected:duplications validArgument:YES];
}


- (void)test4 {
    NSArray *numbers = @[@2, @1, @3, @0, @4];
    NSArray *duplications = @[@(-1)];
    [self judugeTestName:@"test4" numbers:numbers expected:duplications validArgument:NO];
}


- (void)test5 {
    NSArray *numbers = @[@2, @1, @3, @5, @4];
    NSArray *duplications = @[@(-1)];
    [self judugeTestName:@"test5" numbers:numbers expected:duplications validArgument:NO];
}

- (void)test6 {
    NSArray *numbers = nil;
    NSArray *duplications = @[@(-1)];
    [self judugeTestName:@"test5" numbers:numbers expected:duplications validArgument:NO];
}

- (void)judugeTestName:(NSString *)testName
               numbers:(NSArray<NSNumber *> *)numbers
               expected:(NSArray<NSNumber *> *)expected
         validArgument:(BOOL)validArgument {
    NSLog(@"%@ begins: ", testName);
    NSNumber *duplication;
    BOOL validInput = [FindDuplication findDuplicate:numbers duplication:&duplication];
    if ((validArgument && validInput)
        || (!validArgument && !validInput)) {
        if(validArgument) {
            XCTAssertTrue([self contains:expected number:duplication], @"FAILED.\n");
        }
    }
}

- (BOOL)contains:(NSArray<NSNumber *> *)numbers
          number:(NSNumber *)number {
    for(int i = 0; i < numbers.count; ++i) {
        if([numbers[i] integerValue] == [number integerValue])
            return true;
    }
    return false;
}
@end
