//
//  MainViewController.m
//  PullUpDownRefreshTableViewDemo
//
//  Created by lijinhai on 1/5/15.
//  Copyright (c) 2015 gaussli. All rights reserved.
//

#import "MainViewController.h"
#import "MacroDefinition.h"

#define macro

@interface MainViewController ()

@end

@implementation MainViewController

#pragma mark - 页面生命周期
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, JH_DEVICE_WIDTH, JH_DEVICE_HEIGHT-JH_STATUSBAR_HEIGHT)];
    // 设置下拉刷新头
    self.pullRefreshHeaderView = [[JHPullRefreshHeaderView alloc] initWithFrame:CGRectMake(0, -40, self.tableview.frame.size.width, 40)];
    self.pullRefreshHeaderView.delegate = self;
    [self.tableview addSubview:self.pullRefreshHeaderView];
    self.tableview.dataSource = self;
    self.tableview.delegate = self;
    // 去除多余的横线
    self.tableview.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:self.tableview];
    NSLog(@"contentSize.height: %f, %f", self.tableview.contentSize.height, self.tableview.frame.size.height);
    if (self.tableview.contentSize.height >= self.tableview.frame.size.height) {
        // 设置上拉加载尾
        self.pullRefreshFooterView = [[JHPullRefreshFooterView alloc] initWithFrame:CGRectMake(0, self.tableview.contentSize.height, self.tableview.frame.size.width, 40)];
        self.pullRefreshFooterView.delegate = self;
        [self.tableview addSubview:self.pullRefreshFooterView];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - 系统代理
#pragma mark UITableView代理
- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = @"Test TableView Demo";
    return cell;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

#pragma mark UIScrollView代理
- (void) scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.pullRefreshHeaderView refreshScrollViewDidScroll:scrollView];
    [self.pullRefreshFooterView refreshScrollViewDidScroll:scrollView];
}

- (void) scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self.pullRefreshHeaderView refreshScrollViewDidEndDragging:scrollView willDecelerate:decelerate];
    [self.pullRefreshFooterView refreshScrollViewDidEndDragging:scrollView willDecelerate:decelerate];
}

#pragma mark - 自定义代理
#pragma mark 下拉刷新代理
- (void) pullRefreshHeaderWithScrollView:(UIScrollView *)scrollView {
    [self performSelector:@selector(refreshScrollHeaderViewDataSourceDidFinishedLoading) withObject:nil afterDelay:1.5];
}

#pragma mark 上拉加载代理
- (void) pullRefreshFooterWithScrollView:(UIScrollView *)scrollView {
    [self performSelector:@selector(refreshScrollFooterViewDataSourceDidFinishedLoading) withObject:nil afterDelay:1.5];
}

#pragma mark - 页面逻辑
#pragma mark 下拉刷新数据获取成功
- (void) refreshScrollHeaderViewDataSourceDidFinishedLoading {
    [self.pullRefreshHeaderView refreshScrollViewDataSourceDidFinishedLoading:self.tableview];
}
#pragma mark 上拉加载数据获取成功
- (void) refreshScrollFooterViewDataSourceDidFinishedLoading {
    [self.pullRefreshFooterView refreshScrollViewDataSourceDidFinishedLoading:self.tableview];
}

@end
