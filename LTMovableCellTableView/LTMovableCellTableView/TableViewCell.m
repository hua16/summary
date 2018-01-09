//
//  TableViewCell.m
//  LTMovableCellTableView
//
//  Created by xulihua on 2017/12/19.
//  Copyright © 2017年 huage. All rights reserved.
//

#import "TableViewCell.h"

@implementation TableViewCell


+ (NSString *)cellIdentifier {
    return @"TableViewCell";
}

- (void)prepareForReuse {
    [super prepareForReuse];
    self.hidden = NO;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
} 

@end
