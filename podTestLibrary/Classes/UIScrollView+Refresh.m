//
//  UIScrollView+Refresh.m
//  SVLibrary
//
//  Created by Mac on 16/8/24.
//  Copyright © 2016年 Sevryou. All rights reserved.
//

#import "UIScrollView+Refresh.h"
@implementation UIScrollView (Refresh)

-(void)setRefreshheader:(SVRefreshHeader*)refreshheader{
    refreshheader.scrollView=self;
    [refreshheader UISet];
    [refreshheader registerObserverForScrollView];
    objc_setAssociatedObject(self, &RefreshHeaderKey,
                             refreshheader, OBJC_ASSOCIATION_RETAIN);
}

-(SVRefreshHeader*)refreshheader{
    return objc_getAssociatedObject(self, &RefreshHeaderKey);
}

-(void)setRefreshfooter:(SVRefreshFooter *)refreshfooter{
    refreshfooter.scrollView=self;
    [refreshfooter UISet];
    [refreshfooter registerObserverForScrollView];
    objc_setAssociatedObject(self, &RefreshFooterKey,
                             refreshfooter, OBJC_ASSOCIATION_RETAIN);
}

-(SVRefreshFooter*)refreshfooter{
    return objc_getAssociatedObject(self, &RefreshFooterKey);
}

-(void)dealloc{
    NSLog(@"被销毁啦被销毁啦被销毁啦被销毁啦被销毁啦被销毁啦");
    if (self.observationInfo&&self.refreshfooter) {
        [self removeObserver:self.refreshfooter forKeyPath:@"contentOffset" context:@"FooterRefresh"];
    }
    if (self.observationInfo&&self.refreshheader) {
        [self removeObserver:self.refreshheader forKeyPath:@"contentOffset" context:@"HeaderRefresh"];
        
    }
}

@end
