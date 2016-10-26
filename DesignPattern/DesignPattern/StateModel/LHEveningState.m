//
//  LHEveningState.m
//  DesignPattern
//
//  Created by xulihua on 16/9/29.
//  Copyright © 2016年 huage. All rights reserved.
//

#import "LHEveningState.h"
#import "LHSleepingState.h"
#import "LHRestState.h"

@implementation LHEveningState

- (void)writeProgramWithWork:(LHWork *)work {
    if (work.finish) {
        work.current = [[LHRestState alloc] init];
        [work writeProgram];
    } else {
        if (work.hour < 21) {
            NSLog(@"当前时间:%ld点 加班了，累成🐶", work.hour);
        } else {
            work.current = [[LHSleepingState alloc] init];
            [work writeProgram];
        }
    }
}

@end
