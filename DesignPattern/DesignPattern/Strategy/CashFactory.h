//
//  Context.h
//  DesignPattern
//
//  Created by xulihua on 2017/2/6.
//  Copyright © 2017年 huage. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, LHCashType) {
    LHCashTypeNormal,
    LHCashTypeRebate,
    LHCashTypeReturn
};

@class CashSuper;
@interface CashFactory : NSObject

- (instancetype)initWith:(LHCashType)type;

- (CGFloat)GetResult:(CGFloat)money;

@end
