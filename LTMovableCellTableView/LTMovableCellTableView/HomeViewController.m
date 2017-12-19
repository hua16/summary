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

@interface HomeViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIView *snapshotView;

@property (nonatomic, strong) NSIndexPath *selectedIndexPath;

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
    
    [self.tableView addGestureRecognizer:longPress];
}

- (void)addPageSubviews {
    [self.view addSubview:self.tableView];
}

- (void)layoutPageSubviews {
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
            make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
        } else {
            make.top.equalTo(self.view);
            make.bottom.equalTo(self.view);
        }
        make.leading.equalTo(self.view).offset(20);
        make.trailing.equalTo(self.view).offset(-20);
    }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[TableViewCell cellIdentifier] forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = self.dataSource[indexPath.row];
    return cell;
}

#pragma mark - event response

- (void)longPressGestureRecognized:(UILongPressGestureRecognizer *)sender {
    CGPoint location = [sender locationInView:sender.view];
    
    UIGestureRecognizerState state = sender.state;
    switch (state) {
        case UIGestureRecognizerStateBegan: {
            [self longGestureBeganAtLocation:location];
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
            [self longGestureEndedOrCancelled];
        }
            break;
            
        default:
            break;
    }
}

- (void)longGestureBeganAtLocation:(CGPoint)location {
    self.selectedIndexPath = [self.tableView indexPathForRowAtPoint:location];
    if (!self.selectedIndexPath) {
        return;
    }
    
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:self.selectedIndexPath];
    
    self.snapshotView = [cell snapshotView];
    cell.hidden = YES;
    self.snapshotView.layer.shadowColor = [UIColor grayColor].CGColor;
    self.snapshotView.layer.masksToBounds = NO;
    self.snapshotView.layer.cornerRadius = 0;
    self.snapshotView.layer.shadowOffset = CGSizeMake(-5, 0);
    self.snapshotView.layer.shadowOpacity = 0.4;
    self.snapshotView.layer.shadowRadius = 5;
    
    
    self.snapshotView.frame = cell.frame;
    
    [self.tableView addSubview:self.snapshotView];
    self.snapshotView.transform = CGAffineTransformMakeRotation(M_PI_2/32);
    
    [UIView animateWithDuration:0.25 animations:^{
        self.snapshotView.center = CGPointMake(self.snapshotView.center.x, location.y);
    }];
    
    if (self.enableEdgeScroll) {
        //开启边缘滚动
        [self startPageEdgeScroll];
    }
}


- (void)longGestureChanged:(UILongPressGestureRecognizer *)sender {
    CGPoint location = [sender locationInView:sender.view];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:location];
    
     if (indexPath && ![self.selectedIndexPath isEqual:indexPath]) {
        
        [self.dataSource exchangeObjectAtIndex:indexPath.row withObjectAtIndex:self.selectedIndexPath.row];
        
        [self.tableView moveRowAtIndexPath:self.selectedIndexPath toIndexPath:indexPath];
         
         UITableViewCell *originalCell = [self.tableView cellForRowAtIndexPath:self.selectedIndexPath];
         originalCell.hidden = NO;
         
        self.selectedIndexPath = indexPath;
         
         UITableViewCell *selectedCell = [self.tableView cellForRowAtIndexPath:self.selectedIndexPath];
         selectedCell.hidden = YES;
     }
    
    self.snapshotView.center = CGPointMake(self.snapshotView.center.x, location.y);
}

- (void)longGestureEndedOrCancelled {
    if (self.enableEdgeScroll) {
        [self stopEdgeScrollTimer];
    }
    
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:self.selectedIndexPath];
    
    [UIView animateWithDuration:0.25 animations:^{
        
        self.snapshotView.transform = CGAffineTransformIdentity;
        self.snapshotView.frame = cell.frame;
        
    } completion:^(BOOL finished) {
        
        cell.hidden = NO;
        self.selectedIndexPath = nil;
        [self.snapshotView removeFromSuperview];
        self.snapshotView = nil;
    }];
}

#pragma mark - private

- (void)startPageEdgeScroll {
    self.edgeScrollTimer = [CADisplayLink displayLinkWithTarget:self selector:@selector(pageEdgeScrollEvent)];
    [self.edgeScrollTimer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)pageEdgeScrollEvent {
    [self longGestureChanged:self.longPress];
    
    UITableView *currentTableView = self.tableView;
    
    CGFloat contentOffsetY = currentTableView.contentOffset.y;
    
    CGFloat tableViewHeight = CGRectGetHeight(currentTableView.bounds);
    
    //最小偏移量
    CGFloat minOffsetY = contentOffsetY + self.edgeScrollRange;
    
    //最大偏移量
    CGFloat maxOffsetY = contentOffsetY + tableViewHeight - self.edgeScrollRange;
    
    CGPoint touchPoint = self.snapshotView.center;
    
    //处理上下达到极限之后不再滚动tableView，其中处理了滚动到最边缘的时候，当前处于edgeScrollRange内，但是tableView还未显示完，需要显示完tableView才停止滚动
    
    //在顶部的滚动范围内
    if (touchPoint.y < self.edgeScrollRange) {
        //已滚动到最顶部，直接返回
        if (contentOffsetY < 1){
            return;
        }
        [self handleTableView:currentTableView isScrollToTop:YES];
        return;
    }
    
    //在底部的滚动范围内
    if (touchPoint.y > (currentTableView.contentSize.height-self.edgeScrollRange)) {
        
        if (contentOffsetY > (currentTableView.contentSize.height-tableViewHeight-1)) {
            return;
        }
        
        [self handleTableView:currentTableView isScrollToTop:NO];
        return;
    }
    
    if (touchPoint.y < minOffsetY) {
        //tableView往上滚动
        [self handleTableView:currentTableView isScrollToTop:YES];
        
    } else if (touchPoint.y > maxOffsetY) {
        //tableView往下滚动
        [self handleTableView:currentTableView isScrollToTop:NO];
    } else {
        
    }
}

- (void)handleTableView:(UITableView *)tableView isScrollToTop:(BOOL)isScrollToTop {
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

#pragma mark - getter & setter

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
        for (NSInteger section = 0; section < 1; section ++) {
            for (NSInteger row = 0; row < 30; row ++) {
                [_dataSource addObject:[NSString stringWithFormat:@"section -- %ld row -- %ld", section, row]];
            }
        }
    }
    return _dataSource;
}

-(UITableView*)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor lightGrayColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[TableViewCell class] forCellReuseIdentifier:[TableViewCell cellIdentifier]];
        _tableView.tableFooterView = nil;
        
        //屏蔽自动计算高度功能，解决移动cell时的抖动问题
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
    }
    return _tableView;
}


@end
