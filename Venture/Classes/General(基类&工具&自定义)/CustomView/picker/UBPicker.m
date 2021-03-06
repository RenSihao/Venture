////
////  UBPicker.m
//
////
//
//#import "UBPicker.h"
//#import "WMWealthOperation.h"
//#import "SeaHttpRequest.h"
//
//static NSTimeInterval oneYear = 24 * 60 * 60 * 365;
//
//@interface UBPicker ()<SeaHttpRequestDelegate,UIPickerViewDelegate,UIPickerViewDataSource>
//
////父视图
//@property(nonatomic,weak) UIView *mySuperView;
//
////选择器上方的视图
//@property(nonatomic,strong) UIView *topView;
//
////完成按钮
//@property(nonatomic,strong) UIButton *finishButton;
//
////取消按钮
//@property(nonatomic,strong) UIButton *cancelButton;
//
////菜单
//@property(nonatomic,strong) UIView *menu;
//
////内容
//@property(nonatomic,strong) UIView *contentView;
//
////网络请求
//@property(nonatomic,strong) SeaHttpRequest *httpRequest;
//
////加载指示器
//@property(nonatomic,strong) UIActivityIndicatorView *indicatorView;
//
////重新加载
//@property(nonatomic,strong) UIButton *reloadButton;
//
//
//
//@end
//
//@implementation UBPicker
//
///**构造方法
// *@param superView 选择器父视图
// *@param style 选择器类型
// */
//- (id)initWithSuperView:(UIView *)superView style:(UBPickerStyle)style
//{
//    CGFloat height = _UBPickerHeight_;
//    self = [super initWithFrame:CGRectMake(0, SCREEN_HEIGHT, superView.width, height)];
//    if(self)
//    {
//        self.backgroundColor = [UIColor clearColor];
//        self.mySuperView = superView;
//        
//        //菜单
//        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, 35.0)];
//        view.backgroundColor = _appMainColor_;
//      
//        self.menu = view;
//        
//        _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, height)];
//        _contentView.backgroundColor = [UIColor whiteColor];
//        [self addSubview:_contentView];
//        
//        [_contentView addSubview:self.menu];
//        
//        CGFloat buttonWidth = 70.0;
//        
//        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(buttonWidth, 0, self.menu.width - buttonWidth * 2, self.menu.height)];
//        _titleLabel.backgroundColor = [UIColor clearColor];
//        [_titleLabel setTextAlignment:NSTextAlignmentCenter];
//        [_titleLabel setTextColor:[UIColor whiteColor]];
//        [_titleLabel setFont:[UIFont fontWithName:MainFontName size:13.0]];
//        [self.menu addSubview:_titleLabel];
//        
//        //完成
//        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//        [btn setFrame:CGRectMake(self.width - buttonWidth, 0, buttonWidth, _titleLabel.height)];
//        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        [btn setTitle:@"完成" forState:UIControlStateNormal];
//        [btn addTarget:self action:@selector(finish:) forControlEvents:UIControlEventTouchUpInside];
//        [self.menu addSubview:btn];
//        self.finishButton = btn;
//        
//        btn = [UIButton buttonWithType:UIButtonTypeCustom];
//        [btn setFrame:CGRectMake(0, 0, buttonWidth, _titleLabel.height)];
//        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        [btn setTitle:@"取消" forState:UIControlStateNormal];
//        [btn addTarget:self action:@selector(dismiss:) forControlEvents:UIControlEventTouchUpInside];
//        [self.menu addSubview:btn];
//        self.cancelButton = btn;
//        self.style = style;
//        [self setCloseWhenTouchMargin:YES];
//        
//        if(style != UBPickerStyleBlank)
//        {
//            [self reloadDataWithStyle:style];
//        }
//        else
//        {
//            self.httpRequest = [[SeaHttpRequest alloc] initWithDelegate:self];
//            [self loadBlankInfo];
//        }
//    }
//    return self;
//}
//
////加载银行信息
//- (void)loadBlankInfo
//{
//    self.reloadButton.hidden = YES;
//    if(!self.indicatorView)
//    {
//        self.indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//        self.indicatorView.center = CGPointMake(self.contentView.width / 2.0, self.menu.bottom + (self.contentView.height - self.menu.bottom) / 2.0);
//        [_contentView addSubview:self.indicatorView];
//    }
//    
//    [_contentView bringSubviewToFront:self.indicatorView];
//    
//    [self.indicatorView startAnimating];
//    [self.httpRequest downloadWithURL:SeaNetworkRequestURL dic:[WMWealthOperation blankListParams]];
//}
//
////加载失败
//- (void)failToLoad
//{
//    if(!self.reloadButton)
//    {
//        CGFloat buttonWidth = 70.0;
//        CGFloat buttonHeight = 30.0;
//        _reloadButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        _reloadButton.layer.cornerRadius = 5.0;
//        _reloadButton.layer.masksToBounds = YES;
//        _reloadButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
//        _reloadButton.layer.borderWidth = 1.0;
//        _reloadButton.titleLabel.font = [UIFont fontWithName:MainFontName size:13.0];
//        _reloadButton.frame = CGRectMake((self.contentView.width - buttonWidth) / 2.0, self.menu.bottom + (self.contentView.height - self.menu.bottom - buttonHeight) / 2.0, buttonWidth, buttonHeight);
//        [_reloadButton setTitle:@"重新加载" forState:UIControlStateNormal];
//        [_reloadButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
//        [_reloadButton addTarget:self action:@selector(loadBlankInfo) forControlEvents:UIControlEventTouchUpInside];
//        [_contentView addSubview:_reloadButton];
//    }
//    
//    [self.indicatorView stopAnimating];
//    _reloadButton.hidden = NO;
//}
//
//#pragma mark- htpp
//
//- (void)httpRequest:(SeaHttpRequest *)request didFailed:(SeaHttpErrorCode)error
//{
//    [self failToLoad];
//}
//
//- (void)httpRequest:(SeaHttpRequest *)request didFinishedLoading:(NSData *)data
//{
//    [self.indicatorView stopAnimating];
//    self.blankInfos = [WMWealthOperation blankListFromData:data];
//    if(self.blankInfos.count > 0)
//    {
//        [self reloadDataWithStyle:UBPickerStyleBlank];
//    }
//    else
//    {
//        [self failToLoad];
//    }
//}
//
//#pragma mark- set property
//
//- (void)setCloseWhenTouchMargin:(BOOL)closeWhenTouchMargin
//{
//    if(_closeWhenTouchMargin != closeWhenTouchMargin)
//    {
//        _closeWhenTouchMargin = closeWhenTouchMargin;
//        if(!self.topView)
//        {
//            UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.mySuperView.width, self.mySuperView.height - _UBPickerHeight_)];
//            topView.backgroundColor = [UIColor clearColor];
//            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss:)];
//            [topView addGestureRecognizer:tap];
//            
//            [self addSubview:topView];
//            self.topView = topView;
//        }
//        
//        if(_closeWhenTouchMargin)
//        {
//            self.topView.hidden = NO;
//            self.height = self.mySuperView.height;
//            self.contentView.top = self.topView.bottom;
//            self.datePicker.top = self.menu.bottom;
//        }
//        else
//        {
//            self.topView.hidden = YES;
//            self.contentView.top = 0;
//            self.datePicker.top = self.menu.bottom;
//        }
//    }
//}
//
//#pragma mark- dealloc
//
//- (void)dealloc
//{
//    
//}
//
//#pragma mark- publick method
//
///**呼出选择器
// *@param animated 是否动画
// *@param completion 出现后调用
// */
//- (void)showWithAnimated:(BOOL)animated completion:(void (^)(void))completion
//{
//    if([self.delegate respondsToSelector:@selector(pickerWillAppear:)])
//    {
//        [self.delegate pickerWillAppear:self];
//    }
//    
//    if(self.superview == nil)
//    {
//        [self.mySuperView addSubview:self];
//    }
//    
//    CGRect frame = CGRectMake(self.left, self.mySuperView.height - self.height, self.width, self.height);
//    
//    if(animated)
//    {
//        [UIView animateWithDuration:0.25 animations:^(void){
//            self.frame = frame;
//        }completion:^(BOOL finish){
//            
//            if(completion)
//                completion();
//        }];
//    }
//    else
//    {
//        self.frame = frame;
//        if(completion)
//            completion();
//    }
//}
//
///**隐藏选择器
// *@param animated 是否动画
// *@param completion 隐藏后调用
// */
//- (void)dismissWithAnimated:(BOOL)animated completion:(void (^)(void))completion
//{
//    if([self.delegate respondsToSelector:@selector(pickerWillDismiss:)])
//    {
//        [self.delegate pickerWillDismiss:self];
//    }
//    CGRect frame = CGRectMake(self.left, SCREEN_HEIGHT, self.width, self.height);
//    if(animated)
//    {
//        [UIView animateWithDuration:0.25 animations:^(void){
//            self.frame = frame;
//        }completion:^(BOOL finish){
//            
//            if(completion)
//                completion();
//            if([self.delegate respondsToSelector:@selector(pickerDidDismiss:)])
//            {
//                [self.delegate pickerDidDismiss:self];
//            }
//        }];
//    }
//    else
//    {
//        self.frame = frame;
//        if(completion)
//            completion();
//        if([self.delegate respondsToSelector:@selector(pickerDidDismiss:)])
//        {
//            [self.delegate pickerDidDismiss:self];
//        }
//    }
//}
//
////加载数据
//- (void)reloadDataWithStyle:(UBPickerStyle)style
//{
//    _style = style;
//
//        NSDate *date = nil;
//        switch (style)
//        {
//            case UBPickerStyleBirthDay :
//            {
//                if(!self.datePicker)
//                {
//                    _datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, self.menu.bottom, self.width, _contentView.height - self.menu.height)];
//                    _datePicker.backgroundColor = [UIColor whiteColor];
//                    [_contentView addSubview:_datePicker];
//                }
//                
//                _titleLabel.text = @"出生日期";
//                self.datePicker.datePickerMode = UIDatePickerModeDate;
//                self.datePicker.maximumDate = [NSDate dateWithTimeIntervalSinceNow:- oneYear];
//                date = [NSDate dateWithTimeIntervalSinceNow:- oneYear * 20];
//            }
//                break;
//            case UBPickerStyleBlank :
//            {
//                _titleLabel.text = @"银行";
//                if(!self.picker)
//                {
//                    _picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, self.menu.bottom, self.width, _contentView.height - self.menu.height)];
//                    _picker.delegate = self;
//                    _picker.dataSource = self;
//                    [_contentView addSubview:_picker];
//                }
//            }
//        }
//        
//        [self.datePicker setDate:date animated:NO];
//    
//}
//
//#pragma mark- private method
//
////完成
//- (void)finish:(UIButton*) button
//{
//    NSDictionary *dic = nil;
//    switch (self.style)
//    {
//        case UBPickerStyleBirthDay :
//        {
//            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//            [formatter setDateFormat:@"YYYY-MM-dd"];
//            [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/BeiJing"]];
//            
//            NSString *date = [formatter stringFromDate:self.datePicker.date];
//            dic = [NSDictionary dictionaryWithObject:date forKey:[NSNumber numberWithInteger:self.style]];
//        }
//            break;
//        case UBPickerStyleBlank :
//        {
//            NSString *str = [_blankInfos objectAtIndex:[_picker selectedRowInComponent:0]][@"b_name"];
//            dic = [NSDictionary dictionaryWithObjectsAndKeys:str, [NSNumber numberWithInteger:self.style], nil];
//        }
//    }
//    
//    if([self.delegate respondsToSelector:@selector(picker:didFinisedWithConditions:)])
//    {
//        [self.delegate picker:self didFinisedWithConditions:dic];
//    }
//    [self dismiss:nil];
//}
//
////取消
//- (void)dismiss:(id) sender
//{
//    [self dismissWithAnimated:YES completion:^(void){
//        [self removeFromSuperview];
//    }];
//}
//
//#pragma mark- UIPickerView delegate
//
//- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
//{
//    return 1;
//}
//
//- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
//{
//    return _blankInfos.count;
//}
//
//- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
//{
//    NSString *title = _blankInfos[row][@"b_name"];
//    return title;
//}
//
//@end
