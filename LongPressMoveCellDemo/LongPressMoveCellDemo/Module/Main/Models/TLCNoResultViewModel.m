//
//  TLCNoResultViewModel.m
//  transaction_list_ios
//
//  Created by lever on 2018/1/2.
//  Copyright © 2018年 ND. All rights reserved.
//

#import "TLCNoResultViewModel.h"

@implementation TLCNoResultViewModel

- (instancetype)initWithImageName:(NSString *)imageName title:(NSString *)title tip:(NSString *)tip {
    if (self = [super init]) {
        self.imageName = imageName;
        self.title = title;
        self.tip = tip;
    }
    return self;
} 

@end
