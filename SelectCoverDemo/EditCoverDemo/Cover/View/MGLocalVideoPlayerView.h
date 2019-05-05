//
//  MGLocalVideoPlayerView.h
//  MiguC
//
//  Created by 徐利华 on 2019/2/27.
//  Copyright © 2019年 咪咕动漫. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MGLocalVideoPlayerView : UIView

/**
是否支持重复播放，默认No
*/
@property (nonatomic, assign) BOOL loop;

/**
 循环间隔时间（单位ms）
 */
@property (nonatomic, assign) NSTimeInterval loopIntervalTime;

/**
 是否正在播放
 */
@property (nonatomic, getter=isPlaying, assign) BOOL playing;

/**
 视频开始时间（单位ms）
 */
@property (nonatomic, assign) NSTimeInterval videoStartTime;

/**
 视频结束时间（单位ms）
 */
@property (nonatomic, assign) NSTimeInterval videoEndTime;

/**
 类初始化方法
 
 @param videoPath 本地视频地址
 */
- (instancetype)initWithVideoPath:(NSString *)videoPath;

/**
 播放
 */
- (void)play;

/**
 暂停
 */
- (void)pause;

/**
 控制播放位置
 
 @param time 时间,单位为ms
 */
- (void)seekToTime:(NSTimeInterval)time;

/**
 控制播放位置
 
 @param time 时间,单位为ms
 @param isSmoothly 是否顺滑
 */
- (void)seekToTime:(NSTimeInterval)time smoothly:(BOOL)isSmoothly;

/**
 当前播放时间点图片

 @return CVPixelBufferRef对象
 */
- (CVPixelBufferRef)currentTimePixelBuffer; 

@end

NS_ASSUME_NONNULL_END
