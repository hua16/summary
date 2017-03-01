//
//  LHStrategyController.m
//  DesignPattern
//
//  Created by xulihua on 2017/2/6.
//  Copyright © 2017年 huage. All rights reserved.
//

#import "LHStrategyController.h"
#import "CashFactory.h"

@interface LHStrategyController ()

@property (nonatomic, assign) CGFloat total;

@property (weak, nonatomic) IBOutlet UITextField *priceTF;
@property (weak, nonatomic) IBOutlet UITextField *numTF;
@property (weak, nonatomic) IBOutlet UILabel *totalPriceLB;
@property (nonatomic, strong) CashFactory *cashFactory;

@end

@implementation LHStrategyController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
}

#pragma mark - event response

- (IBAction)makeSureButtonClick:(UIButton *)sender {
    CashFactory *context = [[CashFactory alloc] initWith:LHCashTypeNormal];
    CGFloat totalPrice = [context GetResult:[self.priceTF.text floatValue]*[self.numTF.text floatValue]];
    self.total += totalPrice;
    self.totalPriceLB.text = [NSString stringWithFormat:@"%.2f",self.total];
}

- (IBAction)resetButtonClick:(UIButton *)sender {
    self.priceTF.text = @"";
    self.numTF.text = @"";
    self.totalPriceLB.text = @"0.00";
}

@end
