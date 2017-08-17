//
//  ViewController.m
//  1简单工厂模式
//
//  Created by huage on 15/8/10.
//  Copyright (c) 2015年 huage. All rights reserved.
//

#import "ViewController.h"
#import "LHCalcuteFactory.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *numberA;
@property (weak, nonatomic) IBOutlet UITextField *countTextField;
@property (weak, nonatomic) IBOutlet UITextField *numberB;
@property (weak, nonatomic) IBOutlet UILabel *resultTextfield;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


- (IBAction)calculate:(id)sender {
    //test是实例
    LHCalcuteFactory *test = [LHCalcuteFactory new];
    [test createCalcute:self.countTextField.text];
    [test test];
    //test实例不能去调用类方法
    
    LHBaseCalculate<LHCalculate> * cal =[LHCalcuteFactory createCalcute:self.countTextField.text];
    cal.numberA = [self.numberA.text floatValue];
    cal.numberB = [self.numberB.text floatValue];
    CGFloat result =  [cal calculate];
    //NSLog(@"结%@")
    self.resultTextfield.text = [@(result) stringValue];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
