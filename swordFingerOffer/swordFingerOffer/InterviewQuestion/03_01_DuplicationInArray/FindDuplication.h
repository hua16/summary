//
//  FindDuplication.h
//  swordFingerOffer
//
//  Created by xulihua on 2018/6/24.
//  Copyright © 2018年 huage. All rights reserved.
//

#import <Foundation/Foundation.h>

//在长度为n的数组里的所有数字都在0~n-1的范围内，
//找到数组中任意一个重复的数字。

@interface FindDuplication : NSObject

+ (BOOL)findDuplicate:(NSArray<NSNumber *> *)numbers
          duplication:(NSNumber **)duplication;

@end
