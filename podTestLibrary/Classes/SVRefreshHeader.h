//
//  SVRefreshHeader.h
//  下拉刷新
//
//  Created by hu on 15/7/30.
//  Copyright (c) 2015年 hu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SVRefreshBase.h"
/**
 *  下拉刷新
 */
@interface SVRefreshHeader : SVRefreshBase

#pragma mark -下拉刷新额外属性
@property (nonatomic)float lastPosition;//拉动到的位置
@property (strong,nonatomic)UILabel *headerlabel;//下拉显示的label
@property (strong,nonatomic)UIImageView *headerImaV;//下拉显示的图像

@end
