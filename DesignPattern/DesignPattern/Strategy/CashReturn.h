//
//  ConcreteStrategyC.h
//  DesignPattern
//
//  Created by xulihua on 2017/2/6.
//  Copyright © 2017年 huage. All rights reserved.
//

#import "CashSuper.h"

@interface CashReturn : CashSuper

- (instancetype)initWith:(NSString *)moneyCondition
             moneyReturn:(NSString *)moneyReturn;

@end
