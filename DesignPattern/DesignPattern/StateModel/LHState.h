//
//  LHState.h
//  DesignPattern
//
//  Created by xulihua on 16/9/29.
//  Copyright © 2016年 huage. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LHWork.h"

@interface LHState : NSObject

- (void)writeProgramWithWork:(LHWork *)work;

@end
