//
//  MGEffectFooterView.h
//  MiguC
//
//  Created by zaifeng wu on 2018/7/16.
//  Copyright © 2018年 咪咕动漫. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^MGFooterViewCancelBlock)(void);
typedef void(^MGFooterViewDoenBlock)(void);

@interface MGEffectFooterView : UIView

@property (nonatomic, copy) MGFooterViewCancelBlock cancelBlock;
@property (nonatomic, copy) MGFooterViewDoenBlock doneBlock;

@end
