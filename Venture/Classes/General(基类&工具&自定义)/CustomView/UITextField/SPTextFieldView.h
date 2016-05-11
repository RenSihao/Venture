//
//  SPTextFieldView.h
//  Penkr
//
//  Created by xujiajia on 15/12/7.
//  Copyright © 2015年 ShopEX. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, SPTextFieldImageType){
    SPTextFieldImageLeft ,
    SPTextFieldImageRight,
    SPTextFieldImageNone
};

typedef NS_OPTIONS(NSUInteger, Type){
    Account = 1,
    Password,
    RepeatPassword
};



@interface SPTextFieldView : UIView

//子控件
@property (nonatomic, strong) UIButton *imageBtn;
@property (nonatomic, strong) UITextField *textField;

//图片模式
@property (nonatomic, assign) SPTextFieldImageType imageType;

//对外提供一个可以设置图片模式的接口
- (instancetype)initWithSPTextFieldImageType:(SPTextFieldImageType)type;

@end
