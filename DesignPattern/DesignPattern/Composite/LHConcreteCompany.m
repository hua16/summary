//
//  LHConcreteCompany.m
//  DesignPattern
//
//  Created by xulihua on 16/9/30.
//  Copyright © 2016年 huage. All rights reserved.
//

#import "LHConcreteCompany.h"

@interface LHConcreteCompany ()

@property (nonatomic, strong) NSMutableArray *children;

@end

@implementation LHConcreteCompany

- (void)add:(LHCompany *)company {
    [self.children addObject:company];
}

- (void)remove:(LHCompany *)company {
    [self.children removeObject:company];
}

- (void)display:(NSInteger)depth {
    NSMutableString *what = [NSMutableString string];
    for (NSInteger i = 0 ; i < depth; i++) {
        [what appendString:@"-"];
    }
    NSLog(@"%@%@",what, self.name);
    for (LHCompany *compony in self.children) {
        [compony display:depth + 2];
    }
}

- (void)lineOfDuty {
    for (LHCompany *compony in self.children) {
        [compony lineOfDuty];
    }
}

#pragma mark - getter & setter
- (NSMutableArray *)children {
    if (!_children) {
        _children = [NSMutableArray array];
    }
    return _children;
}

@end
