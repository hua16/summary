//
//  AVPlayer+MGSeekSmoothly.h
//  MiguC
//
//  Created by 徐利华 on 2019/2/28.
//  Copyright © 2019年 咪咕动漫. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AVPlayer (MGSeekSmoothly)

- (void)ss_seekToTime:(CMTime)time;

- (void)ss_seekToTime:(CMTime)time
      toleranceBefore:(CMTime)toleranceBefore
       toleranceAfter:(CMTime)toleranceAfter
    completionHandler:(void (^)(BOOL))completionHandler;

@end

NS_ASSUME_NONNULL_END
