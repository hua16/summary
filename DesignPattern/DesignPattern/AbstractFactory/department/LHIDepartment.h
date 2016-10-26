//
//  LHIDepartment.h
//  DesignPattern
//
//  Created by xulihua on 16/9/29.
//  Copyright © 2016年 huage. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LHDepartment;
@interface LHIDepartment : NSObject

- (void)insert:(LHDepartment *)department;
- (LHDepartment *)getDepartment:(UInt64)ID;

@end
