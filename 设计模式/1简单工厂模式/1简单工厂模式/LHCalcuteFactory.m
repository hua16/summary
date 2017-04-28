    //
//  LHCalcuteFactory.m
//  1简单工厂模式
//
//  Created by huage on 15/8/10.
//  Copyright (c) 2015年 huage. All rights reserved.
//

#import "LHCalcuteFactory.h"
#import "LHCalculateAdd.h"
#import "LHCalculateDivide.h"
#import "LHCalculateMinus.h"
#import "LHCalcuteMultiply.h"
#import "CommonTool.h"


@implementation LHCalcuteFactory
+(LHBaseCalculate<LHCalculate> *)createCalcute:(NSString *)calculatetype{
    
    NSArray *calculateArray = @[@"+",@"-",@"*",@"/"];
    CalculateType calType = [calculateArray indexOfObject:calculatetype];
    
    switch (calType) {
        case calcuteTypeAdd:
            return [[LHCalculateAdd alloc]init];
            break;
        case calcuteTypeMinus:
            return [[LHCalculateMinus alloc]init];
            break;
        case calcuteTypdeMultipy:
            return [[LHCalcuteMultiply alloc]init];
            break;
        case calcuteTypeDivide:
            return [[LHCalculateDivide alloc]init];
            break;
        default:
            return nil;
            break;
    }
}
@end
