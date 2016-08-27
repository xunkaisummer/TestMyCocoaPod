//
//  SVRefreshBase.m
//  刷新
//
//  Created by Mac on 16/8/26.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "SVRefreshBase.h"

@implementation SVRefreshBase

-(instancetype)initWithRefreshBlock:(BeginRefreshBlock)block{
    self=[super init];
    if (self) {
        self.beginRefreshBlock=block;
    }
    return self;
}

-(void)UISet{
    //子类实现
}

-(void)beginRefresh{
    //子类实现
}

-(void)endRefresh{
    //子类实现
}

-(void)cancelRefresh{
    //子类实现
}

-(void)registerObserverForScrollView{
    //子类实现
}
@end
