//
//  Duck.m
//  FirstVersion
//
//  Created by xiake on 2020/11/28.
//

#import "Duck.h"

@implementation Duck

- (void)swim {
    
}

- (void)display {
    
}

- (void)preformQuack {
    [self.quackBehavior quack];
}

- (void)preformFly {
    [self.flyBehavior fly];
}

- (void)setFlyBehavior:(id<FlyBehavior>)flyBehavior {
    _flyBehavior = flyBehavior;
}

- (void)setQuackBehavior:(id<QuackBehavior>)quackBehavior {
    _quackBehavior = quackBehavior;
}

@end
