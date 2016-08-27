//
//  SVRefreshBase.h
//  刷新
//
//  Created by Mac on 16/8/26.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <objc/runtime.h>

typedef void(^BeginRefreshBlock)(void);

static const char RefreshHeaderKey = '\1';//关联scrollView的key
static const char RefreshFooterKey = '\2';

@interface SVRefreshBase : NSObject

/**
 *  初始化
 *
 *  @param block 刷新回调Block
 *
 *  @return id
 */
-(instancetype)initWithRefreshBlock:(BeginRefreshBlock)block;

/**
 *  刷新回调Block
 */
@property(nonatomic,copy) BeginRefreshBlock beginRefreshBlock;

/**
 *  关联的scrollView（外部使用不需要设置）
 */
@property(nonatomic,weak) UIScrollView *scrollView;

/**
 *  刷新view的样式设置 (外部使用不需要设置,直接使用默认)
 */
-(void)UISet;

/**
 *  主动调用刷新（在不进行手势滑动的情况下）
 */
-(void)beginRefresh;

/**
 *  结束刷新状态（用于beginRefreshBlock中结束刷新）
 */
-(void)endRefresh;

/**
 *  取消刷新（在不需要上下拉刷新的情况下完全移除控件，想重新启动需要重新初始化）
 */
-(void)cancelRefresh;

/**
 *  设置关联的scrollView的滑动观察
 */
-(void)registerObserverForScrollView;
#pragma mark -common property
@property (nonatomic)float refreshViewHeight;//刷新视图的高度
@property (nonatomic)BOOL isRefresh;//是否处在刷新状态
@property (nonatomic)BOOL isAdd;//是否添加了刷新视图

@property (strong,nonatomic)UIView *refreshView;//整个刷新视图
@property (strong,nonatomic)UIActivityIndicatorView *activityView;//刷新视图中的菊花圈

@end
