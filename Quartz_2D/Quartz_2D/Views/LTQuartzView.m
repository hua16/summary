//
//  LTQuartzView.m
//  Quartz_2D
//
//  Created by xulihua on 16/10/26.
//  Copyright © 2016年 huage. All rights reserved.
//

#import "LTQuartzView.h"

@implementation LTQuartzView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    //获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //实心圆
    CGContextAddEllipseInRect(ctx, CGRectMake(100, 100, 100, 100));
    [[UIColor grayColor] set];
    CGContextFillPath(ctx);
    
    //空心圆
    CGContextAddEllipseInRect(ctx, CGRectMake(210, 100, 100, 100));
    [[UIColor redColor] set];
    CGContextStrokePath(ctx);
    
    //直线
    CGContextMoveToPoint(ctx, 100, 210);
    CGContextAddLineToPoint(ctx, self.frame.size.width - 100, 210);
    [[UIColor redColor] set];
    CGContextSetLineWidth(ctx, 0.5f);
    CGContextSetLineCap(ctx, kCGLineCapRound);
    CGContextSetLineJoin(ctx, kCGLineJoinRound);
    CGContextStrokePath(ctx);
    
    //矩形
    CGContextAddRect(ctx, CGRectMake(100, 220, 100, 100));
    [[UIColor blueColor] set];
    CGContextFillPath(ctx);
    
    //圆弧
    CGContextAddArc(ctx, 310, 320, 50, M_PI, M_PI_2, 0);
    CGContextClosePath(ctx);
    CGContextStrokePath(ctx);
    
    //文字
    NSString *str = @"你在红楼，我在西游";
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSForegroundColorAttributeName] = [UIColor darkGrayColor]; // 文字颜色
    dict[NSFontAttributeName] = [UIFont systemFontOfSize:14]; // 字体
    [str drawInRect:CGRectMake(100, 420, 300, 30) withAttributes:dict];

}

@end
