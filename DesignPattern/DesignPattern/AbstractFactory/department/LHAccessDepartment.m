//
//  LHAccessDepartment.m
//  DesignPattern
//
//  Created by xulihua on 16/9/29.
//  Copyright © 2016年 huage. All rights reserved.
//

#import "LHAccessDepartment.h"

@implementation LHAccessDepartment

- (void)insert:(LHDepartment *)department {
    NSLog(@"在Access中给department表增加一条记录");
}

- (LHDepartment *)getDepartment:(UInt64)ID {
    NSLog(@"在Access中根据ID得到department表中的一条记录");
    return nil;
}

@end
