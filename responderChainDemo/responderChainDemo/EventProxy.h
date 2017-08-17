//
//  EventProxy.h
//  responderChainDemo
//
//  Created by xulihua on 2017/8/17.
//  Copyright © 2017年 huage. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EventProxy : NSObject

- (void)handleEvent:(NSString *)eventName userInfo:(NSDictionary *)userInfo;

@end
