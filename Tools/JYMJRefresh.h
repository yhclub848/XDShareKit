//
//  JYMJRefresh.h
//  JianYa
//
//  Created by mxd_iOS on 2017/3/16.
//  Copyright © 2017年 Xudong.ma. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MJRefreshGifHeader;

typedef void(^JYRefreshAnLoadMoreHandler)(void);

@class MJRefreshNormalHeader;
@class MJRefreshAutoNormalFooter;

@interface JYMJRefresh : NSObject

+ (instancetype)instance;

/** 开始下拉刷新 */
+ (void)beginPullRefreshForScrollView:(UIScrollView *)scrollView;

/** 判断头部是否在刷新 */
+ (BOOL)headerIsRefreshForScrollView:(UIScrollView *)scrollView;

/** 判断是否尾部在刷新 */
+ (BOOL)footerIsLoadingForScrollView:(UIScrollView *)scrollView;

/** 提示没有更多数据的情况 */
+ (void)noticeNoMoreDataForScrollView:(UIScrollView *)scrollView;

/** 重置footer */
+ (void)resetNoMoreDataForScrollView:(UIScrollView *)scrollView;

/**  停止下拉刷新 */
+ (void)endRefreshForScrollView:(UIScrollView *)scrollView;

/**  停止上拉加载 */
+ (void)endLoadMoreForScrollView:(UIScrollView *)scrollView;

/**  隐藏footer */
+ (void)hiddenFooterForScrollView:(UIScrollView *)scrollView;

/** 隐藏header */
+ (void)hiddenHeaderForScrollView:(UIScrollView *)scrollView;

#pragma mark -
#pragma mark - MJRefresh相关

/** 添加下拉刷新*/
/** 添加下拉刷新 / 上拉加载*/
- (MJRefreshNormalHeader *)mj_refreshHeaderHandler:(id)tableView refreshCallBackBlock:(JYRefreshAnLoadMoreHandler)refreshCallBackBlock;

/** 上拉加载*/
- (MJRefreshAutoNormalFooter *)mj_refreshFooterHandler:(id)tableView refreshCallBackBlock:(JYRefreshAnLoadMoreHandler)refreshCallBackBlock;

/**
 *  带动画下拉刷新
 *
 *  @param method 执行方法
 */
- (void)dealMJRefreshHeaderBy:(MJRefreshGifHeader *)header;

/** 停止下拉刷新 / 上拉加载*/
+ (void)mj_endRefresh:(UIScrollView *)scrollView;

@end
