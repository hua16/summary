//
//  LHCompany.h
//  DesignPattern
//
//  Created by xulihua on 16/9/30.
//  Copyright © 2016年 huage. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LHCompany : NSObject

@property (nonatomic, readonly, copy) NSString *name;

- (instancetype)initWithName:(NSString *)name;

/**
 *  增加
 */
- (void)add:(LHCompany *)company;

/**
 *  移除
 */
- (void)remove:(LHCompany *)company;

/**
 *  显示
 */
- (void)display:(NSInteger)depth;

/**
 *  履行职责
 */
- (void)lineOfDuty;

@end
