//
//  LoginVC.m
//  Venture
//
//  Created by RenSihao on 16/5/11.
//  Copyright © 2016年 RenSihao. All rights reserved.
//

#import "LoginVC.h"
#import "SSTextView.h"
#import "SeaButton.h"
#import "SPTextFieldView.h"

@interface LoginVC ()

/**
 *  背景图片
 */
@property (nonatomic, strong) UIImageView *backgroundImageView;
/**
 *  logo图标
 */
@property (nonatomic, strong) UIImageView *iconImageView;
/**
 *  账号框
 */
@property (nonatomic, strong) SPTextFieldView *accountTextView;
/**
 *  密码框
 */
@property (nonatomic, strong) SPTextFieldView *passwordTextView;
/**
 *  登录按钮
 */
@property (nonatomic, strong) SeaButton *loginBtn;
/**
 *  注册按钮
 */
@property (nonatomic, strong) SeaButton *registerBtn;
@end

@implementation LoginVC

#pragma mark - init

#pragma mark - Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self addAllSubViews];
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBarHidden = NO;
}

#pragma mark - 

- (void)addAllSubViews
{
    [super addAllSubViews];
    
    [self.view addSubview:self.backgroundImageView];
    [self.view addSubview:self.iconImageView];
    [self.view addSubview:self.accountTextView];
    [self.view addSubview:self.passwordTextView];
    [self.view addSubview:self.loginBtn];
    [self.view addSubview:self.registerBtn];
}

#pragma mark - layout

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    CGFloat margin = 20;
    CGFloat buttonWidth = SCREEN_WIDTH*0.8;
    CGFloat buttonHeight = 51;
    
    [self.backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).offset(64);
        make.centerX.mas_equalTo(self.view);
        make.width.height.mas_equalTo(SCREEN_WIDTH / 2);
    }];
    
    [self.accountTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.iconImageView.mas_bottom).offset(40);
        make.centerX.mas_equalTo(self.view);
        make.width.mas_equalTo(buttonWidth);
        make.height.mas_equalTo(buttonHeight);
    }];
    
    [self.passwordTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.accountTextView.mas_bottom).offset(margin);
        make.centerX.width.height.mas_equalTo(self.accountTextView);
    }];
    
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.passwordTextView.mas_bottom).offset(2*margin);
        make.centerX.width.height.mas_equalTo(self.passwordTextView);
    }];
    
    [self.registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.loginBtn.mas_bottom).offset(margin);
        make.centerX.width.height.mas_equalTo(self.loginBtn);
    }];
}

#pragma mark - layz load

- (UIImageView *)backgroundImageView
{
    if (!_backgroundImageView)
    {
        _backgroundImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_bg.png"]];
        _backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
        _backgroundImageView.layer.masksToBounds = YES;
    }
    return _backgroundImageView;
}
- (UIImageView *)iconImageView
{
    if (!_iconImageView)
    {
        _iconImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_logo.png"]];
        _iconImageView.contentMode = UIViewContentModeScaleAspectFit;
        _iconImageView.layer.masksToBounds = YES;
    }
    return _iconImageView;
}
- (SPTextFieldView *)accountTextView
{
    if (!_accountTextView)
    {
        _accountTextView = [[SPTextFieldView alloc] initWithSPTextFieldImageType:SPTextFieldImageNone];
        _accountTextView.textField.placeholder = @" 账号";
        _accountTextView.textField.textColor = [UIColor whiteColor];
        _accountTextView.textField.keyboardType = UIKeyboardTypePhonePad;
        _accountTextView.layer.cornerRadius = 25;
        _accountTextView.layer.masksToBounds = YES;
        _accountTextView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"gray"]];
    }
    return _accountTextView;
}
- (SPTextFieldView *)passwordTextView
{
    if (!_passwordTextView)
    {
        _passwordTextView = [[SPTextFieldView alloc] initWithSPTextFieldImageType:SPTextFieldImageNone];
        _passwordTextView.textField.placeholder = @" 密码";
        _passwordTextView.textField.textColor = [UIColor whiteColor];
        _passwordTextView.textField.secureTextEntry = YES;
        _passwordTextView.layer.cornerRadius = 25;
        _passwordTextView.layer.masksToBounds = YES;
        _passwordTextView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"gray"]];
    }
    return _passwordTextView;
}
- (SeaButton *)loginBtn
{
    if (!_loginBtn)
    {
        _loginBtn = [[SeaButton alloc] init];
        [_loginBtn setTitle:@"登 录" forState:UIControlStateNormal];
        [_loginBtn setBackgroundImage:[UIImage imageWithColor:UIColorFromRGB_D(92, 192, 212) cornerRadius:0] forState:UIControlStateNormal];
        _loginBtn.layer.cornerRadius = 25;
        _loginBtn.layer.masksToBounds = YES;
    }
    return _loginBtn;
}
- (SeaButton *)registerBtn
{
    if (!_registerBtn)
    {
        _registerBtn = [[SeaButton alloc] init];
        [_registerBtn setTitle:@"注 册" forState:UIControlStateNormal];
        [_registerBtn setBackgroundImage:[UIImage imageWithColor:UIColorFromRGB_D(92, 192, 212) cornerRadius:0] forState:UIControlStateNormal];
        _registerBtn.layer.cornerRadius = 25;
        _registerBtn.layer.masksToBounds = YES;
    }
    return _registerBtn;
}



#pragma mark - Actions

- (void)didClickLogin
{
    
}
- (void)didClickRegister
{
    
}














@end
