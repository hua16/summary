//
//  LHFinery.m
//  DesignPattern
//
//  Created by xulihua on 16/9/24.
//  Copyright © 2016年 huage. All rights reserved.
//

#import "LHFinery.h"

@interface LHFinery ()

@property (nonatomic, strong) LHPerson *component;

@end

@implementation LHFinery

- (void)decorate:(LHPerson *)component {
    self.component = component;
}

- (void)show {
    if (self.component) {
        [self.component show];
    }
}

@end

@implementation LHTShirts

- (void)show {
    [super show];
    NSLog(@"大T恤");
}

@end

@implementation LHBigTrouser

- (void)show {
    [super show];
    NSLog(@"垮裤");
}

@end

@implementation LHSneakers

- (void)show {
    [super show];
    NSLog(@"破球鞋");}

@end

@implementation LHSuit

- (void)show {
    [super show];
    NSLog(@"西装");
}

@end

@implementation LHTie

- (void)show {
    [super show];
    NSLog(@"领带");
}

@end

@implementation LHLeatherShoes

- (void)show {
    [super show];
    NSLog(@"皮鞋");
}

@end