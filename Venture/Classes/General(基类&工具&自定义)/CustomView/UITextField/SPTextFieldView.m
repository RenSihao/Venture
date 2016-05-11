//
//  SPTextFieldView.m
//  Penkr
//
//  Created by xujiajia on 15/12/7.
//  Copyright © 2015年 ShopEX. All rights reserved.
//

#import "SPTextFieldView.h"
@interface SPTextFieldView () <UITextFieldDelegate>

@end

@implementation SPTextFieldView

#pragma mark - init

//图片模式接口实现
- (instancetype)initWithSPTextFieldImageType:(SPTextFieldImageType)type
{
    self.imageType = type;
    return [self initWithFrame:self.frame];
}
//系统最终调用该方法
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        //添加子控件
        [self addAllSubViews];
        
        //初始化属性
        [self setUpAttribute];
    }
    return self;
}
//设置属性
- (void)setUpAttribute
{
    //设置圆角
    [self.layer setCornerRadius:2.f];
    [self.layer setMasksToBounds:YES];
    //设置边框
    [self.layer setBorderWidth:1.f];
    [self.layer setBorderColor:[UIColorFromRGB_0x(0xbfbfbf) CGColor]];
}

#pragma mark - 子控件
- (void)addAllSubViews
{
    [self addSubview:self.imageBtn];
    [self addSubview:self.textField];
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //左图模式
    if(self.imageType == SPTextFieldImageLeft)
    {
        [self.imageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mas_top).offset(11);
            make.left.mas_equalTo(self.mas_left).offset(13);
            make.width.height.mas_equalTo(20);

        }];
        [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.right.mas_equalTo(self);
            make.left.mas_equalTo(self.imageBtn.mas_right).offset(11);
        }];

    }
    //右图模式
    else if (self.imageType == SPTextFieldImageRight)
    {
        [self.imageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mas_top).offset(12);
            make.right.mas_equalTo(self.mas_right).offset(-13);
            make.width.mas_equalTo(25);
            make.height.mas_equalTo(20);
        }];
        [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.mas_equalTo(self);
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(self.imageBtn.mas_left).offset(0);
        }];
    }
    //无图模式
    else if(self.imageType == SPTextFieldImageNone)
    {
        [self.imageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.left.height.mas_equalTo(self);
            make.width.mas_equalTo(10);
        }];
        [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.right.mas_equalTo(self);
            make.left.mas_equalTo(self.imageBtn.mas_right);
        }];
    }
    
}

#pragma mark - lazyload

- (UIButton *)imageBtn
{
    if(!_imageBtn)
    {
        _imageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _imageBtn.imageEdgeInsets = UIEdgeInsetsZero;
        [_imageBtn addTarget:self action:@selector(imageBtnDidClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _imageBtn;
}
- (UITextField *)textField
{
    if(!_textField)
    {
        _textField = [[UITextField alloc] init];
        _textField.delegate = self;
        _textField.backgroundColor = [UIColor clearColor];
        _textField.font = [UIFont systemFontOfSize:18.f];
        _textField.textColor = [UIColor blackColor];
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _textField.secureTextEntry = NO;
        _textField.autocorrectionType = UITextAutocorrectionTypeNo;
        _textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _textField.returnKeyType = UIReturnKeyDone;
        //如果是密文显示，下边这句不管用
        _textField.clearsOnBeginEditing = NO;
    }
    return _textField;
}

#pragma mark - 监听点击事件

- (void)imageBtnDidClick
{
    NSLog(@"%s", __func__);
    if((self.imageType == SPTextFieldImageRight))
    {
        self.imageBtn.selected = !self.imageBtn.selected;
        self.textField.secureTextEntry = !self.textField.secureTextEntry;
    }
}

#pragma mark - UITextFieldDelegate
//- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
//- (void)textFieldDidBeginEditing:(UITextField *)textField
//- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
//- (void)textFieldDidEndEditing:(UITextField *)textField
//
//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
//
//- (BOOL)textFieldShouldClear:(UITextField *)textField
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.textField resignFirstResponder];
    return YES;
}

@end
