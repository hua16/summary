//
//  UIResponder+Router.m
//  responderChainDemo
//
//  Created by xulihua on 2017/8/17.
//  Copyright © 2017年 huage. All rights reserved.
//

#import "UIResponder+Router.h"

@implementation UIResponder (Router)

- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo {
    [[self nextResponder] routerEventWithName:eventName userInfo:userInfo];
}

@end
