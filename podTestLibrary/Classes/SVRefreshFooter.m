//
//  SVRefreshFooter.m
//  下拉刷新
//
//  Created by hu on 15/7/30.
//  Copyright (c) 2015年 hu. All rights reserved.
//

#import "SVRefreshFooter.h"

@implementation SVRefreshFooter



- (void)UISet{
    
    self.refreshViewHeight=35;
    self.isAdd=YES;
    self.isRefresh=NO;
    
    self.refreshView=[[UIView alloc] init];
    self.activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
}

- (void)beginRefresh{
    if (!self.isRefresh) {
        self.isRefresh=YES;
        //        设置刷新状态_scrollView的位置
        [self.activityView startAnimating];
        
        [UIView animateWithDuration:0.3 animations:^{
            self.scrollView.contentInset=UIEdgeInsetsMake(0, 0, self.refreshViewHeight, 0);
            
        } completion:^(BOOL finished) {
        }];
        //        block回调
        self.beginRefreshBlock();
    }
    
}

//关闭刷新
- (void)endRefresh{
    self.isRefresh=NO;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [UIView animateWithDuration:0.3 animations:^{
            [self.activityView stopAnimating];
            
            self.scrollView.contentInset=UIEdgeInsetsMake(0, 0, 0, 0);
            self.refreshView.frame=CGRectMake(0, self.scrollView.contentSize.height, [[UIScreen mainScreen] bounds].size.width, self.refreshViewHeight);
        }];
    });
}

-(void)cancelRefresh{
    [self.refreshView removeFromSuperview];
    self.isAdd=NO;
    objc_setAssociatedObject(self.scrollView, &RefreshFooterKey,
                             nil, OBJC_ASSOCIATION_RETAIN);
}

-(void)dealloc{
    NSLog(@"SVRefreshFooter被销毁了SVRefreshFooter被销毁了");
    [self.scrollView removeObserver:self forKeyPath:@"contentOffset" context:@"FooterRefresh"];

}
-(void)registerObserverForScrollView{
    [self.scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:@"FooterRefresh"];
}

//kvo观察对应的监听方法
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if(![@"contentOffset" isEqualToString: keyPath])
        return;
    if (self.isAdd) {
        [self.refreshView addSubview:self.activityView];
        [self.scrollView addSubview:self.refreshView];
        
        self.refreshView.frame=CGRectMake(0, self.scrollView.contentSize.height, self.scrollView.bounds.size.width,self.refreshViewHeight);
        self.activityView.frame=CGRectMake((self.scrollView.bounds.size.width-self.refreshViewHeight)/2, 0, self.refreshViewHeight, self.refreshViewHeight);
        // 进入刷新状态
        if ((self.scrollView.contentOffset.y-30>(self.scrollView.contentSize.height-self.scrollView.bounds.size.height))&&(self.scrollView.contentSize.height>self.scrollView.bounds.size.height)) {
            if (!self.scrollView.dragging) {
                
                [self beginRefresh];
            }
        }
    }
}

@end
