//
//  LTSingletonObject.m
//  swordFingerOffer
//
//  Created by xulihua on 2018/6/24.
//  Copyright © 2018年 huage. All rights reserved.
//

#import "LTSingletonObject.h"

@implementation LTSingletonObject

// 单例的写法
+ (instancetype)shareInstance {
    static LTSingletonObject *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[LTSingletonObject alloc] init];
    });
    return instance;
}

@end
