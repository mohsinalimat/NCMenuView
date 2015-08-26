//
//  ViewController.m
//  NCMenuViewDemo
//
//  Created by li naicai on 15/8/26.
//  Copyright (c) 2015年 li naicai. All rights reserved.
//

#import "ViewController.h"
#import "NCMenuView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"Demo";
    NCMenuView *menu=[[NCMenuView alloc]initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, 50) Titles:@[@"最新",@"最热",@"穿越"] Complete:^(NSInteger selectIndex) {
        
    }];
    [self.view addSubview:menu];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
