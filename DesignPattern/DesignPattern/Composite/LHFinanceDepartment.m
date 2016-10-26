//
//  LHFinanceDepartment.m
//  DesignPattern
//
//  Created by xulihua on 16/9/30.
//  Copyright © 2016年 huage. All rights reserved.
//

#import "LHFinanceDepartment.h"

@implementation LHFinanceDepartment

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
    NSLog(@"%@ 公司财务收支管理", self.name);
}

@end
