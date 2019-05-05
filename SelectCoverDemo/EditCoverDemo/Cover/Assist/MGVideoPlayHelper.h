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
