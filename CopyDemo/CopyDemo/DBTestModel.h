//
//  DBTestModel.h
//  CopyDemo
//
//  Created by xulihua on 2017/12/4.
//  Copyright © 2017年 huage. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle/Mantle.h>

@interface DBTestModel : MTLModel

@property (nonatomic, copy) NSString *text;

@property (nonatomic, strong) NSArray *sourceArray;

@property (nonatomic, strong) NSMutableArray *mutableArray;

- (instancetype)initWithText:(NSString *)text
                 sourceArray:(NSArray *)sourceArray
                mutableArray:(NSMutableArray *)mutableArray;
@end
