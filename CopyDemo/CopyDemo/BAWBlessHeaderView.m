//
//  BAWBlessHeaderView.m
//  CopyDemo
//
//  Created by xulihua on 2017/12/12.
//  Copyright © 2017年 huage. All rights reserved.
//

#import "BAWBlessHeaderView.h"
#import <Masonry/Masonry.h>

@interface BAWBlessHeaderView ()<UITextViewDelegate>

@end

@implementation BAWBlessHeaderView

#pragma mark - life cycle

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addPageSubViews];
        [self layoutPageSubviews];
    }
    return self;
}

- (void)addPageSubViews {
    [self addSubview:self.imageView];
    [self addSubview:self.blessTextView];
//    [self addSubview:self.editedButton];
}

- (void)layoutPageSubviews {
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(10);
        make.leading.equalTo(self).offset(100);
        make.trailing.equalTo(self).offset(-100);
        make.height.equalTo(self.imageView.mas_width).multipliedBy(8/7.0);
    }];
    
    [self.blessTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imageView).offset(7); 
        make.leading.equalTo(self).offset(100);
        make.trailing.equalTo(self).offset(-100);
        make.height.equalTo(self.imageView.mas_width).multipliedBy(8/7.0);
    }];
}

#pragma mark - getter & setter

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
    }
    return _imageView;
}

- (UITextView *)blessTextView{
    if (!_blessTextView) {
        _blessTextView = [[UITextView alloc] init];
//        _blessTextView.textColor = RECSkin_COLOR_KEY_1;
        _blessTextView.textAlignment = NSTextAlignmentNatural;
//        _blessTextView.font = RECSkin_FONT_KEY_13;
//        _blessTextView.backgroundColor = RECSkin_COLOR_KEY_7;
        _blessTextView.delegate = self;
        _blessTextView.scrollEnabled = NO;
        _blessTextView.keyboardType = UIKeyboardTypeDefault;
        _blessTextView.textContainerInset = UIEdgeInsetsMake(14, 0, 0, 0);
    }
    return _blessTextView;
}

//- (UIButton *)editedButton {
//    if (!_editedButton) {
//        _editedButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        _editedButton.titleLabel.font = [UIFont systemFontOfSize:13];
//        [_editedButton setTitle:@"查看更多" forState:UIControlStateNormal];
////        [_editedButton setTitleColor:[UIColor colorWithHex:0xAAAAAA] forState:UIControlStateNormal];
//        //        [self setBackgroundImage:[UIImage imageWithColor:HEXCOLOR(0x2680E9)]
//        //                        forState:UIControlStateNormal];
//        //        [self setBackgroundImage:[UIImage imageWithColor:HEXCOLOR(0x2680E9)]
//        //                            forState:UIControlStateHighlighted];
//        //        [self setBackgroundImage:[UIImage imageWithColor:HEXCOLOR(0x2680E9)]
//        //                        forState:UIControlStateDisabled];
//        _editedButton.layer.cornerRadius = 4.0;
//        _editedButton.layer.masksToBounds = YES;
////        _editedButton.layer.borderColor = [UIColor colorWithHex:0xb9b9b9 alpha:0.5].CGColor;
//        _editedButton.layer.borderWidth = 1;
//    }
//    return _editedButton;
//}
@end
