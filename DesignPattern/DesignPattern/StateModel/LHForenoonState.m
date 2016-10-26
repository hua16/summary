//
//  LHForenoonState.m
//  DesignPattern
//
//  Created by xulihua on 16/9/29.
//  Copyright © 2016年 huage. All rights reserved.
//

#import "LHForenoonState.h"
#import "LHNoonState.h"

@implementation LHForenoonState

- (void)writeProgramWithWork:(LHWork *)work {
    if (work.hour < 12) {
        NSLog(@"当前时间:%ld点 上午工作，精神百倍", work.hour);
    } else {
        work.current = [[LHNoonState alloc] init];
        [work writeProgram];
    }
}

@end
