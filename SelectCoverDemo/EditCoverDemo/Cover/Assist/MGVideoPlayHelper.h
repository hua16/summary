//
//  MGVideoPlayHelper.h
//  MiguDM
//
//  Created by wuzaifeng on 2017/8/8.
//  Copyright © 2017年 wuzaifeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MGVideoPlayHelper : NSObject

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

/**
 *  根据时间，设置视频封面
 */
+ (UIImage*)getVideoCoverAtTime:(NSTimeInterval)time
                      videoPath:(NSString *)videoPath;

/**
 从视频中获取多张图片

 @param videoPath 本地视频地址
 @param frameCount 图片张数
 @param clipStartTime 视频开始时间
 @param clipEndTime 视频结束时间
 @return 图片数组
 */
+ (NSArray<UIImage *> *)generateThumbnailFromVideoPath:(NSString *)videoPath
                                            frameCount:(NSInteger)frameCount
                                         clipStartTime:(NSTimeInterval)clipStartTime
                                           clipEndTime:(NSTimeInterval)clipEndTime;

@end
