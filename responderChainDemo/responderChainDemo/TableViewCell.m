//
//  TableViewCell.m
//  responderChainDemo
//
//  Created by xulihua on 2017/8/17.
//  Copyright © 2017年 huage. All rights reserved.
//

#import "TableViewCell.h"
#import "ResponderChainDefine.h"
#import "UIResponder+Router.h"


NSString * const TestTableViewCellIdentifier = @"TableViewCell";

@implementation TableViewCell


- (IBAction)leftButtonClick:(UIButton *)sender {
    [self routerEventWithName:kTableViewCellEventTappedLeftButton userInfo:@{@"indexPath":self.indexPath}];
}

- (IBAction)middelButtonClick:(UIButton *)sender {
    [self routerEventWithName:kTableViewCellEventTappedMiddleButton userInfo:@{@"indexPath":self.indexPath}];
}

- (IBAction)rightButtonClick:(UIButton *)sender {
    [self routerEventWithName:kTableViewCellEventTappedRightButton userInfo:@{@"indexPath":self.indexPath}];
}

@end
