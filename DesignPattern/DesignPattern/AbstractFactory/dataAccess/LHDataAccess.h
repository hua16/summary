//
//  LHDataAccess.h
//  DesignPattern
//
//  Created by xulihua on 16/9/29.
//  Copyright © 2016年 huage. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LHIUser;
@class LHIDepartment;
@interface LHDataAccess : NSObject

+ (LHIUser *)createUser;
+ (LHIDepartment *)createDepartment;

@end
