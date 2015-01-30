//
//  JHPullRefreshHeaderView.m
//  PullUpDownRefreshTableViewDemo
//
//  Created by lijinhai on 1/28/15.
//  Copyright (c) 2015 gaussli. All rights reserved.
//

#import "JHPullRefreshHeaderView.h"

@implementation JHPullRefreshHeaderView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 设置下拉刷新Label
        self.stateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        self.stateLabel.textColor = [UIColor redColor];
        self.stateLabel.font = [UIFont systemFontOfSize:12];
        self.stateLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.stateLabel];
        // 设置剪头图像ImageView
        self.arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(90, 5, frame.size.height-10, frame.size.height-10)];
        [self addSubview:self.arrowImageView];
        self.state = JHPullRefreshHeaderNormal;
        self.activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        self.activityView.color = [UIColor blackColor];
        self.activityView.frame = CGRectMake(90, 5, frame.size.height-10, frame.size.height-10);
        [self addSubview:self.activityView];
        
        [self setState:JHPullRefreshHeaderNormal];
    }
    return self;
}

- (void) setState:(JHPullRefreshHeaderState)state {
    _state = state;
    switch (state) {
        case JHPullRefreshHeaderNormal: {
            self.stateLabel.text = @"下拉刷新...";
            self.arrowImageView.image = [UIImage imageNamed:@"xia.png"];
            break;
        }
        case JHPullRefreshHeaderPulling: {
            self.stateLabel.text = @"松开刷新...";
            self.arrowImageView.image = [UIImage imageNamed:@"shang.png"];
            break;
        }
        case JHPullRefreshHeaderLoading: {
            self.stateLabel.text = @"刷新中...";
            self.arrowImageView.hidden = YES;
            [self.activityView startAnimating];
            break;
        }
        default:
            break;
    }
}

#pragma mark - 首次自动加载逻辑
- (void) firstAutoLoadingWithScrollView: (UIScrollView*)scrollView {
    self.state = JHPullRefreshHeaderLoading;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.2];
    scrollView.contentInset = UIEdgeInsetsMake(40.0f, 0.0f, 0.0f, 0.0f);
    [UIView commitAnimations];
    [self.delegate pullRefreshHeaderWithScrollView:scrollView];
}

#pragma mark - 滚动过程逻辑
- (void) refreshScrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.arrowImageView.hidden != YES) {
        if (scrollView.contentOffset.y <= -50) {
            self.state = JHPullRefreshHeaderPulling;
        }
        else {
            self.state = JHPullRefreshHeaderNormal;
        }
    }
}

#pragma mark － 松开触碰逻辑
- (void) refreshScrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (self.arrowImageView.hidden != YES) {
        if (scrollView.contentOffset.y <= -50) {
            self.state = JHPullRefreshHeaderLoading;
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:0.2];
            scrollView.contentInset = UIEdgeInsetsMake(40.0f, 0.0f, 0.0f, 0.0f);
            [UIView commitAnimations];
            [self.delegate pullRefreshHeaderWithScrollView:scrollView];
        }
    }
}

#pragma mark - 加载数据成功逻辑
- (void) refreshScrollViewDataSourceDidFinishedLoading:(UIScrollView *)scrollView {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.2];
    scrollView.contentInset = UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f);
    [UIView commitAnimations];
    self.state = JHPullRefreshHeaderNormal;
    [self.activityView stopAnimating];
    self.arrowImageView.hidden = NO;
}
@end
