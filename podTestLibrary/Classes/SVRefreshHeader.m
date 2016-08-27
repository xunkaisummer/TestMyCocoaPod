//
//  SVRefreshHeader.m
//  下拉刷新
//
//  Created by hu on 15/7/30.
//  Copyright (c) 2015年 hu. All rights reserved.
//

#import "SVRefreshHeader.h"

@interface SVRefreshHeader()
@end
@implementation SVRefreshHeader

//初始化
-(void)UISet
{
    self.isRefresh=NO;
    self.isAdd=YES;
    self.lastPosition=0;
    self.refreshViewHeight=35;
    float imageWight=13;
    float imageHeight=self.refreshViewHeight;
    float labelWight=130;
    float labelHeight=self.refreshViewHeight;
    
    
    self.refreshView=[[UIView alloc]initWithFrame:CGRectMake(0, -self.refreshViewHeight-10, self.scrollView.bounds.size.width, self.refreshViewHeight)];
    //设置label
    self.headerlabel=[[UILabel alloc]initWithFrame:CGRectMake((self.scrollView.bounds.size.width-labelWight)/2, 0, labelWight, labelHeight)];
    self.headerlabel.textAlignment=NSTextAlignmentCenter;
    self.headerlabel.text=@"下拉刷新";
    self.headerlabel.font=[UIFont systemFontOfSize:14];
    [self.refreshView addSubview:self.headerlabel];
    //设置箭头图片
    self.headerImaV=[[UIImageView alloc]initWithFrame:CGRectMake((self.scrollView.bounds.size.width-labelWight)/2-imageWight, 0, imageWight, imageHeight)];
    self.headerImaV.image=[UIImage imageNamed:@"down"];
    self.headerImaV.contentMode=UIViewContentModeScaleToFill;
    [self.refreshView addSubview:self.headerImaV];
    //设置旋转小圆圈
    self.activityView=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.activityView.frame=CGRectMake((self.scrollView.bounds.size.width-labelWight)/2-imageWight, 0, imageWight, imageHeight);
    [self.refreshView addSubview:self.activityView];
    
    self.activityView.hidden=YES;
    self.headerImaV.hidden=NO;
    
}


//结束刷新，视图归位
-(void)endRefresh{
    self.isRefresh=NO;
    //主线程更新视图
    [UIView animateWithDuration:0.3 animations:^{
        CGPoint point=self.scrollView.contentOffset;
        if (point.y!=0) {
            self.scrollView.contentOffset=CGPointMake(0, point.y+self.refreshViewHeight*1.5);
        }
        self.scrollView.contentInset=UIEdgeInsetsMake(0, 0, 0, 0);
    } completion:^(BOOL finished) {
        self.headerImaV.hidden=NO;
        self.headerImaV.transform=CGAffineTransformMakeRotation(M_PI*2);
        [self.activityView stopAnimating];
        self.activityView.hidden=YES;
        self.headerlabel.text=@"下拉可刷新";
    }];
}

//开始进行刷新操作
-(void)beginRefresh{
    if(!self.isRefresh){
        self.isRefresh=YES;
        self.headerlabel.text=@"正在载入...";
        self.headerImaV.hidden=YES;
        //跳出旋转小圆圈进行动画
        self.activityView.hidden=NO;
        [self.activityView startAnimating];
        
        //设置刷新时scollView的位置
        [UIView animateWithDuration:0.3 animations:^{
            CGPoint point=self.scrollView.contentOffset;
            if (point.y>-self.refreshViewHeight*1.5) {
                self.scrollView.contentOffset=CGPointMake(0, point.y-self.refreshViewHeight*1.5);
            }
            self.scrollView.contentInset=UIEdgeInsetsMake(self.refreshViewHeight*1.5, 0, 0, 0);
        }];
        //block回调执行具体的刷新方法
        self.beginRefreshBlock();
    }
}

-(void)cancelRefresh{
    [self.refreshView removeFromSuperview];
    self.isAdd=NO;
}

-(void)dealloc{
    NSLog(@"SVRefreshHeader被销毁了SVRefreshHeader被销毁了");
    [self.scrollView removeObserver:self forKeyPath:@"contentOffset" context:@"HeaderRefresh"];

}

-(void)registerObserverForScrollView{
    [self.scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:@"HeaderRefresh"];
}

//kvo观察对应的监听方法
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if(![@"contentOffset" isEqualToString: keyPath])
        return;
    if (self.isAdd) {
        [self.scrollView addSubview:self.refreshView];
        //判断是否在拖动页面
        if (self.scrollView.dragging) {
            int currentPostion=self.scrollView.contentOffset.y;
            if(!self.isRefresh){
                [UIView animateWithDuration:0.3 animations:^{
                    if (currentPostion<-self.refreshViewHeight*1.5) {
                        self.headerlabel.text=@"松开以刷新";
                        self.headerImaV.transform=CGAffineTransformMakeRotation(M_PI);
                    }else {
                        int currentPostion=self.scrollView.contentOffset.y;
                        if (currentPostion-self.lastPosition>5) {
                            self.lastPosition=currentPostion;
                            self.headerImaV.transform=CGAffineTransformMakeRotation(M_PI*2);
                            self.headerlabel.text=@"下拉可刷新";
                        } else  if(self.lastPosition-currentPostion>5){
                            self.lastPosition=currentPostion;
                        }
                    }
                }];
            }
        } else {
            //松开进行刷新
            if ([self.headerlabel.text isEqualToString:@"松开以刷新"]) {
                [self beginRefresh];
            }
        }
    }
}

@end
