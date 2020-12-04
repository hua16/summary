//
//  MallardDuck.m
//  FirstVersion
//
//  Created by xiake on 2020/11/28.
//

#import "MallardDuck.h"
#import "Squeak.h"
#import "FlyNoWay.h"

@implementation MallardDuck

- (instancetype)init {
    self = [super init];
    if (self) {
        self.quackBehavior = [[Squeak alloc] init];
        self.flyBehavior = [[FlyNoWay alloc] init];
    }
    return self;
}

- (void)display {
    NSLog(@"I am a real Mallard duck");
}

@end
