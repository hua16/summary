//
//  LHSleepingState.m
//  DesignPattern
//
//  Created by xulihua on 16/9/29.
//  Copyright © 2016年 huage. All rights reserved.
//

#import "LHSleepingState.h"

@implementation LHSleepingState

- (void)writeProgramWithWork:(LHWork *)work {
    
    NSLog(@"当前时间:%ld点 不行了，睡着了。", work.hour);
}

@end
