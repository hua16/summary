//
//  MGAIEditCoverViewController.h
//  MiguDM
//
//  Created by wuzaifeng on 2018/4/3.
//  Copyright © 2018年 咪咕动漫. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^MGAIEditCoverTimeBlock)(CGFloat coverTime);

@interface MGAIEditCoverViewController : UIViewController

- (instancetype)initWithVideoPath:(NSString *)videoPath
                        coverTime:(CGFloat)coverTime
                   coverTimeBlock:(MGAIEditCoverTimeBlock)coverTimeBlock;

@end 
