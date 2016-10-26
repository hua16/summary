//
//  LHWork.m
//  DesignPattern
//
//  Created by xulihua on 16/9/29.
//  Copyright © 2016年 huage. All rights reserved.
//

#import "LHWork.h"
#import "LHState.h"
#import "LHForenoonState.h"

@interface LHWork ()



@end

@implementation LHWork

- (instancetype)init
{
    self = [super init];
    if (self) {
        _current = [[LHForenoonState alloc] init];
    }
    return self;
}

- (void)writeProgram {
    [self.current writeProgramWithWork:self];
}

@end
