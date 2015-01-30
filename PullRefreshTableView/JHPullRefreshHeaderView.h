//
//  JHPullRefreshHeaderView.h
//  PullUpDownRefreshTableViewDemo
//
//  Created by lijinhai on 1/28/15.
//  Copyright (c) 2015 gaussli. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    JHPullRefreshHeaderPulling = 0,
    JHPullRefreshHeaderNormal,
    JHPullRefreshHeaderLoading
} JHPullRefreshHeaderState;

/*!
 @brief 下拉刷新代理
 */
@protocol JHPullRefreshHeaderDelegate <NSObject>
/*!
 @brief 滑动到JHPullRefreshHeaderLoading状态时进行数据更新操作
 @params scrollView 当前滑动的scrollView对象
 */
- (void) pullRefreshHeaderWithScrollView: (UIScrollView*)scrollView;
@end

/*!
 @brief 下拉刷新View
 */
@interface JHPullRefreshHeaderView : UIView
@property (nonatomic, retain) UILabel *stateLabel;                          // 状态Label（共三种：一般：下拉刷新；上拉过程：松开加载；记载过程：加载中）
@property (nonatomic, retain) UIActivityIndicatorView *activityView;        // 加载旋转进度器
@property (nonatomic, retain) UIImageView *arrowImageView;                  // 箭头图像
@property (nonatomic) JHPullRefreshHeaderState state;                       // 当前状态
@property (nonatomic, retain) id<JHPullRefreshHeaderDelegate> delegate;     // 代理

/*!
 @brief 首次自动刷新逻辑
 @params scrollView 关联的scrollView对象
 */
- (void) firstAutoLoadingWithScrollView: (UIScrollView*)scrollView;

/*!
 @brief 滚动过程逻辑
 @params scrollView 关联的scrollView对象
 */
- (void) refreshScrollViewDidScroll:(UIScrollView *)scrollView;
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
