//
//  UIView+SnapShot.m
//  LTMovableCellTableView
//
//  Created by xulihua on 2017/12/19.
//  Copyright © 2017年 huage. All rights reserved.
//

#import "UIView+Snapshot.h"

@implementation UIView (Snapshot)


- (UIView *)snapshotView {
    // Make an image from the input view.
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 0);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    // Create an image view.
    UIView *snapshot = [[UIImageView alloc] initWithImage:image]; 
    
    return snapshot;
}

@end
