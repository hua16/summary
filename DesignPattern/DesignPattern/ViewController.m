//
//  ViewController.m
//  DesignPattern
//
//  Created by xulihua on 16/9/24.
//  Copyright © 2016年 huage. All rights reserved.
//

#import "ViewController.h"
#import "LHStrategyController.h"

#import "LHPerson.h"
#import "LHFinery.h"
#import "LHResume.h"
#import "LHTestPaperA.h"
#import "LHTestPaperB.h"
#import "LHUser.h"
#import "LHDepartment.h"
#import "LHIUser.h"
#import "LHIDepartment.h"
#import "LHDataAccess.h"
#import "LHWork.h"
#import "LHConcreteCompany.h"
#import "LHHRDepartment.h"
#import "LHFinanceDepartment.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArr;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//装饰模式
- (void)decorativePattern {
    
    LHPerson *xc = [[LHPerson alloc] initWithName:@"小菜"];
    NSLog(@"/n 第一种打扮：");
    LHFinery *dtx = [[LHTShirts alloc] init];
    LHFinery *kk = [[LHBigTrouser alloc] init];
    LHFinery *pqx = [[LHSneakers alloc] init];
    
    [dtx decorate:xc];
    [kk decorate:dtx];
    [pqx decorate:kk];
    [pqx show];
    
    NSLog(@"/n 第二种打扮：");
    LHFinery *xz = [[LHSuit alloc] init];
    LHFinery *ld = [[LHTie alloc] init];
    LHFinery *px = [[LHLeatherShoes alloc] init];
    
    [xz decorate:xc];
    [ld decorate:xz];
    [px decorate:ld];
    [px show];
}

//原型模式
- (void)prototypePattern {
    LHResume *resumeA = [[LHResume alloc] initWithName:@"大鸟A" sex:@"男" age:@"29" timeArea:@"1998-2000" compony:@"xx公司"];
    LHResume *resumeB = [[LHResume alloc] initWithName:@"大鸟B" sex:@"男" age:@"29" timeArea:@"1998-2000" compony:@"xx公司"];
    LHResume *resumeC = [[LHResume alloc] initWithName:@"大鸟C" sex:@"男" age:@"29" timeArea:@"1998-2000" compony:@"xx公司"];
    [resumeA display];
    [resumeB display];
    [resumeC display];
}

//模板方法模式
- (void)templateMethod {
    NSLog(@"学生甲抄的试卷：");
    LHTestPaperA *studentA = [[LHTestPaperA alloc] init];
    [studentA testQuestion1];
    [studentA testQuestion2];
    [studentA testQuestion3];
    
    NSLog(@"学生乙抄的试卷：");
    LHTestPaperB *studentB = [[LHTestPaperB alloc] init];
    [studentB testQuestion1];
    [studentB testQuestion2];
    [studentB testQuestion3];
}

- (void)abstractFactory {
    LHUser *user = [[LHUser alloc] init];
    LHIUser *iUser = [LHDataAccess createUser];
    [iUser insertUser:user];
    [iUser getUserById:1];
    
    LHDepartment *department = [[LHDepartment alloc] init];
    LHIDepartment *iDepartment = [LHDataAccess createDepartment];
    [iDepartment insert:department];
    [iDepartment getDepartment:1];
}

//状态模式
- (void)stateModel {
    LHWork *emergencyProjects = [[LHWork alloc] init];
    emergencyProjects.hour = 9;
    [emergencyProjects writeProgram];
    emergencyProjects.hour = 10;
    [emergencyProjects writeProgram];
    emergencyProjects.hour = 12;
    [emergencyProjects writeProgram];
    emergencyProjects.hour = 13;
    [emergencyProjects writeProgram];
    emergencyProjects.hour = 14;
    [emergencyProjects writeProgram];
    emergencyProjects.hour = 17;
//    emergencyProjects.finish = YES;
    emergencyProjects.finish = NO;
    [emergencyProjects writeProgram];
    
    emergencyProjects.hour = 19;
    [emergencyProjects writeProgram];
    emergencyProjects.hour = 22;
    [emergencyProjects writeProgram];
}

//组合模式
- (void)compositeMode {
    LHConcreteCompany *root = [[LHConcreteCompany alloc] initWithName:@"北京总公司"];
    [root add:[[LHHRDepartment alloc] initWithName:@"总公司人力资源部"]];
    [root add:[[LHFinanceDepartment alloc] initWithName:@"总公司财务部"]];
    
    LHConcreteCompany *comp = [[LHConcreteCompany alloc] initWithName:@"上海华东分公司"];
    [comp add:[[LHHRDepartment alloc] initWithName:@"华东分公司人力资源部"]];
    [comp add:[[LHFinanceDepartment alloc] initWithName:@"华东分公司财务部"]];
    [root add:comp];
    
    LHConcreteCompany *comp1 = [[LHConcreteCompany alloc] initWithName:@"南京办事处"];
    [comp1 add:[[LHHRDepartment alloc] initWithName:@"南京办事处人力资源部"]];
    [comp1 add:[[LHFinanceDepartment alloc] initWithName:@"南京办事处财务部"]];
    [comp add:comp1];
    
    LHConcreteCompany *comp2 = [[LHConcreteCompany alloc] initWithName:@"杭州办事处"];
    [comp2 add:[[LHHRDepartment alloc] initWithName:@"杭州办事处人力资源部"]];
    [comp2 add:[[LHFinanceDepartment alloc] initWithName:@"杭州办事处财务部"]];
    [comp add:comp2];
    NSLog(@"结构图:");
    [root display:1];
    
    NSLog(@"职责:");
    [root lineOfDuty];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *reuseID = @"ReuseCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseID];
        cell.textLabel.font = [UIFont systemFontOfSize:15.0];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
    }
    cell.textLabel.text = [self.dataArr objectAtIndex: indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0: {
            LHStrategyController *stategyVC = [[LHStrategyController alloc] initWithNibName:@"LHStrategyController" bundle:[NSBundle mainBundle]];
            [self.navigationController pushViewController:stategyVC animated:YES];
        }
            break;
        case 1:
            [self decorativePattern];
            break;
        case 2:
            [self prototypePattern];
            break;
        case 3:
            [self templateMethod];
            break;
        case 4:
            [self abstractFactory];
            break;
        case 5:
            [self stateModel];
            break;
        case 6:
            [self compositeMode];
            break;
        default:
            break;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - getter & setter
- (NSArray *)dataArr {
    if (!_dataArr) {
        _dataArr = @[@"策略模式",@"装饰模式",@"原型模式",@"模板方法模式",@"抽象工厂模式",@"状态模式",@"组合模式"];
    }
    return _dataArr;
}

@end
