//
//  LHIUser.h
//  DesignPattern
//
//  Created by xulihua on 16/9/29.
//  Copyright © 2016年 huage. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LHUser;
@interface LHIUser : NSObject

- (void)insertUser:(LHUser *)user;
- (void)getUserById:(UInt64)ID;

@end
