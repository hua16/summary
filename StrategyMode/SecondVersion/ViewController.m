//
//  ViewController.m
//  SecondVersion
//
//  Created by xiake on 2020/11/28.
//

#import "ViewController.h"
#import "MallardDuck.h"
#import "Squeak.h"
#import "FlyNoWay.h"
#import "ModelDuck.h"
#import "FlyRocketPowered.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
//    Duck *mallardDuck = [[MallardDuck alloc] init];
//    mallardDuck.quackBehavior = [[Squeak alloc] init];
//    mallardDuck.flyBehavior = [[FlyNoWay alloc] init];
//
//    [mallardDuck preformQuack];
//    [mallardDuck preformFly];
    
    
    Duck *model = [[ModelDuck alloc] init];
    [model preformFly];
    model.flyBehavior = [[FlyRocketPowered alloc] init];
    [model preformFly];
    
//    mallardDuck.quackBehavior = [[Squeak alloc] init];
//    mallardDuck.flyBehavior = [[FlyNoWay alloc] init];
    
}


@end
