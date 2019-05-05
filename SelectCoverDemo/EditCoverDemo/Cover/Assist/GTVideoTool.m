//
//  GTVideoTool.m
//  GTVideoLib
//
//  Created by gtv on 2018/3/14.
//  Copyright © 2018年 gtv. All rights reserved.
//
#import <AVFoundation/AVFoundation.h>

#import "GTVideoTool.h"

@implementation GTVideoTool

+ (BOOL)isLandscape:(NSString*)videoPath {
    CGSize videoSize = [GTVideoTool videoSizeFromVideoPath:videoPath];
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
 
@end
