//
//  ViewController.m
//  EditCoverDemo
//
//  Created by 徐利华 on 2019/5/5.
//  Copyright © 2019年 徐利华. All rights reserved.
//

#import "ViewController.h"
#import "MGAIEditCoverViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)showCover:(UIButton *)sender {
    NSString *videoPath = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"mp4"];
    MGAIEditCoverViewController *coverViewController = [[MGAIEditCoverViewController alloc] initWithVideoPath:videoPath coverTime:1000 coverTimeBlock:^(CGFloat coverTime) {
        NSLog(@"切换封面成功");
    }];
    [self.navigationController pushViewController:coverViewController animated:YES];
}

@end
