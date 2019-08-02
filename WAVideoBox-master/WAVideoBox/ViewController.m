//
//  ViewController.m
//  WAVideoBox
//
//  Created by 黄锐灏 on 2019/1/6.
//  Copyright © 2019 黄锐灏. All rights reserved.
//

#import "ViewController.h"
#import "WAVideoBox.h"
#import "PlayViewController.h"
@interface ViewController ()

@property (nonatomic , copy) NSString *videoPath;

@property (nonatomic , copy) NSString *testOnePath;

@property (nonatomic , copy) NSString *testTwoPath;

@property (nonatomic , copy) NSString *testThreePath;

@property (nonatomic , strong) WAVideoBox *videoBox;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - event response

/** 裁剪 */
- (IBAction)rangeVideo:(id)sender { 
    [self.videoBox clean];
    NSString *filePath = [self buildFilePath];
    __weak typeof(self) wself = self;
    
    [self.videoBox appendVideoByPath:self.videoPath];
    [self.videoBox rangeVideoByTimeRange:CMTimeRangeMake(CMTimeMake(3600, 600), CMTimeMake(3600, 600))];
    
    [self.videoBox asyncFinishEditByFilePath:filePath complete:^(NSError *error) {
        if (!error) {
            [wself goToPlayVideoByFilePath:filePath];
        }
    }];
}

/** 压缩 */
- (IBAction)compressVideo:(id)sender {
    
    [self.videoBox clean];
    NSString *filePath = [self buildFilePath];
    __weak typeof(self) wself = self;
    
    [self.videoBox appendVideoByPath:self.videoPath];
    self.videoBox.ratio = WAVideoExportRatio960x540;
    self.videoBox.videoQuality = 1; // 有两种方法可以压缩
    [self.videoBox asyncFinishEditByFilePath:filePath complete:^(NSError *error) {
        if (!error) {
            [wself goToPlayVideoByFilePath:filePath];
        }
        wself.videoBox.ratio = WAVideoExportRatio960x540;
        wself.videoBox.videoQuality = 0;
    }];
}

/** 水印 */
- (IBAction)addWaterMark:(id)sender {
    [self.videoBox clean];
    NSString *filePath = [self buildFilePath];
    __weak typeof(self) wself = self;
    
    [self.videoBox appendVideoByPath:self.videoPath];
    [self.videoBox appendImages:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"gifTest" ofType:@"gif"]]  relativeRect:CGRectMake(0.6, 0.2, 0.3, 0)];
    
    [self.videoBox asyncFinishEditByFilePath:filePath progress:^(float progress) {
        NSLog(@"progress -- %f",progress);
    } complete:^(NSError *error) {
        if (!error) {
            [wself goToPlayVideoByFilePath:filePath];
        }
    }];
}

/** 旋转 */
- (IBAction)rotateVideo:(id)sender {
    
    [self.videoBox clean];
    NSString *filePath = [self buildFilePath];
    __weak typeof(self) wself = self;
    
    [self.videoBox appendVideoByPath:self.videoPath];
    [self.videoBox rotateVideoByDegress:90];
    [self.videoBox asyncFinishEditByFilePath:filePath complete:^(NSError *error) {
        if (!error) {
            [wself goToPlayVideoByFilePath:filePath];
        }
    }];
}

/** 换音 */
- (IBAction)replaceVideo:(id)sender {
    
    [self.videoBox clean];
    NSString *filePath = [self buildFilePath];
    __weak typeof(self) wself = self;
    
    [self.videoBox appendVideoByPath:self.videoPath];
    [self.videoBox replaceSoundBySoundPath:self.testOnePath];
    
    [self.videoBox asyncFinishEditByFilePath:filePath complete:^(NSError *error) {
        if (!error) {
            [wself goToPlayVideoByFilePath:filePath];
        }
    }];
}

/** 合并 */
- (IBAction)mixVideo:(id)sender {
    
    [self.videoBox clean];
    NSString *filePath = [self buildFilePath];
    __weak typeof(self) wself = self;
    
    [self.videoBox appendVideoByPath:self.testThreePath];
    [self.videoBox appendVideoByPath:self.testTwoPath];
    
    [self.videoBox asyncFinishEditByFilePath:filePath complete:^(NSError *error) {
        if (!error) {
            [wself goToPlayVideoByFilePath:filePath];
        }
    }];
}

/** 混音 */
- (IBAction)mixSound:(id)sender {
    
    [self.videoBox clean];
    NSString *filePath = [self buildFilePath];
    __weak typeof(self) wself = self;
    
    [self.videoBox appendVideoByPath:self.videoPath];
    [self.videoBox dubbedSoundBySoundPath:self.testThreePath];
    
    [self.videoBox asyncFinishEditByFilePath:filePath complete:^(NSError *error) {
        if (!error) {
            [wself goToPlayVideoByFilePath:filePath];
        }
    }];
    
}

/** 变速 */
- (IBAction)gearVideo:(id)sender {
    [self.videoBox clean];
    NSString *filePath = [self buildFilePath];
    __weak typeof(self) wself = self;
    
    [self.videoBox appendVideoByPath:self.videoPath];
    [self.videoBox gearBoxWithScale:3];
    
    [self.videoBox asyncFinishEditByFilePath:filePath complete:^(NSError *error) {
        if (!error) {
            [wself goToPlayVideoByFilePath:filePath];
        }
    }];
}

/** 混合操作 */
- (IBAction)composeEdit:(id)sender {
    [self.videoBox clean];
    NSString *filePath = [self buildFilePath];
    __weak typeof(self) wself = self;
    
    // 将1号拼接到video，用2号的音频替换，给视频加一个水印，旋转180度，混上3号的音,速度加快两倍，把生好的视频裁6-12秒，压缩
    [self.videoBox appendVideoByPath:self.videoPath];
    [self.videoBox appendVideoByPath:self.testThreePath];
    [self.videoBox replaceSoundBySoundPath:self.testTwoPath];
    [self.videoBox appendWaterMark:[UIImage imageNamed:@"waterMark"] relativeRect:CGRectMake(0.7, 0.2, 0.2, 0)];
    
    [self.videoBox rotateVideoByDegress:180];
    [self.videoBox dubbedSoundBySoundPath:self.testOnePath];
    [self.videoBox gearBoxWithScale:2];
    
    [self.videoBox rangeVideoByTimeRange:CMTimeRangeMake(CMTimeMake(2400, 600), CMTimeMake(3600, 600))];
    
    [self.videoBox asyncFinishEditByFilePath:filePath progress:^(float progress) {
        NSLog(@"progress --- %f",progress);
    }  complete:^(NSError * error) {
        if (!error) {
            [wself goToPlayVideoByFilePath:filePath];
        }
    }];
}

/** 骚操作 */
- (IBAction)magicEdit:(id)sender {
    [self.videoBox clean];
    NSString *filePath = [self buildFilePath];
    __weak typeof(self) wself = self;
    
    // 放入原视频，换成1号的音，再把3号视频放入混音,剪其中8秒
    // 拼1号视频，给1号水印,剪其中8秒
    // 拼2号视频，给2号变速
    // 拼3号视频，旋转180,剪其中8秒
    // 把最后的视频再做一个变速
    [self.videoBox appendVideoByPath:self.videoPath];
    [self.videoBox replaceSoundBySoundPath:self.testOnePath];
    [self.videoBox dubbedSoundBySoundPath:self.testThreePath];
    [self.videoBox rangeVideoByTimeRange:CMTimeRangeMake(kCMTimeZero, CMTimeMake(3600, 600))];
    
    [self.videoBox appendVideoByPath:self.testOnePath];
    [self.videoBox appendWaterMark:[UIImage imageNamed:@"waterMark"] relativeRect:CGRectMake(0.7, 0.2, 0.2, 0)];
    [self.videoBox rangeVideoByTimeRange:CMTimeRangeMake(CMTimeMake(3600, 600), CMTimeMake(3600, 600))];
    
    [self.videoBox appendVideoByPath:self.testTwoPath];
    [self.videoBox gearBoxWithScale:2];
    
    [self.videoBox appendVideoByPath:self.testThreePath];
    [self.videoBox rotateVideoByDegress:180];
    [self.videoBox rangeVideoByTimeRange:CMTimeRangeMake(kCMTimeZero, CMTimeMake(3600, 600))];
    
    [self.videoBox commit];
    [self.videoBox gearBoxWithScale:2];
    
    [self.videoBox asyncFinishEditByFilePath:filePath progress:^(float progress) {
        NSLog(@"progress --- %f",progress);
    }  complete:^(NSError * error) {
        if (!error) {
            [wself goToPlayVideoByFilePath:filePath];
        }
    }];
}

- (IBAction)natureVideo:(id)sender {
     [self goToPlayVideoByFilePath:self.videoPath];
}

- (IBAction)playTest1:(id)sender {
    [self goToPlayVideoByFilePath:self.testOnePath];
}

- (IBAction)playTest2:(id)sender {
    [self goToPlayVideoByFilePath:self.testTwoPath];
}

- (IBAction)playTest3:(id)sender {
    [self goToPlayVideoByFilePath:self.testThreePath];
}

#pragma mari private method

- (NSString *)buildFilePath{
    return [NSTemporaryDirectory() stringByAppendingString:[NSString stringWithFormat:@"%f.mp4", [[NSDate date] timeIntervalSinceReferenceDate]]];
}

- (void)goToPlayVideoByFilePath:(NSString *)filePath{
    PlayViewController *playVc = [PlayViewController new];
    [playVc loadWithFilePath:filePath];
    [self.navigationController pushViewController:playVc animated:YES];
}

#pragma mark - getter & setter

- (WAVideoBox *)videoBox {
    if (!_videoBox) {
        _videoBox = [[WAVideoBox alloc] init];
    }
    return _videoBox;
}

- (NSString *)videoPath {
    if (!_videoPath) {
        _videoPath = [[NSBundle mainBundle] pathForResource:@"nature.mp4" ofType:nil];
    }
    return _videoPath;
}

- (NSString *)testOnePath {
    if (!_testOnePath) {
        _testOnePath = [[NSBundle mainBundle] pathForResource:@"test1.mp4" ofType:nil];
    }
    return _testOnePath;
}

- (NSString *)testTwoPath {
    if (!_testTwoPath) {
        _testTwoPath = [[NSBundle mainBundle] pathForResource:@"test2.mp4" ofType:nil];
    }
    return _testTwoPath;
}

- (NSString *)testThreePath {
    if (!_testThreePath) {
        _testThreePath = [[NSBundle mainBundle] pathForResource:@"test3.mp4" ofType:nil];
    }
    return _testThreePath;
}

@end
