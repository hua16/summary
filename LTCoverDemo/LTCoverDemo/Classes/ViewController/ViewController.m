//
//  ViewController.m
//  LTCoverDemo
//
//  Created by 徐利华 on 2019/7/9.
//  Copyright © 2019 徐利华. All rights reserved.
//

#import "ViewController.h"
#import "MGAIEditCoverViewController.h"
#import "LTCGUtilities.h"

@interface ViewController ()

@property (nonatomic, assign) CGFloat coverTime;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)selectCover:(UIButton *)sender {
    NSString *videoPath = [[NSBundle mainBundle] pathForResource:@"video" ofType:@"mp4"];
    
    @weakify(self)
    MGAIEditCoverViewController *editCoverVC = [[MGAIEditCoverViewController alloc] initWithVideoPath:videoPath coverTime:self.coverTime coverTimeBlock:^(CGFloat coverTime) {
       @strongify(self)
        self.coverTime = coverTime;
    }];
    [self presentViewController:editCoverVC animated:YES completion:NULL];
}

@end
