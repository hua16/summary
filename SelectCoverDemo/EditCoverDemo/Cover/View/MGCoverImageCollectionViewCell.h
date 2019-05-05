//
//  MGCoverImageCollectionViewCell.h
//  MiguDM
//
//  Created by wuzaifeng on 2018/4/3.
//  Copyright © 2018年 咪咕动漫. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface MGCoverImageCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UIImage *image;

/**
 *  注册cell
 */
+ (void)registerCellWithCollectionView:(UICollectionView *)collectionView;

/**
 *  根据重用id获取cell
 */
+ (MGCoverImageCollectionViewCell *)getCellWithCollectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;


/**
 更新cell内容

 @param operationQueue operation queue
 @param generator generator
 @param fileMd5 文件的md5值
 @param timestamp 时间点
 */ 
- (void)updateCellWithoperationQueue:(NSOperationQueue *)operationQueue
                           generator:(AVAssetImageGenerator *)generator
                             fileMd5:(NSString *)fileMd5
                           timestamp:(NSTimeInterval)timestamp;

@end
