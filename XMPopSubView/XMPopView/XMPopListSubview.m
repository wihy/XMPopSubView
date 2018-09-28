//
//  XMPopListSubview.m
//
//  Created by will.xu on 16/6/6.
//  Copyright © 2016年 willing. All rights reserved.
//

#import "XMPopListSubview.h"


@implementation XMPopListSubview
- (void)dealloc
{
    self.tableView.delegate = nil;
    self.tableView.dataSource = nil;
    self.tableView = nil;
	
}

-(instancetype)initWithController:(UIViewController *)ctrl title:(NSString *)title{
    if (self = [super initWithController:ctrl title:title]) {
        
        [self customedUI];
    }
    return self;
}

-(void)customedUI{
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    tableView.backgroundColor = [UIColor clearColor];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.tableFooterView = [[UIView alloc] init];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self addSubview:tableView];
    self.tableView = tableView;
}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    _tableView.frame = self.bounds;
}

#pragma mark --  UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"never be called"];
    return cell;
}

@end
