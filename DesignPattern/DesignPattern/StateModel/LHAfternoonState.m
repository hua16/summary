//
//  LHAfternoonState.m
//  DesignPattern
//
//  Created by xulihua on 16/9/29.
//  Copyright © 2016年 huage. All rights reserved.
//

#import "LHAfternoonState.h"
#import "LHEveningState.h"

@implementation LHAfternoonState

- (void)writeProgramWithWork:(LHWork *)work {
    if (work.hour < 17) {
        NSLog(@"当前时间:%ld点 下午状态还不错，继续努力", work.hour);
    } else {
        work.current = [[LHEveningState alloc] init];
        [work writeProgram];
    }
}

@end
