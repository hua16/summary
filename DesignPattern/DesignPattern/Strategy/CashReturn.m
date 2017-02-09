//
//  ConcreteStrategyC.m
//  DesignPattern
//
//  Created by xulihua on 2017/2/6.
//  Copyright © 2017年 huage. All rights reserved.
//

#import "CashReturn.h"

@interface CashReturn ()

@property (nonatomic, assign, readonly) CGFloat moneyCondition;
@property (nonatomic, assign, readonly) CGFloat moneyReturn;

@end

@implementation CashReturn

- (instancetype)initWith:(NSString *)moneyCondition
             moneyReturn:(NSString *)moneyReturn {
    self = [super init];
    if (self) {
        _moneyCondition = [moneyCondition floatValue];
        _moneyReturn = [moneyReturn floatValue];
    }
    return self;
}

- (CGFloat)acceptCash:(CGFloat)money {
    CGFloat result = money;
    if (money >= self.moneyCondition) {
        result = money - self.moneyReturn;
    }
    return result;
}

@end
