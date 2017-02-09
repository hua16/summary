//
//  ConcreteStrategyB.m
//  DesignPattern
//
//  Created by xulihua on 2017/2/6.
//  Copyright © 2017年 huage. All rights reserved.
//

#import "CashRebate.h"

@interface CashRebate ()

@property (nonatomic, copy, readonly) NSString *moneyRebate;

@end

@implementation CashRebate

- (instancetype)initWith:(NSString *)moneyRebate
{
    self = [super init];
    if (self) {
        _moneyRebate = moneyRebate;
    }
    return self;
}


- (CGFloat)acceptCash:(CGFloat)money {
    return money * [self.moneyRebate floatValue];
}


@end
