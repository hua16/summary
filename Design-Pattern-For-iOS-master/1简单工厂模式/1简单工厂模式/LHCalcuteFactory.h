//
//  LHCalcuteFactory.h
//  1简单工厂模式
//
//  Created by huage on 15/8/10.
//  Copyright (c) 2015年 huage. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LHCalculate.h"
#import "LHBaseCalculate.h"


@class CommonTool;
@interface LHCalcuteFactory : NSObject

//类方法
+(LHBaseCalculate<LHCalculate> *)createCalcute:(NSString *)calculatetype;

//实例方法
- (void)test;
@end
