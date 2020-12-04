//
//  Duck.h
//  FirstVersion
//
//  Created by xiake on 2020/11/28.
//

#import <Foundation/Foundation.h>
#import "FlyBehavior.h"
#import "QuackBehavior.h"

NS_ASSUME_NONNULL_BEGIN

@interface Duck : NSObject


@property (nonatomic, strong) id<FlyBehavior> flyBehavior;

@property (nonatomic, strong) id<QuackBehavior> quackBehavior;


- (void)swim;

- (void)display;

- (void)preformQuack;

- (void)preformFly;

@end

NS_ASSUME_NONNULL_END
