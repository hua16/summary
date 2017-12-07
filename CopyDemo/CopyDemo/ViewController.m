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
#import "DBTestModel.h"

@interface ViewController ()


@property (unsafe_unretained, nonatomic) IBOutlet UIButton *movieButton;
@property (unsafe_unretained, nonatomic) IBOutlet UIActivityIndicatorView *movieActivityIndicator;

@end

@implementation ViewController

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self testCollective];
    [self testNonCollective];
    [self testDeepCopy];
}

- (void)configurePageView {
    self.movieActivityIndicator.hidden = YES;
}

- (void)addPageSubViews {
    
}

#pragma mark - private method

//非集合类
- (void)testNonCollective {
//    [self testNonCollectiveCopy];
//    [self testNonCollectiveMutaCopy];
//    [self testCustomObject];
}

//集合类
- (void)testCollective {
//    [self testCollectiveCopy];
//    [self testCollectiveMutacopy];
}

- (void)testDeepCopy {
//    [self testOneLevelDeepCopy];
    [self testRealDeepCopy];
}

- (void)testNonCollectiveCopy {
    NSString *string = @"origin";
    NSString *copyString = [string copy];
    NSMutableString *mutaCopyString = [string mutableCopy];
    
    NSLog(@"original   :%p", string);
    NSLog(@"copy       :%p", copyString);
    NSLog(@"mutableCopy:%p", mutaCopyString);
    
}

- (void)testNonCollectiveMutaCopy {
    NSMutableString *mutaString = [NSMutableString stringWithString:@"origin"];
    NSMutableString *copyMutaString = [mutaString copy];
    NSMutableString *mutaCopyMutaString = [mutaString mutableCopy];
    
    NSLog(@"%p", mutaString);
    NSLog(@"%p", copyMutaString);
    NSLog(@"%p", mutaCopyMutaString);
    
}

- (void)testCustomObject {
    NSMutableArray *mutableArray = [NSMutableArray array];
    DBTestModel *model = [[DBTestModel alloc] initWithText:@"text"
                                               sourceArray:@[@"test1",@"test2"]
                                              mutableArray:mutableArray];
    DBTestModel *copyModel = [model copy];
    DBTestModel *mutaCopyModel = [model mutableCopy];
    
    NSLog(@"DBTestModel memory address");
    NSLog(@"original   :%p", model);
    NSLog(@"copy       :%p", copyModel);
    NSLog(@"mutableCopy:%p", mutaCopyModel);
    NSLog(@"\n");
    
    NSLog(@"text memory address");
    NSLog(@"original   :%p", model.text);
    NSLog(@"copy       :%p", copyModel.text);
    NSLog(@"mutableCopy:%p", mutaCopyModel.text);
    NSLog(@"\n");
    
    NSLog(@"sourceArray memory address");
    NSLog(@"original   :%p", model.sourceArray);
    NSLog(@"copy       :%p", copyModel.sourceArray);
    NSLog(@"mutableCopy:%p", mutaCopyModel.sourceArray);
    NSLog(@"\n");
    
    NSLog(@"mutableArray memory address");
    NSLog(@"original   :%p", model.mutableArray);
    NSLog(@"copy       :%p", copyModel.mutableArray);
    NSLog(@"mutableCopy:%p", mutaCopyModel.mutableArray);
    NSLog(@"\n");
    
}

- (void)testCollectiveCopy {
    NSMutableArray *mutableArray1 = [NSMutableArray array];
    DBTestModel *model1 = [[DBTestModel alloc] initWithText:@"text"
                                               sourceArray:@[@"test1",@"test2"]
                                              mutableArray:mutableArray1];
    
    NSMutableArray *mutableArray2 = [NSMutableArray array];
    DBTestModel *model2 = [[DBTestModel alloc] initWithText:@"text"
                                                sourceArray:@[@"test1",@"test2"]
                                               mutableArray:mutableArray2];
    
    NSMutableArray *mutableArray3 = [NSMutableArray array];
    DBTestModel *model3 = [[DBTestModel alloc] initWithText:@"text"
                                                sourceArray:@[@"test1",@"test2"]
                                               mutableArray:mutableArray3];
    NSArray *array = @[model1,model2,model3];
    NSArray *copyArray = [array copy];
    NSMutableArray *mutaCopyArray = [array mutableCopy];

    NSLog(@"\nNSArray memory address\noriginal   :%p\ncopy       :%p\nmutableCopy:%p\n",
          array,copyArray,mutaCopyArray);
 
    DBTestModel *firstCopyModel = [copyArray firstObject];
    DBTestModel *firstMutableCopyModel = [mutaCopyArray firstObject];
    NSLog(@"\nDBTestModel memory address\noriginal   :%p\ncopy       :%p\nmutableCopy:%p\n",
          model1,firstCopyModel,firstMutableCopyModel);
 
    NSLog(@"\nDBTestModel sourceArray memory address\noriginal   :%p\ncopy       :%p\nmutableCopy:%p\n",
          model1.sourceArray,firstCopyModel.sourceArray,firstMutableCopyModel.sourceArray);
    
}

- (void)testCollectiveMutacopy {
    NSMutableArray *mutableArray1 = [NSMutableArray array];
    DBTestModel *model1 = [[DBTestModel alloc] initWithText:@"text"
                                                sourceArray:@[@"test1",@"test2"]
                                               mutableArray:mutableArray1];
    
    NSMutableArray *mutableArray2 = [NSMutableArray array];
    DBTestModel *model2 = [[DBTestModel alloc] initWithText:@"text"
                                                sourceArray:@[@"test1",@"test2"]
                                               mutableArray:mutableArray2];
    
    NSMutableArray *mutableArray3 = [NSMutableArray array];
    DBTestModel *model3 = [[DBTestModel alloc] initWithText:@"text"
                                                sourceArray:@[@"test1",@"test2"]
                                               mutableArray:mutableArray3];
    
    NSArray *array1 = @[model1,model2,model3];
    NSMutableArray *mutaArray = [NSMutableArray arrayWithArray:array1];
    NSMutableArray *copyMutaArray = [mutaArray copy];
    NSMutableArray *mutaCopyMutaArray= [mutaArray mutableCopy];
    
    NSLog(@"\nNSMutableArray memory address\noriginal   :%p\ncopy       :%p\nmutableCopy:%p\n",
          mutaArray,copyMutaArray,mutaCopyMutaArray);
    
    DBTestModel *firstCopyModel = [copyMutaArray firstObject];
    DBTestModel *firstMutableCopyModel = [mutaCopyMutaArray firstObject];
    NSLog(@"\nDBTestModel memory address\noriginal   :%p\ncopy       :%p\nmutableCopy:%p\n",
          model1,firstCopyModel,firstMutableCopyModel);
    
    NSLog(@"\nDBTestModel sourceArray memory address\noriginal   :%p\ncopy       :%p\nmutableCopy:%p\n",
          model1.sourceArray,firstCopyModel.sourceArray,firstMutableCopyModel.sourceArray);
}



- (void)testOneLevelDeepCopy {
    NSMutableArray *mutableArray1 = [NSMutableArray array];
    DBTestModel *model1 = [[DBTestModel alloc] initWithText:@"text"
                                                sourceArray:@[@"test1",@"test2"]
                                               mutableArray:mutableArray1];
    
    NSMutableArray *mutableArray2 = [NSMutableArray array];
    DBTestModel *model2 = [[DBTestModel alloc] initWithText:@"text"
                                                sourceArray:@[@"test1",@"test2"]
                                               mutableArray:mutableArray2];
    
    NSMutableArray *mutableArray3 = [NSMutableArray array];
    DBTestModel *model3 = [[DBTestModel alloc] initWithText:@"text"
                                                sourceArray:@[@"test1",@"test2"]
                                               mutableArray:mutableArray3];
    NSArray *array = @[model1,model2,model3];
    NSArray *copyArray = [[NSArray alloc] initWithArray:array copyItems:YES];
    
    NSLog(@"\nNSArray memory address\noriginal   :%p\ncopy       :%p\n",
          array,copyArray);
    
    DBTestModel *firstCopyModel = [copyArray firstObject];
    NSLog(@"\nDBTestModel memory address\noriginal   :%p\ncopy       :%p\n",
          model1,firstCopyModel);
    
    NSLog(@"\nDBTestModel sourceArray memory address\noriginal   :%p\ncopy       :%p\n",
          model1.sourceArray,firstCopyModel.sourceArray);
    
}



- (void)testRealDeepCopy {
    NSMutableArray *mutableArray1 = [NSMutableArray array];
    DBTestModel *model1 = [[DBTestModel alloc] initWithText:@"text"
                                                sourceArray:@[@"test1",@"test2"]
                                               mutableArray:mutableArray1];
    
    NSMutableArray *mutableArray2 = [NSMutableArray array];
    DBTestModel *model2 = [[DBTestModel alloc] initWithText:@"text"
                                                sourceArray:@[@"test1",@"test2"]
                                               mutableArray:mutableArray2];
    
    NSMutableArray *mutableArray3 = [NSMutableArray array];
    DBTestModel *model3 = [[DBTestModel alloc] initWithText:@"text"
                                                sourceArray:@[@"test1",@"test2"]
                                               mutableArray:mutableArray3];
    NSArray *array = @[model1,model2,model3];
    NSArray *copyArray = [NSKeyedUnarchiver unarchiveObjectWithData:[NSKeyedArchiver archivedDataWithRootObject:array]];
    
    model1 
    
    NSLog(@"\nNSArray memory address\noriginal   :%p\ncopy       :%p\n",
          array,copyArray);
    
    DBTestModel *firstCopyModel = [copyArray firstObject];
    NSLog(@"\nDBTestModel memory address\noriginal   :%p\ncopy       :%p\n",
          model1,firstCopyModel);
    
    NSLog(@"\nDBTestModel sourceArray memory address\noriginal   :%p\ncopy       :%p\n",
          model1.sourceArray,firstCopyModel.sourceArray);
    
}

#pragma mark - event response
- (IBAction)movieButtonClick:(UIButton *)sender {
    
    self.movieButton.hidden = YES;
    self.movieActivityIndicator.hidden = NO;
    [self.movieActivityIndicator startAnimating];
    
    [self getMovie];
    
//    NSArray *copyArray = [NSKeyedUnarchiver unarchiveObjectWithData:
//                          [NSKeyedArchiver archivedDataWithRootObject:array]];
    
    //    NSArray *copyArray = [[NSArray alloc] initWithArray:array copyItems:YES];
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
        
        DBMovie *movie = [MTLJSONAdapter modelOfClass:[DBMovie class] fromJSONDictionary:jsonDictionary error:nil];
        NSSet *propertyKeys = [DBMovie propertyKeys];
        [propertyKeys enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, BOOL * _Nonnull stop) {
            SEL sel = NSSelectorFromString(obj);
            if ([movie respondsToSelector:sel]) {
                _Pragma("clang diagnostic push")
                _Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"")
                NSLog(@"%@",[movie performSelector:sel]);
                _Pragma("clang diagnostic pop")
            }
        }];
        [self copy];
#warning 在这边设置断点查看对象
        
        [[[UIAlertView alloc]initWithTitle:@"信息" message:@"获取成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
        
        self.movieActivityIndicator.hidden = YES;
        [self.movieActivityIndicator stopAnimating];
        self.movieButton.hidden = NO;
    }];
    
}
@end
