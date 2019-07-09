//
//  MGAIEditCoverViewController.m
//  MiguDM
//
//  Created by wuzaifeng on 2018/4/3.
//  Copyright © 2018年 咪咕动漫. All rights reserved.
//

#import "MGAIEditCoverViewController.h"
#import "MGCoverImageCollectionViewCell.h"
#import "MGVideoPlayHelper.h"
#import "MGEffectFooterView.h"
#import "MGLocalVideoPlayerView.h"
#import "MGVideoDisplayView.h"
#import "LTCGUtilities.h"
#import <Masonry/Masonry.h>

#define dragButtonWidth (kScreenWidth  - 24) / 8.0
@interface MGAIEditCoverViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

///网格视图
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

///动画视图
@property (weak, nonatomic) IBOutlet UIImageView *animationImagView;

///拖动按钮
@property (weak, nonatomic) IBOutlet UIButton *dragButton;

///手势视图
@property (weak, nonatomic) IBOutlet UIView *panView;

///滑块图片显示视图
@property (nonatomic, strong) MGVideoDisplayView *displayView;

///网格视图高度约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionViewHeightConst;

///拖动按钮右约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *dragButtonLeftConst;

///动画视图左约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *animationImagViewLeftConstraint;

///动画视图右约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *animationImageViewRightConstraint;

///底部视图
@property (nonatomic, strong) MGEffectFooterView *footerView;

///视频播放视图
@property (nonatomic, strong) MGLocalVideoPlayerView *playerView;

///封面时间回调
@property (nonatomic, copy) MGAIEditCoverTimeBlock coverTimeBlock;

///视频有效时长
@property (nonatomic, assign) CGFloat videoDuration;

///每秒时长对应的宽度
@property (nonatomic, assign) CGFloat widthPerSecond;

///封面对应时间
@property (nonatomic, assign) CGFloat coverTime;

///视频开始时间
@property (nonatomic, assign) CGFloat clipVideoStartTime;

///视频结束时间
@property (nonatomic, assign) CGFloat clipVideoEndTime;

///本地视频地址
@property (nonatomic, copy) NSString *videoPath;

///底部滑块图片数组
@property (nonatomic, copy) NSArray<UIImage *> *sliderImages;

///图片生成器
@property (nonatomic, strong) AVAssetImageGenerator *generator;

@end

@implementation MGAIEditCoverViewController

#pragma mark - class method

- (instancetype)initWithVideoPath:(NSString *)videoPath
                        coverTime:(CGFloat)coverTime
                   coverTimeBlock:(MGAIEditCoverTimeBlock)coverTimeBlock {
    self = [super init];
    if (self) {
        _videoPath = videoPath;
        _coverTime = coverTime;
        _coverTimeBlock = [coverTimeBlock copy];
    }
    return self;
}

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configurePageView];
    [self addPageSubViews];
    [self layoutPageSubviews];
    [self addPanGestureRecognizer];
    [self loadSliderImages];
    [self.playerView play];
    [self seekPlayerViewTo:self.coverTime generateImage:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.generator cancelAllCGImageGeneration];
}

- (void)configurePageView {
    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)]) {
        [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
    }
    self.view.backgroundColor = [UIColor blackColor];
    [MGCoverImageCollectionViewCell registerCellWithCollectionView:self.collectionView];
    self.panView.backgroundColor = [self colorWithHexString:@"07070D99"];
}

- (void)addPageSubViews {
    [self.view addSubview:self.footerView];
    self.dragButton.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.dragButton.imageView.clipsToBounds = YES;
    [self.view addSubview:self.playerView];
    [self.panView addSubview:self.displayView];
    
  
    self.clipVideoStartTime = 0;
    self.clipVideoEndTime = [MGVideoPlayHelper getVideoTotalTimeWithVideoPath:[NSURL fileURLWithPath:self.videoPath]];
    
    self.playerView.videoStartTime = self.clipVideoStartTime * 1000;
    self.playerView.videoEndTime = self.clipVideoEndTime * 1000;
    self.videoDuration = self.clipVideoEndTime - self.clipVideoStartTime;
    self.widthPerSecond = (kScreenWidth - 24.0 - dragButtonWidth) / (self.videoDuration - 1);
}

- (void)layoutPageSubviews {
    [self.footerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(55);
        make.bottom.mas_equalTo(-iPhoneXBottomOffset);
    }];
    
//    if ([GTVideoTool isLandscape:self.videoPath]) {
//        self.animationImagViewLeftConstraint.constant = 0;
//        self.animationImageViewRightConstraint.constant = 0;
//        self.animationImagView.contentMode = UIViewContentModeScaleAspectFit;
//    }
    
    [self.playerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.animationImagView);
    }];
    
    self.collectionViewHeightConst.constant = 160 + iPhoneXBottomOffset;
    
    self.dragButtonLeftConst.constant = self.widthPerSecond * self.coverTime; 
    
    [self.displayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.dragButton).offset(1);
        make.bottom.equalTo(self.dragButton).offset(-1);
        make.leading.equalTo(self.dragButton).offset(1);
        make.trailing.equalTo(self.dragButton).offset(-1);
    }]; 
}

- (void)loadSliderImages {
    @weakify(self)
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        @strongify(self)
        self.sliderImages = [MGVideoPlayHelper generateThumbnailFromVideoPath:self.videoPath frameCount:10 clipStartTime:self.clipVideoStartTime clipEndTime:self.clipVideoEndTime];
        UIImage *converImage = [self getVideoImageAtTime:(self.coverTime + self.clipVideoStartTime)];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collectionView reloadData];
            [self.dragButton setImage:converImage forState:UIControlStateNormal];
        });
    });
}

- (void)addPanGestureRecognizer {
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
    [self.panView addGestureRecognizer:panGesture];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureAction:)];
    [self.panView addGestureRecognizer:tapGesture];
    
    [tapGesture requireGestureRecognizerToFail:panGesture];
} 

- (void)backButtonAction:(id)sender {
    [self dismissViewControllerWithCompletion:NULL];
}

#pragma mark - Private

- (void)dismissViewControllerWithCompletion:(void (^ __nullable)(void))completion {
    CATransition *transition = [CATransition animation];
    transition.duration = 0.25;
    transition.timingFunction = [CAMediaTimingFunction
                                 functionWithName:kCAMediaTimingFunctionEaseIn];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromLeft;
    [self.view.window.layer addAnimation:transition forKey:nil];
    [self dismissViewControllerAnimated:NO completion:completion];
}

#pragma mark - UICollectionViewDataSource & UICollectionViewDelegateFlowLayout

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.sliderImages.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MGCoverImageCollectionViewCell *cell = [MGCoverImageCollectionViewCell getCellWithCollectionView:collectionView cellForItemAtIndexPath:indexPath];
    cell.image = self.sliderImages[indexPath.row];
    return cell;
}
 
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(1.0 * (kScreenWidth - 24) / self.sliderImages.count, 60);
}

#pragma mark - event response

- (void)panAction:(UIPanGestureRecognizer *)sender {
    CGPoint point = [sender locationInView:self.panView];
    switch (sender.state) {
        case UIGestureRecognizerStateBegan: {
            [self.playerView pause];
        }
            break;
        case UIGestureRecognizerStateChanged: {
            if (point.x < 12) {
                point.x = 12;
            }
            if (point.x > kScreenWidth - 12 - dragButtonWidth) {
                point.x = kScreenWidth - 12 - dragButtonWidth;
            }
            [self changeDragButtonLeftConst:point.x];
            
            CGFloat time = (point.x - 12) / self.widthPerSecond;
            [self seekPlayerViewTo:time generateImage:NO];
        }
            break;
        case UIGestureRecognizerStateEnded: {
            if (point.x < 12) {
                point.x = 12;
            }
            if (point.x > kScreenWidth - 12 - dragButtonWidth) {
                point.x = kScreenWidth - 12 - dragButtonWidth;
            }
            CGFloat time = (point.x - 12) / self.widthPerSecond;
            [self seekPlayerViewTo:time generateImage:YES];
            [self scrollEndLoadImagesWithTime:time];
        }
            break;
        case UIGestureRecognizerStateCancelled: {
            [self.playerView play];
        }
            break;
        default:
            break;
    }
}

- (void)tapGestureAction:(UITapGestureRecognizer *)sender {
    CGPoint point = [sender locationInView:self.panView];
    if (point.x < 12) {
        point.x = 12;
    }
    if (point.x > kScreenWidth - 12 - dragButtonWidth) {
        point.x = kScreenWidth - 12 - dragButtonWidth;
    }
    [self changeDragButtonLeftConst:point.x];
    CGFloat time = (point.x - 12) / self.widthPerSecond;
    [self seekPlayerViewTo:time generateImage:YES];
    [self scrollEndLoadImagesWithTime:time];
}

#pragma mark - private method

- (void)seekPlayerViewTo:(CGFloat)time generateImage:(BOOL)isGenerateImage {
    if (self.videoDuration - time < 1) {
        time = self.videoDuration - 1;
    }
    [self.playerView seekToTime:(time + self.clipVideoStartTime)*1000 smoothly:YES];
    
    if (isGenerateImage) {
        self.generator.requestedTimeToleranceBefore = kCMTimeZero;
        self.generator.requestedTimeToleranceAfter = kCMTimeZero;
        UIImage *image = [self getVideoImageAtTime:(time + self.clipVideoStartTime)];
        if (image) {
            self.displayView.hidden = YES;
            [self.dragButton setImage:image forState:UIControlStateNormal];
            return;
        }
    }
    
   CVPixelBufferRef buffer = [self.playerView currentTimePixelBuffer];
    
    if (buffer) {
        if (self.displayView.hidden) {
            self.displayView.hidden = NO;
        }
        [self.displayView displayPixelBuffer:buffer];
        CVPixelBufferRelease(buffer);
    }
}

- (void)scrollEndLoadImagesWithTime:(CGFloat)time {
    if (self.videoDuration - time < 1) {
        time = self.videoDuration - 1;
    }
    self.coverTime = time;
    [self.playerView play];
}

- (void)changeDragButtonLeftConst:(CGFloat)left { 
    self.dragButtonLeftConst.constant = left - 12;
}

- (UIImage *)getVideoImageAtTime:(NSTimeInterval)time {
    NSTimeInterval timestamp = time * 25;
    NSError *thumbnailImageGenerationError = nil;
    CGImageRef thumbImgRef = [self.generator copyCGImageAtTime:CMTimeMake(timestamp, 25) actualTime:NULL error:&thumbnailImageGenerationError];
    
    UIImage *thumbImg = thumbImgRef ? [[UIImage alloc] initWithCGImage:thumbImgRef] : [UIImage new];
    CGImageRelease(thumbImgRef);
    return thumbImg;
}

#pragma mark - system

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (UIColor *)colorWithHexString:(NSString *)hexStr {
    CGFloat r, g, b, a;
    if (hexStrToRGBA(hexStr, &r, &g, &b, &a)) {
        return [UIColor colorWithRed:r green:g blue:b alpha:a];
    }
    return nil;
}

#pragma mark - getter & setter

- (MGEffectFooterView *)footerView {
    if (!_footerView) {
        _footerView = [[[NSBundle mainBundle] loadNibNamed:@"MGEffectFooterView" owner:self options:nil] firstObject]; 
       
        @weakify(self)
        _footerView.cancelBlock = ^{
            @strongify(self)
            [self backButtonAction:nil];
        };
        
        _footerView.doneBlock = ^{
            @strongify(self)
            if (self.coverTimeBlock) {
                self.coverTimeBlock(self.coverTime);
            }
            [self dismissViewControllerAnimated:YES completion:NULL];
        };
    }
    return _footerView;
}

- (MGLocalVideoPlayerView *)playerView {
    if (!_playerView) {
        _playerView = [[MGLocalVideoPlayerView alloc] initWithVideoPath:self.videoPath];
        _playerView.loop = YES;
        _playerView.loopIntervalTime = 1000;
    }
    return _playerView;
}

- (MGVideoDisplayView *)displayView {
    if (!_displayView) {
        _displayView = [[MGVideoDisplayView alloc] init];
    }
    return _displayView;
}

- (AVAssetImageGenerator *)generator {
    if (!_generator) {
        AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:[NSURL fileURLWithPath:self.videoPath] options:nil];
        _generator = [[AVAssetImageGenerator alloc] initWithAsset:asset];
        _generator.appliesPreferredTrackTransform = YES;
        _generator.apertureMode = AVAssetImageGeneratorApertureModeEncodedPixels;
    }
    return _generator;
}
    
    
@end
    
    
