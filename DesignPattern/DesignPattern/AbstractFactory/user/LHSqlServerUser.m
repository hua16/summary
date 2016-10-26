//
//  LHSqlServerUser.m
//  DesignPattern
//
//  Created by xulihua on 16/9/29.
//  Copyright © 2016年 huage. All rights reserved.
//

#import "LHSqlServerUser.h"
#import "LHUser.h"

@implementation LHSqlServerUser

- (void)insertUser:(LHUser *)user {
    NSLog(@"在SQL Server中给User表增加一条记录");
}

- (void)getUserById:(UInt64)ID {
    NSLog(@"在SQL Server中根据ID得到User表中的一条记录");
}

@end
