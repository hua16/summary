//
//  MGVideoDisplayView.h
//  MiguC
//
//  Created by 徐利华 on 2019/3/4.
//  Copyright © 2019年 咪咕动漫. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GLKit/GLKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MGVideoDisplayView : UIView

- (void)displayPixelBuffer:(CVPixelBufferRef)pixelBuffer;

@end

NS_ASSUME_NONNULL_END
