//
//  JHPullRefreshFooterView.h
//  PullUpDownRefreshTableViewDemo
//
//  Created by lijinhai on 1/28/15.
//  Copyright (c) 2015 gaussli. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    JHPullRefreshFooterPulling = 0,
    JHPullRefreshFooterNormal,
    JHPullRefreshFooterLoading
} JHPullRefreshFooterState;

@protocol JHPullRefreshFooterDelegate <NSObject>

/*!
 @brief 进行刷新逻辑
 @params scrollView 关联的scrollView对象
 */
- (void) pullRefreshFooterWithScrollView: (UIScrollView*)scrollView;

@end

@interface JHPullRefreshFooterView : UIView

@property (nonatomic, retain) UILabel *stateLabel;                          // 状态Label（共三种：一般：上拉加载；上拉过程：松开加载；记载过程：加载中）
@property (nonatomic, retain) UILabel *lastUpdateLabel;                     // 最后更新时间Label
@property (nonatomic, retain) UIActivityIndicatorView *activityView;        // 加载旋转进度器
@property (nonatomic, retain) UIImageView *arrowImageView;                  // 箭头图像
@property (nonatomic) JHPullRefreshFooterState state;                       // 当前状态
@property (nonatomic, retain) id<JHPullRefreshFooterDelegate> delegate;     // 代理

/*!
 @brief 滚动过程逻辑
 @params scrollView 关联的scrollView对象
 */
- (void) refreshScrollViewDidScroll: (UIScrollView*)scrollView;
/*!
 @brief 松开触碰逻辑
 @params scrollView 关联的scrollView对象
 @params decelerate
 */
- (void) refreshScrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;
/*!
 @brief 加载数据成功逻辑
 @params scrollView 关联的scrollView对象
 */
- (void) refreshScrollViewDataSourceDidFinishedLoading:(UIScrollView *)scrollView;
@end
