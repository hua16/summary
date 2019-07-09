//
//  MGEffectFooterView.m
//  MiguC
//
//  Created by zaifeng wu on 2018/7/16.
//  Copyright © 2018年 咪咕动漫. All rights reserved.
//

#import "MGEffectFooterView.h"

@interface MGEffectFooterView ()

@property (weak, nonatomic) IBOutlet UIButton *cancelButton;

@property (weak, nonatomic) IBOutlet UIButton *doneButton;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation MGEffectFooterView

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.cancelButton setImage:[UIImage imageNamed:@"aiFilmingVideo_shot_close"] forState:UIControlStateNormal];
    [self.doneButton setImage:[UIImage imageNamed:@"aiFilmingVideo_shot_done"] forState:UIControlStateNormal];
    self.nameLabel.text = @"选择封面";
}

- (IBAction)cancelButtonAction:(id)sender {
    if (self.cancelBlock) {
        self.cancelBlock();
    }
}

- (IBAction)doneButtonAction:(id)sender {
    if (self.doneBlock) {
        self.doneBlock();
    }
} 

@end
