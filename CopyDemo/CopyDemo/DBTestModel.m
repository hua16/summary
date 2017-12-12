//
//  DBTestModel.m
//  CopyDemo
//
//  Created by xulihua on 2017/12/4.
//  Copyright © 2017年 huage. All rights reserved.
//

#import "DBTestModel.h"

@implementation DBTestModel

- (instancetype)initWithText:(NSString *)text
                 sourceArray:(NSArray *)sourceArray
                mutableArray:(NSMutableArray *)mutableArray {
    self = [super init];
    if (self) {
        _text = text;
        _sourceArray = sourceArray;
        _mutableArray = mutableArray;
    }
    return self;
}

#pragma mark - NSCopying
//- (id)copyWithZone:(nullable NSZone *)zone {
//    DBTestModel *model = [[[self class] allocWithZone:zone] init];
//    model->_text = [_text copyWithZone:zone];
//    model->_sourceArray = [_sourceArray copyWithZone:zone];
//    model->_mutableArray = [_mutableArray copyWithZone:zone];
//    return model;
//}
//
//#pragma mark - NSMutableCopying
//- (id)mutableCopyWithZone:(nullable NSZone *)zone {
//    DBTestModel *model = [[[self class] allocWithZone:zone] init];
//    model->_text = [_text mutableCopyWithZone:zone];
//    model->_sourceArray = [_sourceArray mutableCopyWithZone:zone];
//    model->_mutableArray = [_mutableArray mutableCopyWithZone:zone]; 
//    return model;
//}

 


@end
