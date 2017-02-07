//
//  RefreshHeaader.m
//  KTAlipayDemo
//
//  Created by kirito_song on 17/2/6.
//  Copyright © 2017年 kirito_song. All rights reserved.
//

#import "RefreshHeaader.h"

@interface RefreshHeaader ()
@property (nonatomic) UILabel * label;

@end

@implementation RefreshHeaader

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addSubview:self.label];
    }
    return self;
}

- (void)setType:(RefreshType)type {
    switch (type) {
        case typeNull:
        {
            self.label.text = @"默认状态";
        }
            break;
        case typeWillRefresh:
        {
            self.label.text = @"即将刷新";
        }
            break;
        case typeRefreshing:
        {
            self.label.text = @"松手刷新";
        }
            break;
            
        default:
            break;
    }
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    self.label.frame = self.bounds;
}

-(UILabel *)label {
    if (!_label) {
        _label = [UILabel new];
        _label.textAlignment = NSTextAlignmentCenter;
    }
    return _label;
}

@end
