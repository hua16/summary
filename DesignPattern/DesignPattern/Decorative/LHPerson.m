//
//  LHPerson.m
//  DesignPattern
//
//  Created by xulihua on 16/9/24.
//  Copyright © 2016年 huage. All rights reserved.
//

#import "LHPerson.h"

@interface LHPerson ()

@property (nonatomic, copy) NSString *name;

@end

@implementation LHPerson

- (instancetype)initWithName:(NSString *)name;
{
    self = [super init];
    if (self) {
        _name = name;
    }
    return self;
}

- (void)show {
    NSLog(@"装扮的%@",self.name);
}

@end
