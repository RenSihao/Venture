//
//  UIViewController+showHUD.m
//  SchoolBuy
//
//  Created by qsit on 15/7/13.
//  Copyright (c) 2015年 Hank. All rights reserved.
//

//默认高度和宽度
#define SeaPromptViewWidth 160.0
#define SeaPromptViewHeight 80.0

#import "UIViewController+showHUD.h"

//#import "NSUserDefaultKeys.h"
#import "UIView+Screen.h"
#import "Util.h"
#import "SeaNetworkActivityView.h"
#import "SeaPromptView.h"

@implementation UIViewController (showHUD)

-(void)showTextHud:(NSString*)message
{
    [self showtextHUDWith:message andDelay:2.0];
}

- (void)showTextHudNoTab:(NSString *)message{
    [self showtextHUDWith:message andDelay:2.0];
}

- (void)showTextHud:(NSString *)message delay:(int)delay{
    [self showtextHUDWith:message andDelay:delay];
}

-(void)showIndeterminateHud:(NSString *)text delay:(int)delay{
    [self showHUD];
    self.view.userInteractionEnabled = NO;;
}

- (void)showHUD{
    SeaNetworkActivityView *seaNet = [[SeaNetworkActivityView alloc] init];
    [self.view addSubview:seaNet];
    [self.view bringSubviewToFront:seaNet];
}

- (void)showtextHUDWith:(NSString *)msg andDelay:(int)delay{
    SeaPromptView *alertView = [[SeaPromptView alloc] initWithFrame:CGRectMake((self.view.width - SeaPromptViewWidth) / 2.0, (self.contentHeight - SeaPromptViewHeight) / 2.0, SeaPromptViewWidth, SeaPromptViewHeight) message:msg];
    [self.view addSubview:alertView];
    alertView.removeFromSuperViewAfterHidden = NO;
    alertView.messageLabel.text = msg;
    [self.view bringSubviewToFront:alertView];
    [alertView showAndHideDelay:delay];
}

- (void)hideHud{
    for (UIView *view in self.view.subviews) {
        if ([view isKindOfClass:[SeaNetworkActivityView class]]) {
            [view removeFromSuperview];
        }
        else if ([view isKindOfClass:[SeaPromptView class]]){
            [view removeFromSuperview];
        }
    }
    self.view.userInteractionEnabled = YES;
}

- (void)showSeaAlertViewWithDelegate:(id)delegate andMessage:(NSString *)str isWithCancelButton:(BOOL)isWithCancel{
    NSArray *buttonTitleArr;
    if (isWithCancel) {
        buttonTitleArr = @[@"取消",@"确定"];
    }
    else{
        buttonTitleArr = @[@"确定"];
    }
    SeaAlertView *alert = [[SeaAlertView alloc] initWithTitle:str otherButtonTitles:buttonTitleArr];
    alert.delegate = delegate;
    if (isWithCancel) {
        [alert setButtonTitleColor:kDefaultColor forIndex:1];
    }
    else{
        [alert setButtonTitleColor:kDefaultColor forIndex:0];
    }
    [alert show];
}

- (void)disMissAlertView{
    for (UIView *view in self.view.subviews) {
        if ([view isKindOfClass:[SeaAlertView class]]) {
            [(SeaAlertView *)view dismiss];
        }
    }
}
@end
