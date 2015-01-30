//
//  JHPullRefreshTableView.h
//  PullUpDownRefreshTableViewDemo
//
//  Created by lijinhai on 1/28/15.
//  Copyright (c) 2015 gaussli. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JHPullRefreshHeaderView.h"
#import "JHPullRefreshFooterView.h"

@interface JHPullRefreshTableView : UITableView
@property (nonatomic, strong) JHPullRefreshHeaderView *pullRefreshHeaderView;               // 下拉刷新头
@property (nonatomic, strong) JHPullRefreshFooterView *pullRefreshFooterView;               // 上拉加载尾
@property (nonatomic, strong) id<JHPullRefreshHeaderDelegate> pullRefreshHeaderDelegate;    // 下拉刷新头代理
@end
