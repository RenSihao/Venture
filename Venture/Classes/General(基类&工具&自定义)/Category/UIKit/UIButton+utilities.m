//
//  UIButton+utilities.m
//  WestMailDutyFee
//
//  Created by 罗海雄 on 15/8/30.
//  Copyright (c) 2015年 qianseit. All rights reserved.
//

#import "UIButton+utilities.h"

@implementation UIButton (utilities)

/**设置按钮的图片位于文本右边
 *@param interval 按钮与标题的间隔
 */
- (void)setButtonIconToRightWithInterval:(CGFloat) interval
{
    [self layoutIfNeeded];
    
    UIImage *image = [self imageForState:UIControlStateNormal];
    [self setTitleEdgeInsets:UIEdgeInsetsMake(0, - image.size.width, 0, image.size.width)];
    [self setImageEdgeInsets:UIEdgeInsetsMake(0, self.titleLabel.width + interval, 0, - (self.titleLabel.width - interval))];
}

@end
