//
//  GTVideoTool.h
//  GTVideoLib
//
//  Created by gtv on 2018/3/14.
//  Copyright © 2018年 gtv. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface GTVideoTool : NSObject

/**
 判断视频是否横屏

 @param videoPath 本地视频路径
 @return 横屏，返回YES,竖屏，返回NO
 */
+ (BOOL)isLandscape:(NSString*)videoPath; 


/**
 获取视频的分辨率

 @param videoPath 本地视频地址
 @return 视频分辨率
 */
+ (CGSize)videoSizeFromVideoPath:(NSString *)videoPath;
 

/**
 获取视频总时长

 @param videoPath 本地视频地址
 @return 视频总时长
 */
+ (NSTimeInterval)videoDurationFromVideoPath:(NSString *)videoPath;


@end
