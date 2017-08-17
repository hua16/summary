//
//  ViewController.m
//  responderChainDemo
//
//  Created by xulihua on 2017/8/16.
//  Copyright © 2017年 huage. All rights reserved.
//

#import "ViewController.h"
#import "TableViewCell.h"
#import <Foundation/Foundation.h>
#import "EventProxy.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) EventProxy *eventProxy;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:TestTableViewCellIdentifier bundle:[NSBundle mainBundle]] forCellReuseIdentifier:TestTableViewCellIdentifier];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TestTableViewCellIdentifier forIndexPath:indexPath];
    cell.indexPath = indexPath;
    switch (indexPath.row%2) {
        case 0:
            cell.contentView.backgroundColor = [UIColor lightGrayColor];
            break;
        case 1:
            cell.contentView.backgroundColor = [UIColor whiteColor];
            break;
    }
    return cell;
}

#pragma mark - event response
- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo {
    [self.eventProxy handleEvent:eventName userInfo:userInfo];
}


#pragma mark - getter & setter


- (EventProxy *)eventProxy {
    if (!_eventProxy) {
        _eventProxy = [[EventProxy alloc] init];
    }
    return _eventProxy;
}

@end
