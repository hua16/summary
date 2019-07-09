//
//  MGLocalVideoPlayerView.m
//  MiguC
//
//  Created by 徐利华 on 2019/2/27.
//  Copyright © 2019年 咪咕动漫. All rights reserved.
//

#import "MGLocalVideoPlayerView.h"
#import <AVFoundation/AVFoundation.h>
#import <Foundation/Foundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "AVPlayer+MGSeekSmoothly.h"
#import "MGVideoPlayHelper.h"
#import "LTCGUtilities.h"

typedef NS_ENUM(NSInteger, MGLocalVideoPlayerViewState) {
    MGLocalVideoPlayerViewStatePlaying = 0,   //播放中
    MGLocalVideoPlayerViewStateStop,          //停止播放，自己停的
    MGLocalVideoPlayerViewStatePause,         //暂停播放，手动停止
    MGLocalVideoPlayerViewStateFailed,        //播放失败
};

@interface MGLocalVideoPlayerView()

///播放器
@property (nonatomic, strong) AVPlayer *player;

///playerLayer
@property (nonatomic, strong) AVPlayerLayer *playerLayer;

///播放器item*
@property (nonatomic, strong) AVPlayerItem *playerItem;

///图片输出
@property (nonatomic) AVPlayerItemVideoOutput *playerOutput;

///播放状态
@property (nonatomic, assign) MGLocalVideoPlayerViewState state;

///视频本地地址
@property (nonatomic, copy) NSString *videoPath;

///视频总时长
@property (nonatomic, assign) NSTimeInterval videoDuration;

///seek时间点
@property (nonatomic, assign) NSTimeInterval lastSeekTime;

///正在seek
@property (nonatomic, assign) BOOL isSeeking;

///seek失败
@property (nonatomic, assign) BOOL isSeekFail;

@end

@implementation MGLocalVideoPlayerView

#pragma mark - life cycle

- (instancetype)initWithVideoPath:(NSString *)videoPath {
    self = [super init];
    if (self) {
        self.videoPath = videoPath;
        if (self.videoPath.length > 0) {
            
            NSDictionary* settings = @{ (id)kCVPixelBufferPixelFormatTypeKey : @(kCVPixelFormatType_32BGRA) };
            self.playerOutput = [[AVPlayerItemVideoOutput alloc] initWithPixelBufferAttributes:settings];
            self.playerItem = [AVPlayerItem playerItemWithURL:[NSURL fileURLWithPath:self.videoPath]];
            [self.playerItem addOutput:self.playerOutput];
            [self.playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
            
            self.player = [AVPlayer playerWithPlayerItem:self.playerItem];
            self.player.muted = YES;
            self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
            self.playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
            [self.layer addSublayer:self.playerLayer];
            
            self.videoDuration = [MGVideoPlayHelper getVideoTotalTimeWithVideoPath:[NSURL URLWithString:self.videoPath]];
            self.videoEndTime = self.videoDuration;
            [self addPlayerPeriodicTimeObserver];
        }
        
        [self addObserver];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.playerLayer.frame = self.bounds;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [_playerItem removeObserver:self forKeyPath:@"status"];
}

- (void)addPlayerPeriodicTimeObserver {
    @weakify(self)
    [self.player addPeriodicTimeObserverForInterval:CMTimeMake(1, 100)
                                              queue:nil
                                         usingBlock:^(CMTime time){
        @strongify(self);
         if (self.isSeeking) {
             return ;
         } 
                                             
         NSArray *loadedRanges = self.playerItem.seekableTimeRanges;
         if (loadedRanges.count > 0 && self.playerItem.duration.timescale != 0) {
             NSTimeInterval currentTime = CMTimeGetSeconds([self.playerItem currentTime]) * 1000;
             NSTimeInterval intervalTime = currentTime - self.lastSeekTime;
             if (self.loopIntervalTime > 0 && intervalTime >= self.loopIntervalTime) {
                 [self seekToTime:self.lastSeekTime];
             }
         } 
    }];
}

- (void)addObserver {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appDidEnterBackground:)
                                                 name:UIApplicationWillResignActiveNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(appDidEnterForeground:)
                                                 name:UIApplicationDidBecomeActiveNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(playerDidEnd)
                                                 name:AVPlayerItemDidPlayToEndTimeNotification
                                               object:self.playerItem];
}

#pragma mark - public method

- (void)play {
    [self.player play];
    self.playing = YES;
}

- (void)pause {
    [self.player pause];
    self.playing = NO;
}

- (void)seekToTime:(NSTimeInterval)time {
    [self seekToTime:time smoothly:YES];
}


- (void)seekToTime:(NSTimeInterval)time smoothly:(BOOL)isSmoothly{
    self.isSeeking = YES;
    [self seekToTime:time smoothly:isSmoothly toleranceBefore:kCMTimeZero toleranceAfter:kCMTimeZero completionHandler:^(BOOL success) { 
        self.isSeeking = NO; 
    }];
}

- (void)seekToTime:(NSTimeInterval)time
          smoothly:(BOOL)isSmoothly
      toleranceBefore:(CMTime)toleranceBefore
       toleranceAfter:(CMTime)toleranceAfter
 completionHandler:(void (^)(BOOL))completionHandler {
    self.lastSeekTime = time;
    if (self.player.status != AVPlayerStatusReadyToPlay) {
        self.isSeeking = NO;
        self.isSeekFail = YES;
        return;
    }
    self.isSeekFail = NO;
    
    CMTime draggedTime = CMTimeMake(time, 1000);
    
    if (isSmoothly) {
        [self.player ss_seekToTime:draggedTime toleranceBefore:toleranceBefore toleranceAfter:toleranceAfter completionHandler:completionHandler];
    } else {
        [self.player seekToTime:draggedTime toleranceBefore:toleranceBefore toleranceAfter:toleranceAfter completionHandler:completionHandler];
    }
}

- (CVPixelBufferRef)currentTimePixelBuffer {
    return [self.playerOutput copyPixelBufferForItemTime:self.playerItem.currentTime itemTimeForDisplay:NULL];
} 

#pragma mark - event response

- (void)appDidEnterBackground:(NSNotification *)note {
    [UIApplication sharedApplication].idleTimerDisabled = NO;
    [self pause];
}

- (void)appDidEnterForeground:(NSNotification *)note {
    [UIApplication sharedApplication].idleTimerDisabled = YES;
    [self play];
}

- (void)playerDidEnd {
    if (self.loop) {
        if (self.loopIntervalTime > 0) {
            [self seekToTime:self.lastSeekTime smoothly:YES];
            [self play];
        } else {
            [self seekToTime:self.videoStartTime smoothly:YES];
        }
    }
}

#pragma mark - observe
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"status"]) {
        switch (self.player.status) {
            case AVPlayerStatusUnknown:
                [self.player pause];
                break;
            case AVPlayerStatusReadyToPlay:
                if (self.isSeekFail) {
                    [self seekToTime:self.lastSeekTime smoothly:YES];
                }
                break;
            case AVPlayerStatusFailed:
                [self.player pause];
                break;
            default:
                [self.player pause];
                break;
        }
    }
}

#pragma mark - getter & setter
- (void)setVideoStartTime:(NSTimeInterval)videoStartTime {
    if (videoStartTime < 0) {
        _videoStartTime = 0;
    } else {
        _videoStartTime = videoStartTime;
    }
}

- (void)setVideoEndTime:(NSTimeInterval)videoEndTime {
    if (videoEndTime > self.videoDuration) {
        videoEndTime = self.videoDuration;
    }
    _videoEndTime = videoEndTime;
}

@end
