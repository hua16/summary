//
//  TableViewCell.h
//  responderChainDemo
//
//  Created by xulihua on 2017/8/17.
//  Copyright © 2017年 huage. All rights reserved.
//

#import <UIKit/UIKit.h>

FOUNDATION_EXTERN NSString * const TestTableViewCellIdentifier;

@interface TableViewCell : UITableViewCell

@property (nonatomic, strong) NSIndexPath *indexPath;

@end
