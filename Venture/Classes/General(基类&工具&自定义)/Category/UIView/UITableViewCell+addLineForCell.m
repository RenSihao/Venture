//
//  UITableViewCell+addLineForCell.m
//  WuMei
//
//  Created by qsit on 15/7/23.
//  Copyright (c) 2015年 QSIT. All rights reserved.
//

#import "UITableViewCell+addLineForCell.h"

#import "Masonry.h"
@implementation UITableViewCell (addLineForCell)
- (void)addLineForBottom{
    weakSelf(self);
    UIView *lineView = [[UIView alloc] init];
    [self addSubview:lineView];
    lineView.backgroundColor = _separatorLineColor_;
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(_separatorLineWidth_));
        make.width.equalTo(@(SCREEN_WIDTH));
        make.bottom.equalTo(weakSelf.mas_bottom).offset(-1);
        make.left.equalTo(weakSelf.mas_left);
    }];
}
- (void)addLineForTop{
    weakSelf(self);
    UIView *lineView = [[UIView alloc] init];
    [self addSubview:lineView];
    lineView.backgroundColor = _separatorLineColor_;
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(_separatorLineWidth_));
        make.width.equalTo(@(SCREEN_WIDTH));
        make.top.equalTo(weakSelf.mas_top).offset(1);
        make.left.equalTo(weakSelf.mas_left);
    }];
}
- (void)addLineForTopWithFloat:(CGFloat)contentFloat{
    weakSelf(self);
    UIView *lineView = [[UIView alloc] init];
    [self addSubview:lineView];
    lineView.backgroundColor = _separatorLineColor_;
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(_separatorLineWidth_));
        make.width.equalTo(@(SCREEN_WIDTH - 2 * contentFloat));
        make.top.equalTo(weakSelf.mas_top).offset(_separatorLineWidth_);
        make.left.equalTo(weakSelf.mas_left).offset(contentFloat);
    }];
}
@end
