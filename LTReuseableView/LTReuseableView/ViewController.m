//
//  ViewController.m
//  LTReuseableView
//
//  Created by 徐利华 on 2020/8/13.
//  Copyright © 2020 徐利华. All rights reserved.
//

#import "ViewController.h"
#import <Masonry/Masonry.h>
#import "GDCustomTableView.h"

@interface ViewController ()<GDCustomTableViewDelegate, GDCustomTableViewDataSource, UITextViewDelegate>

@property (nonatomic, strong) NSMutableArray *reasons;                     /// 举报原因
@property (nonatomic, assign) NSInteger index;                      /// 选择索引
@property (nonatomic, strong) NSString *supplement;                 /// 补充内容
@property (nonatomic, strong) NSMutableDictionary *defaultParams;   /// 默认参数
@property (nonatomic, assign) NSInteger accountTimelineId;         /// 当前用户热点动态id

@property (nonatomic, strong) GDCustomTableView *tableView;               /// 表格

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *dataArray = @[@"垃圾营销", @"敏感信息", @"淫秽色情", @"欺诈", @"侵权", @"其他"];
    self.reasons = [NSMutableArray array];
    for (NSInteger index = 0; index < 10; index++) {
        [self.reasons addObjectsFromArray:dataArray];
    }
    _index = NSNotFound;
    [self.view addSubview:self.tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

#pragma mark - GDCustomTableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(GDCustomTableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(GDCustomTableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger num = 0;
    switch (section) {
        case 0:
            num = _reasons.count;
            break;
        case 1:
            num = 1;
            break;
        default:
            break;
    }
    return num;
}

- (UITableViewCell *)tableView:(GDCustomTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(UITableViewCell.class)];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:NSStringFromClass(UITableViewCell.class)];
    }
    cell.userInteractionEnabled = YES;
    cell.textLabel.text = _reasons[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:16.0];
    if (indexPath.row == _index) {
        cell.imageView.image = [UIImage imageNamed:@"radio_checked"];
    } else {
        cell.imageView.image = [UIImage imageNamed:@"radio_unchecked"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - GDCustomTableViewDelegate

- (CGFloat)tableView:(GDCustomTableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50.0;
}

- (CGFloat)tableView:(GDCustomTableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40.0;
}

- (CGFloat)tableView:(GDCustomTableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

- (void)tableView:(GDCustomTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger count = [tableView visibleCells].count;
    NSLog(@"huage count:%ld",count);
}

- (void)tableView:(GDCustomTableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

#pragma mark - Property

- (GDCustomTableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[GDCustomTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor redColor];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.userInteractionEnabled = YES;
//        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass(UITableViewCell.class)];
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

@end
