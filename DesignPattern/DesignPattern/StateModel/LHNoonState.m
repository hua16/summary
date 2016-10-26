//
//  LHNoonState.m
//  DesignPattern
//
//  Created by xulihua on 16/9/29.
//  Copyright © 2016年 huage. All rights reserved.
//

#import "LHNoonState.h"
#import "LHAfternoonState.h"

@implementation LHNoonState

- (void)writeProgramWithWork:(LHWork *)work {
    if (work.hour < 13) {
        NSLog(@"当前时间:%ld点 饿了，午饭，犯困，午休", work.hour);
    } else {
        work.current = [[LHAfternoonState alloc] init];
        [work writeProgram];
    }
}

@end
