//
//  MainViewController.h
//  PullUpDownRefreshTableViewDemo
//
//  Created by lijinhai on 1/5/15.
//  Copyright (c) 2015 gaussli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JHPullRefreshHeaderView.h"
#import "JHPullRefreshFooterView.h"

@interface MainViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, JHPullRefreshHeaderDelegate, JHPullRefreshFooterDelegate>
@property (nonatomic, strong) UITableView *tableview;                                       // TableView
@property (nonatomic, strong) JHPullRefreshHeaderView *pullRefreshHeaderView;               // 下拉刷新头
@property (nonatomic, strong) JHPullRefreshFooterView *pullRefreshFooterView;               // 上拉加载尾
@end
