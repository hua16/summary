//
//  ViewController.m
//  CopyDemo
//
//  Created by xulihua on 2017/12/1.
//  Copyright © 2017年 huage. All rights reserved.
//

#import "ViewController.h" 
#import <Mantle/Mantle.h>
#import "DBMovie.h"
#import <UIKit/UIKit.h>

@interface ViewController ()


@property (unsafe_unretained, nonatomic) IBOutlet UIButton *movieButton;

@property (unsafe_unretained, nonatomic) IBOutlet UIActivityIndicatorView *movieActivityIndicator;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.movieActivityIndicator.hidden = YES;
}
- (IBAction)movieButtonClick:(UIButton *)sender {
    self.movieButton.hidden = YES;
    self.movieActivityIndicator.hidden = NO;
    [self.movieActivityIndicator startAnimating];
    
    [self getMovie];
    
}

- (void)getMovie  {
    
    NSURL * url = [NSURL URLWithString:@"https://api.douban.com/v2/movie/4212172"];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (connectionError) {
            NSLog(@"error:%@", connectionError);
            return;
        }
        
        NSDictionary * jsonDictionary = [NSJSONSerialization JSONObjectWithData:data
                                                                        options:NSJSONReadingMutableContainers
                                                                          error:nil];
        
        DBMovie * movie = [MTLJSONAdapter modelOfClass:[DBMovie class] fromJSONDictionary:jsonDictionary error:nil];
        
#warning 在这边设置断点查看对象
        
        [[[UIAlertView alloc]initWithTitle:@"信息" message:@"获取成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
        
        self.movieActivityIndicator.hidden = YES;
        [self.movieActivityIndicator stopAnimating];
        self.movieButton.hidden = NO;
    }];
    
}
@end
