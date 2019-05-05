 //
//  MGVideoPlayHelper.m
//  MiguDM
//
//  Created by wuzaifeng on 2017/8/8.
//  Copyright © 2017年 wuzaifeng. All rights reserved.
//

#import "MGVideoPlayHelper.h"
#import <AVFoundation/AVFoundation.h>

@implementation MGVideoPlayHelper

+ (BOOL)isLandscape:(NSString*)videoPath {
    CGSize videoSize = [MGVideoPlayHelper videoSizeFromVideoPath:videoPath];
    return videoSize.width > videoSize.height;
}

+ (CGSize)videoSizeFromVideoPath:(NSString *)videoPath {
    if (![[NSFileManager defaultManager] fileExistsAtPath:videoPath]) {
        return CGSizeZero;
    }
    
    AVURLAsset *asset = [AVURLAsset assetWithURL:[NSURL fileURLWithPath:videoPath]];
    AVAssetTrack *track = [[asset tracksWithMediaType:AVMediaTypeVideo] firstObject];
    CGSize dimensions = CGSizeApplyAffineTransform(track.naturalSize, track.preferredTransform);
    return CGSizeMake(fabs(dimensions.width), fabs(dimensions.height));
}


+ (NSTimeInterval)videoDurationFromVideoPath:(NSString *)videoPath {
    if (![[NSFileManager defaultManager] fileExistsAtPath:videoPath]) {
        return 0.00;
    }
    NSDictionary *inputOptions = [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:YES] forKey:AVURLAssetPreferPreciseDurationAndTimingKey];
    AVURLAsset *urlAsset = [AVURLAsset URLAssetWithURL:[NSURL fileURLWithPath:videoPath] options:inputOptions];
    return 1000.0 * urlAsset.duration.value / urlAsset.duration.timescale;
}

+ (UIImage *)getVideoCoverAtTime:(NSTimeInterval)time
                       videoPath:(NSString *)videoPath {
    if (videoPath.length == 0) {
        return nil;
    }
    UIImage *image = [self getVideoCoverAtTime:time videoPath:videoPath isSetTolerance:YES];
    if (!image) {
        image = [self getVideoCoverAtTime:time videoPath:videoPath isSetTolerance:NO];
    }
    return image;
}

+ (UIImage*)getVideoCoverAtTime:(NSTimeInterval)time
                      videoPath:(NSString *)videoPath
                 isSetTolerance:(BOOL)isSetTolerance {
    videoPath = videoPath ? videoPath : @"";
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:[NSURL fileURLWithPath:videoPath] options:nil];
    AVAssetImageGenerator *generator =[[AVAssetImageGenerator alloc] initWithAsset:asset];
    generator.appliesPreferredTrackTransform = YES;
    generator.apertureMode = AVAssetImageGeneratorApertureModeEncodedPixels;
    if (isSetTolerance) {
        generator.requestedTimeToleranceAfter = kCMTimeZero;
        generator.requestedTimeToleranceBefore = kCMTimeZero;
    }
    time *= 25;
    
    AVAssetTrack *videoTrack = [asset tracksWithMediaType:AVMediaTypeVideo].firstObject;
    NSArray<AVAssetTrackSegment *> *segs = videoTrack.segments;
    CMTime currentStartTime = kCMTimeZero;
    for (NSInteger i = 0; i < segs.count; i ++) {
        if (!segs[i].isEmpty) {
            currentStartTime = segs[i].timeMapping.target.start;
            break;
        }
    }
    CMTime startTime = CMTimeMake(time, 25);
    //如果想要获取的视频时间大于视频总时长 或者小于视频实际开始时间 则设置获取视频实际开始时间
    if (CMTimeCompare(startTime, asset.duration) == 1 || CMTimeCompare(startTime, currentStartTime) == -1) {
        startTime = currentStartTime;
    }

    NSError *thumbnailImageGenerationError = nil;
    CGImageRef thumbImgRef = [generator copyCGImageAtTime:startTime actualTime:NULL error:&thumbnailImageGenerationError];
    
    UIImage *thumbImg = thumbImgRef ? [[UIImage alloc] initWithCGImage:thumbImgRef] : [UIImage new];
    CGImageRelease(thumbImgRef);
    [generator cancelAllCGImageGeneration];
    return thumbImg;
}

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

@end
