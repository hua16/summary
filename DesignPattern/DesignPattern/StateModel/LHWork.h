//
//  LHWork.h
//  DesignPattern
//
//  Created by xulihua on 16/9/29.
//  Copyright © 2016年 huage. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LHState;
@interface LHWork : NSObject

@property (nonatomic, assign) BOOL finish;
@property (nonatomic, assign) NSUInteger hour;
@property (nonatomic, strong) LHState *current;

- (void)writeProgram;

@end
