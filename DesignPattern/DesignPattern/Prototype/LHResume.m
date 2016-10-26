//
//  LHResume.m
//  DesignPattern
//
//  Created by xulihua on 16/9/26.
//  Copyright © 2016年 huage. All rights reserved.
//

#import "LHResume.h"

@interface LHResume ()

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *sex;
@property (nonatomic, copy) NSString *age;
@property (nonatomic, copy) NSString *timeArea;
@property (nonatomic, copy) NSString *company;

@end

@implementation LHResume


- (instancetype)initWithName:(NSString *)name
                 sex:(NSString *)sex
                 age:(NSString *)age
            timeArea:(NSString *)timeArea
             compony:(NSString *)compony;
{
    self = [super init];
    if (self) {
        _name = name;
        _sex = sex;
        _age = age;
        _timeArea = timeArea;
        _company = compony;
    }
    return self;
}

- (void)display {
    NSLog(@"%@  %@  %@",self.name, self.sex, self.age);
    NSLog(@"工作经历： %@ %@", self.timeArea, self.company);
}

@end
