//
//  BAWBlessHeaderView.h
//  CopyDemo
//
//  Created by xulihua on 2017/12/12.
//  Copyright © 2017年 huage. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BAWBlessHeaderView : UIView

/**
 顶部视图
 */
@property (nonatomic, strong) UIImageView *imageView;

/**
 祝福语输入框
 */
@property (nonatomic, strong) UITextView *blessTextView;

/**
 编辑按钮
 */
//@property (nonatomic, strong) UIButton *editedButton;

@end

NS_ASSUME_NONNULL_END
