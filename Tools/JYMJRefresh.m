//
//  JYMJRefresh.m
//  JianYa
//
//  Created by mxd_iOS on 2017/3/16.
//  Copyright © 2017年 Xudong.ma. All rights reserved.
//

#import "JYMJRefresh.h"
#import "MJRefresh.h"

@implementation JYMJRefresh

+ (instancetype)instance
{
    static JYMJRefresh *refresh = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        refresh = [[JYMJRefresh alloc] init];
    });
    
    return refresh;
}

/** 开始下拉刷新*/
+ (void)beginPullRefreshForScrollView:(UIScrollView *)scrollView {
    [scrollView.mj_header beginRefreshing];
}

/**判断头部是否在刷新*/
+ (BOOL)headerIsRefreshForScrollView:(UIScrollView *)scrollView {
    
    BOOL flag = scrollView.mj_header.isRefreshing;
    return flag;
}

/**判断是否尾部在刷新*/
+ (BOOL)footerIsLoadingForScrollView:(UIScrollView *)scrollView {
    return  scrollView.mj_footer.isRefreshing;
}

/**提示没有更多数据的情况*/
+ (void)noticeNoMoreDataForScrollView:(UIScrollView *)scrollView {
    [scrollView.mj_footer endRefreshingWithNoMoreData];
}

/**重置footer*/
+ (void)resetNoMoreDataForScrollView:(UIScrollView *)scrollView {
    [scrollView.mj_footer resetNoMoreData];
}

/**停止下拉刷新*/
+ (void)endRefreshForScrollView:(UIScrollView *)scrollView {
    [scrollView.mj_header endRefreshing];
}

/**停止上拉加载*/
+ (void)endLoadMoreForScrollView:(UIScrollView *)scrollView {
    [scrollView.mj_footer endRefreshing];
}

/** 隐藏footer*/
+ (void)hiddenFooterForScrollView:(UIScrollView *)scrollView {
    // 不确定是哪个类型的footer
    scrollView.mj_footer.hidden = YES;
}

/**隐藏header*/
+ (void)hiddenHeaderForScrollView:(UIScrollView *)scrollView {
    scrollView.mj_header.hidden = YES;
}

/** 添加下拉刷新 / 上拉加载*/
- (MJRefreshNormalHeader *)mj_refreshHeaderHandler:(id)tableView refreshCallBackBlock:(JYRefreshAnLoadMoreHandler)refreshCallBackBlock
{
    if (tableView == nil || refreshCallBackBlock == nil) {
        return nil;
    }
    
    MJRefreshNormalHeader *mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        if (refreshCallBackBlock) {refreshCallBackBlock();}
    }];
    mj_header.automaticallyChangeAlpha    = YES;
    mj_header.lastUpdatedTimeLabel.hidden = YES;
    [mj_header setTitle:@"下拉刷新"  forState:MJRefreshStateIdle];
    [mj_header setTitle:@"释放刷新"  forState:MJRefreshStatePulling];
    [mj_header setTitle:@"努力加载中" forState:MJRefreshStateRefreshing];
    mj_header.stateLabel.textColor = RGBA(179, 179, 179, 1.0f);
    mj_header.stateLabel.font = [UIFont systemFontOfSize:12.f];
    
    return mj_header;
}

- (MJRefreshAutoNormalFooter *)mj_refreshFooterHandler:(id)tableView refreshCallBackBlock:(JYRefreshAnLoadMoreHandler)refreshCallBackBlock
{
    if (tableView == nil || refreshCallBackBlock == nil) {
        return nil;
    }
    
    MJRefreshAutoNormalFooter *mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        if (refreshCallBackBlock) {refreshCallBackBlock();}
    }];
    
//    mj_footer.automaticallyHidden = YES;
    [mj_footer setTitle:@""        forState:MJRefreshStateIdle];
    [mj_footer setTitle:@"释放刷新"  forState:MJRefreshStatePulling];
    [mj_footer setTitle:@"努力加载中" forState:MJRefreshStateRefreshing];
    [mj_footer setTitle:@"已经全部加载完毕" forState:MJRefreshStateNoMoreData];
    
    mj_footer.stateLabel.textColor = RGBA(179, 179, 179, 1.0f);
    mj_footer.stateLabel.font = [UIFont systemFontOfSize:12.f];
    
    return mj_footer;
}

/**
 *  带动画下拉刷新
 *
 *  @param method 执行方法
 */
- (void)dealMJRefreshHeaderBy:(MJRefreshGifHeader *)header
{
    /* 下拉刷新图标**/
    NSMutableArray * arr     = [NSMutableArray array];
    
    CGFloat kRefreshImgWithAndHeight = Set_WidthScale(40.f);
    
    for (NSInteger i = 1; i < 9; i++) {
        
        NSString *str = [NSString stringWithFormat:@"refresh_0%ld.png", (long)i];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kRefreshImgWithAndHeight, kRefreshImgWithAndHeight)];
        imageView.image = [UIImage imageNamed:str];
        [arr addObject:imageView.image];
    }
    
    NSMutableArray *arrstart = [NSMutableArray array];
    
    for (NSInteger i = 1; i < 9; i++) {
        
        NSString *str = [NSString stringWithFormat:@"refresh_0%ld.png", (long)i];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kRefreshImgWithAndHeight, kRefreshImgWithAndHeight)];
        imageView.image = [UIImage imageNamed:str];
        [arrstart addObject:imageView.image];
    }
    
    NSArray *startArr  = arrstart;
    NSArray *imagesArr = arr;
    
    //设置正在拖动是的动画图片
    [header setImages:startArr forState: MJRefreshStatePulling];
    //设置正在刷新是的动画图片
    [header setImages:imagesArr forState: MJRefreshStateRefreshing];
    // 隐藏时间
    header.lastUpdatedTimeLabel.hidden = YES;
    // 隐藏状态栏
    header.stateLabel.hidden           = YES;
}

+ (void)mj_endRefresh:(UIScrollView *)scrollView
{
    [scrollView.mj_header endRefreshingWithCompletionBlock:^{}];
    [scrollView.mj_footer endRefreshingWithCompletionBlock:^{}];
}

@end
