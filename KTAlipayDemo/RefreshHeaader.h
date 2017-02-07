//
//  RefreshHeaader.h
//  KTAlipayDemo
//
//  Created by kirito_song on 17/2/6.
//  Copyright © 2017年 kirito_song. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, RefreshType) {
    typeNull = 0,
    typeWillRefresh = 1,
    typeRefreshing = 2,
};

@interface RefreshHeaader : UIView
@property (nonatomic) RefreshType type;
@end
