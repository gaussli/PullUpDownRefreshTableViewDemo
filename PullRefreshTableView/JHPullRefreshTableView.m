//
//  JHPullRefreshTableView.m
//  PullUpDownRefreshTableViewDemo
//
//  Created by lijinhai on 1/28/15.
//  Copyright (c) 2015 gaussli. All rights reserved.
//

#import "JHPullRefreshTableView.h"

@implementation JHPullRefreshTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self) {
        self = [super initWithFrame:frame style:style];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    return [self initWithFrame:frame style:UITableViewStylePlain];
}

- (void) createPullRefreshHeaderView {
    self.pullRefreshHeaderView = [[JHPullRefreshHeaderView alloc] initWithFrame:CGRectMake(0, -40, self.frame.size.width, 40)];
    self.pullRefreshHeaderView.delegate = self.pullRefreshHeaderDelegate;
}

@end
