 //
//  MGVideoPlayHelper.m
//  MiguDM
//
//  Created by wuzaifeng on 2017/8/8.
//  Copyright © 2017年 wuzaifeng. All rights reserved.
//

#import "MGVideoPlayHelper.h"
#import <AVFoundation/AVFoundation.h>

@interface MGVideoPlayHelper ()

@end

@implementation MGVideoPlayHelper

+ (NSArray<UIImage *> *)generateThumbnailFromVideoPath:(NSString *)videoPath
                                            frameCount:(NSInteger)frameCount
                                         clipStartTime:(NSTimeInterval)clipStartTime
                                           clipEndTime:(NSTimeInterval)clipEndTime {
    if (frameCount == 0) {
        NSLog(@"error frameCount is equal to zero");
        return nil;
    }
    CGFloat videoDuration = clipEndTime -  clipStartTime;
    if (videoDuration <= 0) {
        NSLog(@"error videoDuration is less than zero");
        return nil;
    }
    CGFloat delayTime = videoDuration / frameCount;
    
    NSMutableArray *frameTimes = [[NSMutableArray alloc] initWithCapacity:frameCount];
    for (int currentFrame = 0; currentFrame < frameCount; currentFrame++) {
        CGFloat currentTime = (clipStartTime + currentFrame * delayTime) * 25;
        CMTime time = CMTimeMake(currentTime, 25);
        [frameTimes addObject:[NSValue valueWithCMTime:time]];
    }
    
    __block NSUInteger successCount = 0;
    NSMutableDictionary *imageDict = [NSMutableDictionary dictionary];
    dispatch_semaphore_t sema = dispatch_semaphore_create(0);
    
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:[NSURL fileURLWithPath:videoPath] options:nil];
    AVAssetImageGenerator *generator = [AVAssetImageGenerator assetImageGeneratorWithAsset:asset];
    generator.appliesPreferredTrackTransform = YES;
    [generator generateCGImagesAsynchronouslyForTimes:frameTimes
                                    completionHandler:^(CMTime requestedTime, CGImageRef  _Nullable cgImageRef, CMTime actualTime, AVAssetImageGeneratorResult result, NSError * _Nullable error) {
                                        if(result == AVAssetImageGeneratorSucceeded) {
                                            successCount ++;
                                            UIImage *image = [[UIImage alloc] initWithCGImage:cgImageRef scale:[UIScreen mainScreen].scale orientation:UIImageOrientationUp];
                                            
                                            for(int i = 0 ; i < frameTimes.count; i++){
                                                CMTime time = [[frameTimes objectAtIndex:i] CMTimeValue];
                                                if(CMTimeCompare(time , requestedTime) == 0){
                                                    [imageDict setObject:image forKey:@(i)];
                                                    break;
                                                }
                                            }
                                            
                                            if (successCount == frameTimes.count) {
                                                dispatch_semaphore_signal(sema);
                                            }
                                            
                                        } else {
                                            dispatch_semaphore_signal(sema);
                                        }
                                    }];
    
    dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
    [generator cancelAllCGImageGeneration];
    NSMutableArray *resultImages = [NSMutableArray arrayWithCapacity:imageDict.allKeys.count];
    for (NSInteger i = 0; i < imageDict.allKeys.count; i++) {
        UIImage *image = [imageDict objectForKey:@(i)];
        if (image) {
            [resultImages addObject:image];
        }
    }
    return [resultImages copy];
}

/**
 *  获取视频总时间（未播放）
 */
+ (NSTimeInterval)getVideoTotalTimeWithVideoPath:(NSURL *)videoPath {
    AVURLAsset *urlAsset = [AVURLAsset URLAssetWithURL:videoPath options:nil];
    return 1.0 * urlAsset.duration.value / urlAsset.duration.timescale;
} 

@end
