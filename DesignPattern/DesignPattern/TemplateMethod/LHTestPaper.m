//
//  LHTestPaper.m
//  DesignPattern
//
//  Created by xulihua on 16/9/27.
//  Copyright © 2016年 huage. All rights reserved.
//

#import "LHTestPaper.h"

@implementation LHTestPaper

- (void)testQuestion1 {
    NSLog(@"杨过得到，后来给郭靖，炼成倚天剑和屠龙刀的玄铁可能是[] \na.球磨铸铁 \nb.马口铁 \nc.高速合金钢  \nd.碳素纤维");
    NSLog(@"答案：%@", [self answer1]);
}

- (void)testQuestion2 {
    NSLog(@"杨过铲除情花，造成[] \na.使这种植物不再害人 \nb.使一种珍稀物种灭绝 \nc.破坏生物圈的生态平衡 \nd.造成该地区沙漠化");
    NSLog(@"答案：%@", [self answer2]);
}

- (void)testQuestion3 {
    NSLog(@"呕吐不止，开什么药[] \na.阿司匹林 \nb.牛黄解毒片 \nc.氟哌酸  \nd.喝大量生牛奶 \ne.以上都不对");
    NSLog(@"答案：%@", [self answer3]);
}

- (NSString *)answer1 {
    return @"";
}

- (NSString *)answer2 {
    return @"";
}

- (NSString *)answer3 {
    return @"";
}

@end
