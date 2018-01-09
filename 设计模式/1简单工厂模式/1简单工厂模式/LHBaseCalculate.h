//
//  LHBaseCalculate.h
//  1简单工厂模式
//
//  Created by xulihua on 2017/3/27.
//  Copyright © 2017年 huage. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "LHCalculate.h"

@interface LHBaseCalculate : NSObject

@property(nonatomic, assign) CGFloat numberA;
@property(nonatomic, assign) CGFloat numberB; 

- (void)testA:(CGFloat)test;

@end
