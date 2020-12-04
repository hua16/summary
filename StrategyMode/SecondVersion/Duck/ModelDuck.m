//
//  ModelDuck.m
//  SecondVersion
//
//  Created by xiake on 2020/11/28.
//

#import "ModelDuck.h"
#import "FlyNoWay.h"
#import "Quack.h"

@implementation ModelDuck

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.flyBehavior = [[FlyNoWay alloc] init];
        self.quackBehavior = [[Quack alloc] init];
    }
    return self;
}

- (void)display {
    NSLog(@"I am a model duck");
}

@end
