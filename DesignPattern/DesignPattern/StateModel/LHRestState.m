//
//  LHRestState.m
//  DesignPattern
//
//  Created by xulihua on 16/9/29.
//  Copyright © 2016年 huage. All rights reserved.
//

#import "LHRestState.h"

@implementation LHRestState

- (void)writeProgramWithWork:(LHWork *)work {
    NSLog(@"当前时间:%ld点 下班回家了", work.hour);
}

@end
