//
//  HomeViewController.m
//  LTMovableCellTableView
//
//  Created by xulihua on 2017/12/19.
//  Copyright © 2017年 huage. All rights reserved.
//

#import "HomeViewController.h"

#import <Masonry/Masonry.h>

#import "TableViewCell.h"
#import "UIAlertView+RWBlock.h"
#import "UIView+Snapshot.h"
#import "CollectionViewCell.h"

@interface HomeViewController ()<UICollectionViewDelegate,
                                 UICollectionViewDataSource>
/**
 数据源
 */
@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) UIPageControl *pageControl;

@property (nonatomic, strong) UIView *snapshotView;

@property (nonatomic, strong) NSIndexPath *selectedIndexPath;

@property (nonatomic, strong) UITableView *currentTableView;

/**
 *  是否允许拖动到屏幕边缘后，开启边缘滚动，默认YES
 */
@property (nonatomic, assign) BOOL enableEdgeScroll;

/**
 *  边缘滚动触发范围，默认150
 */
@property (nonatomic, assign) CGFloat edgeScrollRange;


@property (nonatomic, strong) CADisplayLink *edgeScrollTimer;

@property (nonatomic, strong) UILongPressGestureRecognizer *longPress;

@property (nonatomic, assign) CGPoint previousPoint;

@end

@implementation HomeViewController
#pragma mark - life cycle

- (instancetype)init {
    self = [super init];
    if (self) {
        _edgeScrollRange = 150.0f;
        _enableEdgeScroll = YES;
    }
    return self;
}

-(void)awakeFromNib {
    [super awakeFromNib];
    _edgeScrollRange = 150.0f;
    _enableEdgeScroll = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configurePageView];
    [self addPageSubviews];
    [self layoutPageSubviews];
}

- (void)dealloc {
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

#pragma mark - UI & autolayout

- (void)configurePageView {
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressGestureRecognized:)];
    self.longPress = longPress;
    
    [self.collectionView addGestureRecognizer:longPress];
}

- (void)addPageSubviews {
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.pageControl];
}

- (void)layoutPageSubviews {
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
            make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
        } else {
            make.top.equalTo(self.view);
            make.bottom.equalTo(self.view);
        }
        make.leading.equalTo(self.view);
        make.trailing.equalTo(self.view);
    }];
    
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
        } else {
            make.bottom.equalTo(self.view);
        }
        make.height.mas_equalTo(30);
        make.leading.equalTo(self.view);
        make.trailing.equalTo(self.view);
    }];
}

#pragma mark - UICollectionViewDataSource

// 告诉系统一共多少组
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

// 告诉系统每组多少个
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 8;
}

// 告诉系统每个Cell如何显示
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[CollectionViewCell cellIdentifier] forIndexPath:indexPath];
    
    cell.contentView.backgroundColor = (indexPath.item % 2)?[UIColor blueColor]:[UIColor greenColor];
    return cell;
}

#pragma mark - event response


- (void)changePage:(UIPageControl *)sender {
    
    CGFloat x = self.pageControl.currentPage * CGRectGetWidth(self.collectionView.frame);
    [self.collectionView setContentOffset:CGPointMake(x, 0) animated:YES];
}

- (void)longPressGestureRecognized:(UILongPressGestureRecognizer *)sender {
    CGPoint location = [sender locationInView:sender.view];
    
    UIGestureRecognizerState state = sender.state;
    switch (state) {
        case UIGestureRecognizerStateBegan: {
            [self handleLongPressStateBeganWithLocation:location];
        }
            break;
            
        case UIGestureRecognizerStateChanged: {
            if (!self.enableEdgeScroll) {
                [self longGestureChanged:sender];
            }
        }
            break;
            
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled: {
            [self longGestureEndedOrCancelledWithLocation:location];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - long press

- (void)handleLongPressStateBeganWithLocation:(CGPoint)location {
    
    UITableView *tableView = [self currentTouchedTableViewWithLocation:location];
    
    CGPoint point = [self.collectionView convertPoint:location toView:tableView];
    NSIndexPath *indexPath = [tableView indexPathForRowAtPoint:point];
    
    if (!tableView || !indexPath) {
        return ;
    }
    
    self.selectedIndexPath = indexPath;
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:self.selectedIndexPath];
    
    self.snapshotView = [self currentSnapshotViewWithCell:cell];
    cell.hidden = YES;
    
    [self.collectionView addSubview:self.snapshotView];
  
    
    if (self.enableEdgeScroll) {
        //开启边缘滚动
        [self startPageEdgeScroll];
    }
    self.previousPoint = CGPointZero;
}



- (void)longGestureChanged:(UILongPressGestureRecognizer *)sender {
    CGPoint currentPoint = [sender locationInView:sender.view];
    
    UITableView *tableView = self.currentTableView;
    
    CGPoint point = [self.collectionView convertPoint:currentPoint toView:tableView];
    NSIndexPath *indexPath = [tableView indexPathForRowAtPoint:point];
    
    if (indexPath && ![self.selectedIndexPath isEqual:indexPath]) {

        [self.dataSource exchangeObjectAtIndex:indexPath.row withObjectAtIndex:self.selectedIndexPath.row];

        [tableView moveRowAtIndexPath:self.selectedIndexPath toIndexPath:indexPath];
        
         UITableViewCell *originalCell = [tableView cellForRowAtIndexPath:self.selectedIndexPath];
         originalCell.hidden = NO;
        
        self.selectedIndexPath = indexPath;
        
         UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:self.selectedIndexPath];
         selectedCell.hidden = YES;
    }
    
    
    if (!CGPointEqualToPoint(self.previousPoint,CGPointZero)) {
        
        CGPoint newCenter = self.snapshotView.center;
        newCenter.x += (currentPoint.x-self.previousPoint.x);
        newCenter.y += (currentPoint.y-self.previousPoint.y);
        self.snapshotView.center = newCenter;
    }
    
    
    self.previousPoint = currentPoint;
}

- (void)longGestureEndedOrCancelledWithLocation:(CGPoint)location {
    if (self.enableEdgeScroll) {
        [self stopEdgeScrollTimer];
    }
    
    UITableViewCell *selectedCell = [self.currentTableView cellForRowAtIndexPath:self.selectedIndexPath];
    
    [UIView animateWithDuration:0.25 animations:^{
        
        self.snapshotView.transform = CGAffineTransformIdentity;
        self.snapshotView.frame = [self snapshotViewFrameWithCell:selectedCell];
        
    } completion:^(BOOL finished) {
        
        selectedCell.hidden = NO;
        self.selectedIndexPath = nil;
        [self.snapshotView removeFromSuperview];
        self.snapshotView = nil;
    }];
    
}

#pragma mark - UIScrollViewDelegate

-(void) scrollViewDidEndDecelerating:(UIScrollView *)scrollView  {
    NSInteger pageNumber = roundf(scrollView.contentOffset.x / (scrollView.frame.size.width));
    self.pageControl.currentPage = pageNumber;
}


- (NSInteger)currentIndex {
    
    NSInteger index = 0;
    if (self.flowLayout.scrollDirection == UICollectionViewScrollDirectionHorizontal) {
        index = (self.collectionView.contentOffset.x + self.flowLayout.itemSize.width * 0.5) / self.flowLayout.itemSize.width;
    } else {
        index = (self.collectionView.contentOffset.y + self.flowLayout.itemSize.height * 0.5) / self.flowLayout.itemSize.height;
    }
    
    return MAX(0, index);
}

#pragma mark - page scroll

- (void)startPageEdgeScroll {
    self.edgeScrollTimer = [CADisplayLink displayLinkWithTarget:self selector:@selector(pageEdgeScrollEvent)];
    [self.edgeScrollTimer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)pageEdgeScrollEvent {
    [self longGestureChanged:self.longPress];
    
    UIScrollView *currentTableView = self.currentTableView;
    
    CGFloat contentOffsetY = currentTableView.contentOffset.y;
    
    CGFloat tableViewHeight = CGRectGetHeight(currentTableView.bounds);
    
    //最小偏移量
    CGFloat minOffsetY = contentOffsetY + self.edgeScrollRange;
    
    //最大偏移量
    CGFloat maxOffsetY = contentOffsetY + tableViewHeight - self.edgeScrollRange;
    
    //转换坐标
    CGPoint touchPoint = [self.collectionView convertPoint:self.snapshotView.center toView:currentTableView];
    
    //处理上下达到极限之后不再滚动tableView，其中处理了滚动到最边缘的时候，当前处于edgeScrollRange内，但是tableView还未显示完，需要显示完tableView才停止滚动
    //在顶部的滚动范围内
    
    if (touchPoint.y < self.edgeScrollRange) {
        //已滚动到最顶部，直接返回
        if (contentOffsetY < 1){
            return;
        }
        [self handleTableView:currentTableView isScrollToTop:YES];
        NSLog(@"pageEdgeScrollEvent 1");
        return;
    }
    
    //在底部的滚动范围内
    if (touchPoint.y > (currentTableView.contentSize.height-self.edgeScrollRange)) {
        
        if (contentOffsetY > (currentTableView.contentSize.height-tableViewHeight+CGRectGetHeight(self.snapshotView.frame))) {
            return;
        }
        
        [self handleTableView:currentTableView isScrollToTop:NO];
        NSLog(@"pageEdgeScrollEvent 2");
        return;
    }
    
    BOOL isNeedScrollToTop = touchPoint.y < minOffsetY;
    BOOL isNeedScrollToBottom = touchPoint.y > maxOffsetY;
    
    if (isNeedScrollToTop) {
        //tableView往上滚动
        [self handleTableView:currentTableView isScrollToTop:YES];
        NSLog(@"pageEdgeScrollEvent 3");
        
    } else if (isNeedScrollToBottom) {
        //tableView往下滚动
        [self handleTableView:currentTableView isScrollToTop:NO];
        NSLog(@"pageEdgeScrollEvent 4");
    } else {
        NSLog(@"pageEdgeScrollEvent 5");
    }
}



- (void)handleTableView:(UIScrollView *)tableView isScrollToTop:(BOOL)isScrollToTop {
    CGFloat distance = 3.0;
    if (isScrollToTop) {
        distance = -distance;
    }
    [tableView setContentOffset:CGPointMake(tableView.contentOffset.x, tableView.contentOffset.y + distance) animated:NO];
}

- (void)stopEdgeScrollTimer {
    if (self.edgeScrollTimer) {
        [self.edgeScrollTimer invalidate];
        self.edgeScrollTimer = nil;
    }
}

#pragma mark - private

- (UITableView *)currentTouchedTableViewWithLocation:(CGPoint)location {
    UITableView *tableView = nil;
    for (CollectionViewCell *collectionViewCell in self.collectionView.visibleCells) {
        if (CGRectContainsPoint(collectionViewCell.frame, location)) {
            tableView = collectionViewCell.tableView;
            self.currentTableView = tableView;
            break;
        }
    }
    return tableView;
}

- (UIView *)currentSnapshotViewWithCell:(UITableViewCell *)cell {
    UIView *snapshotView = [cell snapshotView];
    
    snapshotView.layer.shadowColor = [UIColor grayColor].CGColor;
    snapshotView.layer.masksToBounds = NO;
    snapshotView.layer.cornerRadius = 0;
    snapshotView.layer.shadowOffset = CGSizeMake(-5, 0);
    snapshotView.layer.shadowOpacity = 0.4;
    snapshotView.layer.shadowRadius = 5;
    
    snapshotView.frame = [self snapshotViewFrameWithCell:cell];
    snapshotView.transform = CGAffineTransformMakeRotation(M_PI_2/32);
    
    return snapshotView;
}

- (CGRect)snapshotViewFrameWithCell:(UITableViewCell *)cell {
    return [self.currentTableView convertRect:cell.frame toView:self.collectionView];
}

#pragma mark - getter & setter

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
        for (NSInteger section = 0; section < 1; section ++) {
            for (NSInteger row = 0; row < 30; row ++) {
                [_dataSource addObject:[NSString stringWithFormat:@"section -- %d row -- %d", section, row]];
            }
        }
    }
    return _dataSource;
}


- (UICollectionViewFlowLayout *)flowLayout {
    if (!_flowLayout) {
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _flowLayout.minimumLineSpacing = 0;
        
        _flowLayout.itemSize = CGSizeMake(320, 400);
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
//        _flowLayout.sectionInset = UIEdgeInsetsMake(10, 20, 30, 40);
        
        _flowLayout.minimumInteritemSpacing = 0;
//        _flowLayout.minimumLineSpacing = 50;
    }
    return _flowLayout;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        
        _collectionView =  [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.flowLayout];
        
        _collectionView.backgroundColor = [UIColor lightGrayColor];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        
        // 注册cell
        [_collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:[CollectionViewCell cellIdentifier]];
        
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO; 
        _collectionView.bounces = YES;
        _collectionView.pagingEnabled = YES;
    }
    return _collectionView;
}

- (UIPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectZero];
        _pageControl.numberOfPages = 8;
        [_pageControl addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
    }
    return _pageControl;
}


@end
