//
//  CollectionViewCell.m
//  LTMovableCellTableView
//
//  Created by xulihua on 2017/12/19.
//  Copyright © 2017年 huage. All rights reserved.
//

#import "CollectionViewCell.h"
#import "TableViewCell.h"

#import <Masonry/Masonry.h>

@interface CollectionViewCell ()<UITableViewDelegate,UITableViewDataSource>
    
@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation CollectionViewCell

+ (NSString *)cellIdentifier {
    return @"CollectionViewCell";
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self configurePageView];
        [self addPageSubViews];
        [self layoutPageSubView];
        [self updatePageLayout];
    }
    return self;
}

- (void)configurePageView {
    self.contentView.backgroundColor = [UIColor redColor];
}

- (void)addPageSubViews {
    [self.contentView addSubview:self.tableView];
}

- (void)layoutPageSubView {
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.top.equalTo(self.contentView.mas_safeAreaLayoutGuideTop);
            make.bottom.equalTo(self.contentView.mas_safeAreaLayoutGuideBottom);
        } else {
            make.top.equalTo(self.contentView);
            make.bottom.equalTo(self.contentView);
        }
        make.leading.equalTo(self.contentView);
        make.trailing.equalTo(self.contentView);
    }];
}

- (void)updatePageLayout {
    
}
    
#pragma mark - UITableViewDelegate & UITableViewDataSource
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
    
#pragma mark - getter & setter
  
- (UITableView*)tableView{
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

@end
