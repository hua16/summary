//
//  HCDCalculateAdd.m
//  1简单工厂模式
//
//  Created by 黄成都 on 15/8/10.
//  Copyright (c) 2015年 黄成都. All rights reserved.
//

#import "HCDCalculateAdd.h"
@implementation HCDCalculateAdd

-(CGFloat)calculate{
    NSLog(@"%@",self.test);
    return self.numberA + self.numberB;
}
@end
