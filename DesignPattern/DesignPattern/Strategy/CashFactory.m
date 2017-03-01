//
//  Context.m
//  DesignPattern
//
//  Created by xulihua on 2017/2/6.
//  Copyright © 2017年 huage. All rights reserved.
//

#import "CashFactory.h"
#import "CashSuper.h"
#import "CashNormal.h"
#import "CashRebate.h"
#import "CashReturn.h"

@interface CashFactory ()

@property (nonatomic, strong) CashSuper *cs;

@end

@implementation CashFactory

- (instancetype)initWith:(LHCashType)type;
{
    self = [super init];
    if (self) {
        switch (type) {
            case LHCashTypeNormal: {
                _cs = [[CashNormal alloc] init];
            }
                break;
            case LHCashTypeRebate: {
                _cs = [[CashReturn alloc] initWith:@"300" moneyReturn:@"100"];
            }
                break;
            case LHCashTypeReturn: {
                _cs = [[CashRebate alloc] initWith:@"0.8"];
            }
                break;
        }
    }
    return self;
}

- (CGFloat)GetResult:(CGFloat)money {
    return [self.cs acceptCash:money];
}

@end
