//
//  MGCoverImageCollectionViewCell.m
//  MiguDM
//
//  Created by wuzaifeng on 2018/4/3.
//  Copyright © 2018年 咪咕动漫. All rights reserved.
//

#import "MGCoverImageCollectionViewCell.h"
#import <SDWebImage/SDImageCache.h>
#import "MGEidtCoverConst.h"

@interface MGCoverImageCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (nonatomic, assign) NSBlockOperation *operation;

@property (nonatomic, copy) NSString *imageKey;

@end

@implementation MGCoverImageCollectionViewCell

#pragma mark - class method
+ (void)registerCellWithCollectionView:(UICollectionView *)collectionView {
    NSString *cellIdentifier = NSStringFromClass([MGCoverImageCollectionViewCell class]);
    [collectionView registerNib:[UINib nibWithNibName:cellIdentifier bundle:nil] forCellWithReuseIdentifier:cellIdentifier];
}

+ (MGCoverImageCollectionViewCell *)getCellWithCollectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier = NSStringFromClass([MGCoverImageCollectionViewCell class]);
    MGCoverImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    return cell;
}

#pragma mark - life cycle
- (void)prepareForReuse {
    [super prepareForReuse];
    [self cancelOperation];
    self.imageKey = nil;
}

- (void)setImage:(UIImage *)image {
    _image = image;
    _imageView.image = image;
}

- (void)updateCellWithoperationQueue:(NSOperationQueue *)operationQueue
                           generator:(AVAssetImageGenerator *)generator
                             fileMd5:(NSString *)fileMd5
                           timestamp:(NSTimeInterval)timestamp {
    @weakify(self)
    timestamp *= 25;
    NSString *imageKey = [NSString stringWithFormat:@"http://MGCoverImageCollectionViewCell/%@/%lf",fileMd5,timestamp];
    UIImage *storeImage = [[SDImageCache sharedImageCache] imageFromCacheForKey:imageKey];
    if (storeImage) {
        self.imageView.image = storeImage;
        return;
    }
    
    if ([self.imageKey isEqualToString:imageKey]) {
        return;
    }
    
    [self cancelOperation];
    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
        CGImageRef thumbImgRef = [generator copyCGImageAtTime:CMTimeMake(timestamp, 25) actualTime:NULL error:nil];
        UIImage *thumbImg = thumbImgRef ? [[UIImage alloc] initWithCGImage:thumbImgRef] : [UIImage new];
        CGImageRelease(thumbImgRef);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            @strongify(self)
            self.imageView.image = thumbImg;
            [[SDImageCache sharedImageCache]  storeImage:thumbImg forKey:imageKey completion:NULL];
        });
    }];
    [operationQueue addOperation:operation];
    self.imageKey = imageKey;
    self.operation = operation;
}


#pragma mark - private method

- (void)cancelOperation {
    if (self.operation) {
        [self.operation cancel];
        self.operation = nil;
    }
}

@end
