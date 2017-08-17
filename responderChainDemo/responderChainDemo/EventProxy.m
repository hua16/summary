//
//  EventProxy.m
//  responderChainDemo
//
//  Created by xulihua on 2017/8/17.
//  Copyright © 2017年 huage. All rights reserved.
//

#import "EventProxy.h"
#import "ResponderChainDefine.h"
#import "UIResponder+Router.h"
#import "NSObject+Invocation.h"

@interface EventProxy ()


@property (nonatomic, strong) NSDictionary *eventStrategy;

@end

@implementation EventProxy

- (void)handleEvent:(NSString *)eventName userInfo:(NSDictionary *)userInfo {
    
    NSInvocation *invocation = self.eventStrategy[eventName];
    [invocation setArgument:&userInfo atIndex:2];
    [invocation invoke];
}

- (void)cellLeftButtonClick:(NSDictionary *)userInfo {
    NSIndexPath *indexPath = userInfo[@"indexPath"];
    NSLog(@"indexPath:section:%ld, row:%ld 左边按钮被点击啦！",indexPath.section, indexPath.row);
}

- (void)cellMiddleButtonClick:(NSDictionary *)userInfo {
    NSIndexPath *indexPath = userInfo[@"indexPath"];
    NSLog(@"indexPath:section:%ld, row:%ld 中间按钮被点击啦！",indexPath.section, indexPath.row);
}

- (void)cellRightButtonClick:(NSDictionary *)userInfo {
    NSIndexPath *indexPath = userInfo[@"indexPath"];
    NSLog(@"indexPath:section:%ld, row:%ld 右边按钮被点击啦！",indexPath.section, indexPath.row);
}

#pragma mark - getter & setter
- (NSDictionary <NSString *, NSInvocation *>*)eventStrategy {
    if (!_eventStrategy) {
        _eventStrategy = @{
                           kTableViewCellEventTappedLeftButton:[self createInvocationWithSelector:@selector(cellLeftButtonClick:)],
                           kTableViewCellEventTappedMiddleButton:[self createInvocationWithSelector:@selector(cellMiddleButtonClick:)],
                           kTableViewCellEventTappedRightButton:[self createInvocationWithSelector:@selector(cellRightButtonClick:)]
                           };
    }
    return _eventStrategy;
}

@end
