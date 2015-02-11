//
//  EmployInfoViewController.m
//  CalendarDemo
//
//  Created by highcom on 15-2-11.
//  Copyright (c) 2015年 zhanglei. All rights reserved.
//

#import "EmployInfoViewController.h"

@interface EmployInfoViewController ()

@end

@implementation EmployInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIView * topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 60)];
    [topView setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:topView];
    
    self.uLtitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, 40)];
    [self.view addSubview:self.uLtitle];
    [self.uLtitle setText:@"招聘信息"];
    [self.uLtitle setTextAlignment:NSTextAlignmentCenter];
    
    UIButton * btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 20, 60, 40)];
    [btn setTitle:@"返回" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UIImageView * image = [[UIImageView alloc] initWithFrame:CGRectMake(0, 60, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-100)];
    [self.view addSubview:image];
    [image setImage:[UIImage imageNamed:@"employ.png"]];
    // Do any additional setup after loading the view.
    
}
-(void)back{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
