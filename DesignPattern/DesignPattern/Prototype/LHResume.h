//
//  LHResume.h
//  DesignPattern
//
//  Created by xulihua on 16/9/26.
//  Copyright © 2016年 huage. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LHResume : NSObject

- (instancetype)initWithName:(NSString *)name
                 sex:(NSString *)sex
                 age:(NSString *)age
            timeArea:(NSString *)timeArea
             compony:(NSString *)compony;

- (void)display;

@end
