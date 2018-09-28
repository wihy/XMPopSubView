//
//  XMPopListSubview.h
//
//  Created by will.xu on 16/6/6.
//  Copyright © 2016年 willing. All rights reserved.
//

#import "XMPopSubview.h"

@interface XMPopListSubview : XMPopSubview<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong) UITableView *tableView;

@end
