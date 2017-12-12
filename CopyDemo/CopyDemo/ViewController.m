//
//  ViewController.m
//  CopyDemo
//
//  Created by xulihua on 2017/12/1.
//  Copyright © 2017年 huage. All rights reserved.
//

#import "ViewController.h"
#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>

@interface ViewController ()

/**
 滚动视图，布局超过屏幕高度时，可以滚动显示
 */
@property (nonatomic, strong) UIScrollView *scrollView;

/**
 内容视图，所有的布局均添加在此视图上
 */
@property (nonatomic, strong) UIView *containView;

/**
 头部视图，显示祝福图片和祝福语
 */
@property (nonatomic, strong) UIView *headerView;

/**
 祝福列表视图
 */
@property (nonatomic, strong) UICollectionView *blesslistView;

/**
 发送祝福按钮
 */
@property (nonatomic, strong) UIButton *sendBlessButton;

@end

@implementation ViewController

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configurePageView];
    [self addPageSubviews];
    [self layoutPageSubviews];
}

- (void)configurePageView {
    self.title = @"祝福";
}

- (void)addPageSubviews {
    [self.view addSubview:self.scrollView];
    
    [self.scrollView addSubview:self.containView];
    [self.containView addSubview:self.headerView];
    [self.containView addSubview:self.sendBlessButton];
}

- (void)layoutPageSubviews {
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.view);
        make.trailing.equalTo(self.view);
        if (@available(iOS 11.0, *)) {
            make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
            make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
        } else {
            make.top.equalTo(self.view);
            make.bottom.equalTo(self.view);
        }
    }];
    
    [self.containView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.scrollView);
        make.width.equalTo(self.scrollView);  
    }];
    
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.containView).offset(10);
        make.leading.equalTo(self.containView).offset(100);
        make.trailing.equalTo(self.containView).offset(-100);
        make.height.equalTo(self.headerView.mas_width).multipliedBy(8/7.0);
    }];
    
    [self.sendBlessButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headerView.mas_bottom);
        make.leading.equalTo(self.containView);
        make.trailing.equalTo(self.containView);
        make.height.mas_equalTo(200);
        make.bottom.equalTo(self.containView);
    }];
}

#pragma mark - getter & setter

-(UIView *)containView {
    if (!_containView) {
        _containView = [[UIView alloc] init];
        _containView.backgroundColor = [UIColor blueColor];
    }
    return _containView;
}

-(UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.backgroundColor = [UIColor redColor];
    }
    return _scrollView;
}

- (UIView *)headerView {
    if (!_headerView) {
        _headerView = [[UIView alloc] init];
        _headerView.backgroundColor = [UIColor grayColor];
    }
    return _headerView;
}

- (UIButton *)sendBlessButton {
    if (!_sendBlessButton) {
        _sendBlessButton = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _sendBlessButton;
}

@end
