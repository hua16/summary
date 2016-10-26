//
//  LHDataAccess.m
//  DesignPattern
//
//  Created by xulihua on 16/9/29.
//  Copyright © 2016年 huage. All rights reserved.
//

#import "LHDataAccess.h"
#import "LHIUser.h"
#import "LHSqlServerUser.h"
#import "LHAccessUser.h"
#import "LHIDepartment.h"
#import "LHSqlServerDepartment.h"
#import "LHAccessDepartment.h"

static NSString *const LHDBName = @"SqlServer";
//static NSString *const LHDBName = @"Access";

@implementation LHDataAccess

+ (LHIUser *)createUser {
    LHIUser *result = nil;
    NSString *className = [NSString stringWithFormat:@"LH%@User",LHDBName];
    Class class = NSClassFromString(className);
    result = [[class alloc] init];
    return result;
}

+ (LHIDepartment *)createDepartment {
    LHIDepartment *result = nil;
    NSString *className = [NSString stringWithFormat:@"LH%@Department",LHDBName];
    Class class = NSClassFromString(className);
    result = [[class alloc] init];
    return result;
}

@end
