//
//  UIViewController+showHUD.h
//  SchoolBuy
//
//  Created by qsit on 15/7/13.
//  Copyright (c) 2015年 Hank. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (showHUD)
- (void)showTextHud:(NSString*)message;
- (void)showTextHudNoTab:(NSString*)message;
- (void)showTextHud:(NSString*)message delay:(int)delay;
- (void)showIndeterminateHud:(NSString *)text delay:(int)delay;
- (void)hideHud;
- (void)showSeaAlertViewWithDelegate:(id)delegate andMessage:(NSString *)str isWithCancelButton:(BOOL)isWithCancel;
- (void)disMissAlertView;
@end
