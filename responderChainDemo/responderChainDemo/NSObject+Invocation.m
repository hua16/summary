//
//  NSObject+Invocation.m
//  responderChainDemo
//
//  Created by xulihua on 2017/8/17.
//  Copyright © 2017年 huage. All rights reserved.
//

#import "NSObject+Invocation.h"

@implementation NSObject (Invocation)


- (NSInvocation *)createInvocationWithSelector:(SEL)aSelector {
    //1、创建签名对象
    NSMethodSignature*signature = [[self class] instanceMethodSignatureForSelector:aSelector];
    
    //2、判断传入的方法是否存在
    if (signature==nil) {
        //传入的方法不存在 就抛异常
        NSString*info = [NSString stringWithFormat:@"-[%@ %@]:unrecognized selector sent to instance",[self class],NSStringFromSelector(aSelector)];
        @throw [[NSException alloc] initWithName:@"方法没有" reason:info userInfo:nil];
        return nil;
    }
    //3、、创建NSInvocation对象
    NSInvocation*invocation = [NSInvocation invocationWithMethodSignature:signature];
    //4、保存方法所属的对象
    invocation.target = self;
    invocation.selector = aSelector;
    return invocation;
}

@end
