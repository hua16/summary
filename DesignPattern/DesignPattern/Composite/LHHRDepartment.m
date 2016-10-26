//
//  LHHRDepartment.m
//  DesignPattern
//
//  Created by xulihua on 16/9/30.
//  Copyright © 2016年 huage. All rights reserved.
//

#import "LHHRDepartment.h"

@implementation LHHRDepartment

- (void)add:(LHCompany *)company {
    
}

- (void)remove:(LHCompany *)company {
    
}

- (void)display:(NSInteger)depth {
    NSMutableString *what = [NSMutableString string];
    for (NSInteger i = 0 ; i < depth; i++) {
        [what appendString:@"-"];
    }
    NSLog(@"%@%@",what, self.name);
}

- (void)lineOfDuty {
    NSLog(@"%@ 员工招聘培训管理", self.name);
}

@end
