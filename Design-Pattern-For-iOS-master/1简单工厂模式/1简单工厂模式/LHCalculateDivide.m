//
//  LHCalculateDivide.m
//  1简单工厂模式
//
//  Created by huage on 15/8/10.
//  Copyright (c) 2015年 huage. All rights reserved.
//

#import "LHCalculateDivide.h"

@implementation LHCalculateDivide

-(CGFloat)calculate{
    if (self.numberB == 0) {
        assert(self.numberB);
    }
    return self.numberA/self.numberB;
}
@end
