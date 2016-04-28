//
//  ViewController.m
//  XMPopSubView
//
//  Created by nali on 16/4/27.
//  Copyright © 2016年 will.xu. All rights reserved.
//

#import "ViewController.h"
#import "XMTestNormalView.h"
#import "XMTestScrollview.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


-(IBAction)showNormalPopView:(id)sender{
    XMTestNormalView *autoHeightView = [[XMTestNormalView alloc] initWithController:self title:@"高度固定视图"];
    autoHeightView.backgroundColor = [UIColor blueColor];
    autoHeightView.frame = CGRectMake(0, 0, self.view.frame.size.width, 300);
    [autoHeightView showWithAnimate:YES];
}


-(IBAction)showAutoHeightPopView:(id)sender{
    
    XMTestNormalView *autoHeightView = [[XMTestNormalView alloc] initWithController:self title:@"高度自适应视图"];
    autoHeightView.backgroundColor = [UIColor redColor];
    autoHeightView.autoSizeWithSubFrame = YES;
    autoHeightView.frame = CGRectMake(0, 0, self.view.frame.size.width, arc4random() % 300);
    [autoHeightView showWithAnimate:YES];
}


-(IBAction)showTestScrollView:(id)sender{

    XMTestScrollview *testScrollView = [[XMTestScrollview alloc] initWithController:self title:@"测试滚动视图"];
    testScrollView.frame = CGRectMake(0, 0,  self.view.frame.size.width, 130);
    testScrollView.autoSizeWithSubFrame = YES;
    [testScrollView showWithAnimate:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
