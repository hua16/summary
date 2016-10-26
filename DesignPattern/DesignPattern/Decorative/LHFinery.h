//
//  LHFinery.h
//  DesignPattern
//
//  Created by xulihua on 16/9/24.
//  Copyright © 2016年 huage. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LHPerson.h"

@interface LHFinery : LHPerson

- (void)decorate:(LHPerson *)component;
- (void)show;

@end

@interface LHTShirts : LHFinery

@end

@interface LHBigTrouser : LHFinery

@end

@interface LHSneakers : LHFinery

@end

@interface LHSuit : LHFinery

@end

@interface LHTie : LHFinery

@end

@interface LHLeatherShoes : LHFinery

@end