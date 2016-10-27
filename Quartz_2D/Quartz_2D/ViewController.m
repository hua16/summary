//
//  ViewController.m
//  Quartz_2D
//
//  Created by xulihua on 16/10/26.
//  Copyright © 2016年 huage. All rights reserved.
//

#import "ViewController.h"
#import <Masonry/Masonry.h>
#import "LTQuartzView.h"

@interface ViewController ()

@property (nonatomic, strong) LTQuartzView *quartzView;

@end

@implementation ViewController

#pragma mark - lift cycye
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self addPageSubViews];
    [self layoutPageSubviews];
    
}

- (void)addPageSubViews {
    [self.view addSubview:self.quartzView];
}

- (void)layoutPageSubviews {
    [self.quartzView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - getter & setter 
- (LTQuartzView *)quartzView {
    if (!_quartzView) {
        _quartzView = [[LTQuartzView alloc] init];
    }
    return _quartzView;
}

@end
