//
//  JHPullRefreshFooterView.m
//  PullUpDownRefreshTableViewDemo
//
//  Created by lijinhai on 1/28/15.
//  Copyright (c) 2015 gaussli. All rights reserved.
//

#import "JHPullRefreshFooterView.h"

@implementation JHPullRefreshFooterView
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
        self.state = JHPullRefreshFooterNormal;
        self.activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        self.activityView.color = [UIColor blackColor];
        self.activityView.frame = CGRectMake(90, 5, frame.size.height-10, frame.size.height-10);
        [self addSubview:self.activityView];
        
        [self setState:JHPullRefreshFooterNormal];
    }
    return self;
}

- (void) setState:(JHPullRefreshFooterState)state {
    _state = state;
    switch (state) {
        case JHPullRefreshFooterNormal: {
            self.stateLabel.text = @"上拉加载...";
            self.arrowImageView.image = [UIImage imageNamed:@"xia.png"];
            break;
        }
        case JHPullRefreshFooterPulling: {
            self.stateLabel.text = @"松开加载...";
            self.arrowImageView.image = [UIImage imageNamed:@"shang.png"];
            break;
        }
        case JHPullRefreshFooterLoading: {
            self.stateLabel.text = @"刷新中...";
            self.arrowImageView.hidden = YES;
            [self.activityView startAnimating];
            break;
        }
        default:
            break;
    }
}

#pragma mark - 滚动过程逻辑
- (void) refreshScrollViewDidScroll: (UIScrollView*)scrollView {
    if (self.arrowImageView.hidden != YES) {
        if (scrollView.contentOffset.y + scrollView.frame.size.height >= 50 + scrollView.contentSize.height) {
            self.state = JHPullRefreshFooterPulling;
        }
        else {
            self.state = JHPullRefreshFooterNormal;
        }
    }
}

#pragma mark - 松开触碰逻辑
- (void) refreshScrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (self.arrowImageView.hidden != YES) {
        if (scrollView.contentOffset.y + scrollView.frame.size.height >= 50 + scrollView.contentSize.height) {
            self.state = JHPullRefreshFooterLoading;
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:0.2];
            scrollView.contentInset = UIEdgeInsetsMake(0.0f, 0.0f, 40.0f, 0.0f);
            [UIView commitAnimations];
            [self.delegate pullRefreshFooterWithScrollView:scrollView];
        }
    }
}

#pragma mark - 加载数据成功逻辑
- (void) refreshScrollViewDataSourceDidFinishedLoading:(UIScrollView *)scrollView {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.2];
    scrollView.contentInset = UIEdgeInsetsMake(0.0f, 0.0f, 0.0f, 0.0f);
    [UIView commitAnimations];
    self.state = JHPullRefreshFooterNormal;
    [self.activityView stopAnimating];
    self.arrowImageView.hidden = NO;
}
@end
