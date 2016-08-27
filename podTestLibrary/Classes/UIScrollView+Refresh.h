//
//  UIScrollView+Refresh.h
//  SVLibrary
//
//  Created by Mac on 16/8/24.
//  Copyright © 2016年 Sevryou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SVRefreshFooter.h"
#import "SVRefreshHeader.h"

@interface UIScrollView (Refresh)

@property (strong, nonatomic) SVRefreshHeader *refreshheader;
@property (strong, nonatomic) SVRefreshFooter *refreshfooter;

@end
