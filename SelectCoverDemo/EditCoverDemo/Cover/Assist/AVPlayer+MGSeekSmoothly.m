//
//  AVPlayer+MGSeekSmoothly.m
//  MiguC
//
//  Created by 徐利华 on 2019/2/28.
//  Copyright © 2019年 咪咕动漫. All rights reserved.
//

#import "AVPlayer+MGSeekSmoothly.h"
#import <objc/runtime.h>
#import "MGEidtCoverConst.h"

@interface AVPlayerSeeker : NSObject

@property (nonatomic, assign) CMTime targetTime;

@property (nonatomic, assign) BOOL isSeeking;

@property (weak, nonatomic) AVPlayer *player;

@end

@implementation AVPlayerSeeker

- (instancetype)initWithPlayer:(AVPlayer *)player {
    self = [super init];
    if (self) {
        self.player = player;
    }
    return self;
}

- (void)seekSmoothlyToTime:(CMTime)time toleranceBefore:(CMTime)toleranceBefore toleranceAfter:(CMTime)toleranceAfter completionHandler:(void (^)(BOOL))completionHandler {
    self.targetTime = time;
    if (!self.isSeeking) {
        [self trySeekToTargetTimeWithToleranceBefore:toleranceBefore toleranceAfter:toleranceAfter completionHandler:completionHandler];
    }
}

- (void)trySeekToTargetTimeWithToleranceBefore:(CMTime)toleranceBefore toleranceAfter:(CMTime)toleranceAfter completionHandler:(void (^)(BOOL))completionHandler {
    if (self.player.currentItem.status == AVPlayerItemStatusReadyToPlay) {
        [self seekToTargetTimeToleranceBefore:toleranceBefore toleranceAfter:toleranceAfter completionHandler:completionHandler];
    }
}

- (void)seekToTargetTimeToleranceBefore:(CMTime)toleranceBefore toleranceAfter:(CMTime)toleranceAfter completionHandler:(void (^)(BOOL))completionHandler {
    self.isSeeking = YES;
    CMTime seekingTime = self.targetTime;
    @weakify(self)
    [self.player seekToTime:seekingTime toleranceBefore:toleranceBefore
             toleranceAfter:toleranceAfter completionHandler:
     ^(BOOL isFinished) {
         @strongify(self)
         if (CMTIME_COMPARE_INLINE(seekingTime, ==, self.targetTime)) {
             // seek completed
             self.isSeeking = NO;
             if (completionHandler) {
                 completionHandler(isFinished);
             }
         } else {
             // targetTime has changed, seek again
             [self trySeekToTargetTimeWithToleranceBefore:toleranceBefore toleranceAfter:toleranceAfter completionHandler:completionHandler];
         }
     }];
}

@end


static NSString *seekerKey = @"ss_seeker";

@implementation AVPlayer (MGSeekSmoothly)

- (void)ss_seekToTime:(CMTime)time {
    [self ss_seekToTime:time toleranceBefore:kCMTimeZero toleranceAfter:kCMTimeZero completionHandler:^(BOOL success) {
        
    }];
}

- (void)ss_seekToTime:(CMTime)time toleranceBefore:(CMTime)toleranceBefore toleranceAfter:(CMTime)toleranceAfter completionHandler:(void (^)(BOOL))completionHandler {
    
    AVPlayerSeeker *seeker = objc_getAssociatedObject(self, &seekerKey);
    if (!seeker) {
        seeker = [[AVPlayerSeeker alloc] initWithPlayer:self];
        objc_setAssociatedObject(self, &seekerKey, seeker, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
     
    [seeker seekSmoothlyToTime:time toleranceBefore:toleranceBefore toleranceAfter:toleranceAfter completionHandler:completionHandler];
}

@end
