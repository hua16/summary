//
//  ViewController.m
//  Layout
//
//  Created by Draveness on 8/28/16.
//  Copyright © 2016 Draveness. All rights reserved.
//

#import "ViewController.h"

#import <Masonry/Masonry.h>

@interface ViewController ()

@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UILabel *indicateLabel;
@property (nonatomic, strong) NSMutableArray *views;
@property (nonatomic, strong) NSMutableDictionary *resultDictionary;

@property (nonatomic, strong) UIButton *autoLayoutButton;
@property (nonatomic, strong) UIButton *nestedButton;
@property (nonatomic, strong) UIButton *frameButton;
@property (nonatomic, strong) UIButton *printResult;
@end

@implementation ViewController {}

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self addPageSubviews];
    [self layoutPageSubviews];
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap:)];
    [self.view addGestureRecognizer:gesture];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.textField becomeFirstResponder];
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

#pragma mark - UI & autolayout
- (void)addPageSubviews {
    [self.view addSubview:self.autoLayoutButton];
    [self.view addSubview:self.nestedButton];
    [self.view addSubview:self.frameButton];
    [self.view addSubview:self.textField];
    [self.view addSubview:self.indicateLabel];
    [self.view addSubview:self.printResult];
}

- (void)layoutPageSubviews {
    [self.autoLayoutButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(20);
        make.bottom.mas_equalTo(0);
    }];
    [self.nestedButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(20);
        make.bottom.mas_equalTo(0);
    }];
    [self.frameButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(20);
        make.bottom.mas_equalTo(0);
    }];
    
    [@[self.autoLayoutButton, self.nestedButton, self.frameButton] mas_distributeViewsAlongAxis:MASAxisTypeHorizontal
                                                                            withFixedItemLength:140 leadSpacing:0 tailSpacing:0];

    [self.printResult mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(20);
        make.top.left.mas_equalTo(0);
        make.width.mas_equalTo(100);
    }];
    
    
    [self.indicateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.mas_equalTo(0);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(20);
    }];
    
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.printResult.mas_right).offset(20);
        make.right.mas_equalTo(self.indicateLabel.mas_left).offset(-20);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(20);
    }];
}

#pragma mark - event response

- (void)generateViews {
    NSInteger number = self.textField.text.integerValue;
    for (UIView *view in self.views) {
        [view removeFromSuperview];
    }
    [self.views removeAllObjects];
    
    NSTimeInterval startTime = [NSDate timeIntervalSinceReferenceDate];
    for (NSInteger i = 0; i < number; i++) {
        UIView *leftView = self.view;
        UIView *topView = self.view;
        if (self.views.count != 0) {
            NSInteger left = arc4random() % self.views.count;
            NSInteger top = arc4random() % self.views.count;
            leftView = self.views[left];
            topView = self.views[top];
        }
        
        CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
        CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
        CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
        UIColor *color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
        
        NSInteger leftSpace = (arc4random() % 414) - (int)leftView.frame.origin.x;
        NSInteger topSpace = (arc4random() % 568) - (int)topView.frame.origin.y;
        
        UIView *newView = [[UIView alloc] init];
        newView.backgroundColor = color;
        [self.view addSubview:newView];
        [newView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_greaterThanOrEqualTo(0);
            make.right.mas_lessThanOrEqualTo(0);
            make.top.mas_greaterThanOrEqualTo(20);
            make.bottom.mas_lessThanOrEqualTo(-40);
            make.left.mas_equalTo(leftView).offset(leftSpace).priorityMedium();
            make.top.mas_equalTo(topView).offset(topSpace).priorityMedium();
            make.size.mas_equalTo(30);
        }];
        
        [self.views addObject:newView];
    }
    NSTimeInterval endTime = [NSDate timeIntervalSinceReferenceDate];
    
    NSTimeInterval timeInterval = endTime - startTime;
    
    NSMutableDictionary *autoLayoutDictionary = self.resultDictionary[@"AutoLayout"];
    NSMutableDictionary *currentTimesDictionary = autoLayoutDictionary[@(number)] ?: [[NSMutableDictionary alloc] init];
    NSNumber *times = currentTimesDictionary[@"times"] ? : @0;
    NSNumber *avgTime = currentTimesDictionary[@"avgTime"] ? : @0;
    currentTimesDictionary[@"avgTime"] = @((times.integerValue * avgTime.doubleValue + timeInterval) / (double)(times.integerValue + 1));
    currentTimesDictionary[@"times"] = @(times.integerValue + 1);
    [autoLayoutDictionary setObject:currentTimesDictionary forKey:@(number)];
    
    self.indicateLabel.text = [NSString stringWithFormat:@"%f", endTime-startTime];
}

- (void)generateFrameViews {
    NSInteger number = self.textField.text.integerValue;
    for (UIView *view in self.views) {
        [view removeFromSuperview];
    }
    [self.views removeAllObjects];
    
    NSTimeInterval startTime = [NSDate timeIntervalSinceReferenceDate];
    for (NSInteger i = 0; i < number; i++) {
        CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
        CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
        CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
        UIColor *color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
        
        NSInteger leftSpace = (arc4random() % 404) % (int)self.view.frame.size.width;
        NSInteger topSpace = (arc4random() % 676) % (int)self.view.frame.size.height + 20;
        
        UIView *newView = [[UIView alloc] init];
        newView.backgroundColor = color;
        newView.frame = CGRectMake(leftSpace, topSpace, 30, 30);
        [self.view addSubview:newView];
        [self.views addObject:newView];
    }
    NSTimeInterval endTime = [NSDate timeIntervalSinceReferenceDate];
    
    NSTimeInterval timeInterval = endTime - startTime;
    
    NSMutableDictionary *frameDictionary = self.resultDictionary[@"Frame"];
    NSMutableDictionary *currentTimesDictionary = frameDictionary[@(number)] ?: [[NSMutableDictionary alloc] init];
    NSNumber *times = currentTimesDictionary[@"times"] ? : @0;
    NSNumber *avgTime = currentTimesDictionary[@"avgTime"] ? : @0;
    currentTimesDictionary[@"avgTime"] = @((times.integerValue * avgTime.doubleValue + timeInterval) / (double)(times.integerValue + 1));
    currentTimesDictionary[@"times"] = @(times.integerValue + 1);
    [frameDictionary setObject:currentTimesDictionary forKey:@(number)];
    
    self.indicateLabel.text = [NSString stringWithFormat:@"%f", endTime-startTime];
}

- (void)generateNestedViews {
    NSInteger number = self.textField.text.integerValue;
    for (UIView *view in self.views) {
        [view removeFromSuperview];
    }
    [self.views removeAllObjects];
    
    NSTimeInterval startTime = [NSDate timeIntervalSinceReferenceDate];
    for (NSInteger i = 0; i < number; i++) {
        UIView *leftView = self.view;
        UIView *topView = self.view;
        if (self.views.count != 0) {
            NSInteger left = arc4random() % self.views.count;
            NSInteger top = arc4random() % self.views.count;
            leftView = self.views[left];
            topView = self.views[top];
        }
        
        CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
        CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
        CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
        UIColor *color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
        
        UIView *newView = [[UIView alloc] init];
        newView.backgroundColor = color;
        [self.view addSubview:newView];
        if (self.views.count == 0) {
            [self.view addSubview:newView];
            
            [newView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(0.5);
                make.top.mas_equalTo(20.5);
                make.bottom.mas_equalTo(-40.5);
                make.right.mas_equalTo(-0.5);
            }];
        } else {
            UIView *aView = self.views[i - 1];
            [aView addSubview:newView];
            
            [newView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.left.mas_equalTo(0.5);
                make.bottom.right.mas_equalTo(-0.5);
            }];
        }
        
        [self.views addObject:newView];
    }
    NSTimeInterval endTime = [NSDate timeIntervalSinceReferenceDate];
    
    NSTimeInterval timeInterval = endTime - startTime;
    
    NSMutableDictionary *autoLayoutDictionary = self.resultDictionary[@"NestedAutoLayout"];
    NSMutableDictionary *currentTimesDictionary = autoLayoutDictionary[@(number)] ?: [[NSMutableDictionary alloc] init];
    NSNumber *times = currentTimesDictionary[@"times"] ? : @0;
    NSNumber *avgTime = currentTimesDictionary[@"avgTime"] ? : @0;
    currentTimesDictionary[@"avgTime"] = @((times.integerValue * avgTime.doubleValue + timeInterval) / (double)(times.integerValue + 1));
    currentTimesDictionary[@"times"] = @(times.integerValue + 1);
    [autoLayoutDictionary setObject:currentTimesDictionary forKey:@(number)];
    
    self.indicateLabel.text = [NSString stringWithFormat:@"%f", endTime-startTime];
}

- (void)printerResult {
    NSLog(@"%@", self.resultDictionary);
}

- (void)singleTap:(UITapGestureRecognizer *)sender {
    [self.textField resignFirstResponder];
}

#pragma mark - getter & setter
- (UITextField *)textField {
    if (!_textField) {
        _textField = [[UITextField alloc] init];
        _textField.textAlignment = NSTextAlignmentCenter;
        _textField.keyboardType = UIKeyboardTypeNumberPad;
    }
    return _textField;
}

- (UILabel *)indicateLabel {
    if (!_indicateLabel) {
        _indicateLabel = [[UILabel alloc] init];
        _indicateLabel.textColor = [UIColor blackColor];
        _indicateLabel.textAlignment = NSTextAlignmentRight;
    }
    return _indicateLabel;
}

- (NSMutableArray *)views {
    if (!_views) {
        _views = [[NSMutableArray alloc] init];
    }
    return _views;
}

-(NSMutableDictionary *)resultDictionary {
    if (!_resultDictionary) {
        _resultDictionary = [[NSMutableDictionary alloc] init];
        [_resultDictionary setObject:[[NSMutableDictionary alloc] init] forKey:@"AutoLayout"];
        [_resultDictionary setObject:[[NSMutableDictionary alloc] init] forKey:@"NestedAutoLayout"];
        [_resultDictionary setObject:[[NSMutableDictionary alloc] init] forKey:@"Frame"];
        [_resultDictionary setObject:[[NSMutableDictionary alloc] init] forKey:@"ASDK"];
    }
    return _resultDictionary;
}

-(UIButton *)autoLayoutButton {
    if (!_autoLayoutButton) {
        _autoLayoutButton = [[UIButton alloc] init];
        [_autoLayoutButton setTitle:@"AutoLayout" forState:UIControlStateNormal];
        [_autoLayoutButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_autoLayoutButton addTarget:self
                              action:@selector(generateViews)
                    forControlEvents:UIControlEventTouchUpInside];
    }
    return _autoLayoutButton;
}

- (UIButton *)nestedButton {
    if (!_nestedButton) {
        _nestedButton = [[UIButton alloc] init];
        [_nestedButton setTitle:@"Nested" forState:UIControlStateNormal];
        [_nestedButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_nestedButton addTarget:self
                          action:@selector(generateNestedViews)
                forControlEvents:UIControlEventTouchUpInside];
    }
    return _nestedButton;
}

- (UIButton *)frameButton {
    if (!_frameButton) {
        _frameButton = [[UIButton alloc] init];
        [_frameButton setTitle:@"Frame" forState:UIControlStateNormal];
        [_frameButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_frameButton addTarget:self
                         action:@selector(generateFrameViews)
               forControlEvents:UIControlEventTouchUpInside];
    }
    return _frameButton;
}

- (UIButton *)printResult {
    if (!_printResult) {
        _printResult = [[UIButton alloc] init];
        [_printResult setTitle:@"PrintResult" forState:UIControlStateNormal];
        [_printResult setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_printResult addTarget:self
                         action:@selector(printerResult)
               forControlEvents:UIControlEventTouchUpInside];
    }
    return _printResult;
}

#pragma mark - status

- (BOOL)prefersStatusBarHidden {
    return YES;
}
@end
