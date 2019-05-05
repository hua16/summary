//
//  FindDuplication.m
//  swordFingerOffer
//
//  Created by xulihua on 2018/6/24.
//  Copyright © 2018年 huage. All rights reserved.
//

#import "FindDuplication.h" 

@implementation FindDuplication

+ (BOOL)findDuplicate:(NSArray<NSNumber *> *)numbers
          duplication:(NSNumber **)duplication {
    // 如果数组里的值为空，直接返回
    if (numbers.count == 0) {
        return NO;
    }
    
    // 如果数组里的值不在0~n-1之间，直接返回
    for (NSInteger i = 0; i < numbers.count; i++) {
        NSInteger currentValue = [numbers[i] integerValue];
        if (currentValue < 0 || currentValue > (numbers.count - 1)) {
            return NO;
        }
    }
    
    // 将坐标位置i的值和i比较，如果不相等，位置为位置i的值和位置i交换。
    NSMutableArray *mutaArray = [numbers mutableCopy];
    
    for (NSInteger i = 0; i < mutaArray.count; i++) {
        while ([mutaArray[i] integerValue] != i) {
            if ([mutaArray[i] integerValue] == [mutaArray[[mutaArray[i] integerValue]] integerValue]) {
                *duplication = mutaArray[i];
                return YES;
            }
            NSNumber *temp = mutaArray[i];
            mutaArray[i] = mutaArray[[mutaArray[i] integerValue]];
            mutaArray[[temp integerValue]] = temp;
//            [mutaArray exchangeObjectAtIndex:[mutaArray[i] integerValue] withObjectAtIndex:i];
        }
    }
    
    return NO;
}

@end
