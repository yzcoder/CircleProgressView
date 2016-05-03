//
//  ViewController.m
//  CircleViewDemo
//
//  Created by Yz on 16/5/3.
//  Copyright © 2016年 Yuz. All rights reserved.
//

#import "ViewController.h"
#import "YzCircleView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    YzCircleView  *circle = [YzCircleView prograssWithFrame:CGRectMake(100, 100, 200, 200) duration:5];
    [self.view addSubview:circle];
    circle.progressScale = 0.8;
    circle.startAngle = 0;
    circle.endAngle = 270;
    circle.trackLineWidth = 3;
    circle.progressLineWidth = 2;
    circle.trackColor = [UIColor grayColor];
    circle.progressColor = [UIColor orangeColor];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
