//
//  NSObject+Invocation.h
//  responderChainDemo
//
//  Created by xulihua on 2017/8/17.
//  Copyright © 2017年 huage. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Invocation)

- (NSInvocation *)createInvocationWithSelector:(SEL)aSelector;

@end


