//
//  SeaHttpInterface.h

//

//网络定义的数据
#ifndef Sea_SeaHttpInterface_h
#define Sea_SeaHttpInterface_h

//网络不好请求失败提示信息
static NSString *const SeaAlertMsgWhenBadNetwork = @"网络状态不佳，";

//网络请求方法
static NSString *const SeaHttpRequestMethodPost = @"POST";

//http请求失败错误码
typedef NS_ENUM(NSInteger, SeaHttpErrorCode)
{
    SeaHttpErrorCodeNoError = 0, ///没有错误
    SeaHttpErrorCodeBadNetwork = 1, //网络没连接
    SeaHttpErrorCodeErrorParam = 400, //参数错误
    SeaHttpErrorCodeCanNotFound = 404, //路径找不到
    SeaHttpErrorCodeTimeOut = 408, //请求超时
    SeaHttpErrorCodeNotKnow = 1000, //不清楚的错误
    SeaHttpErrorCodeWriteOperation = 1001, //写入文件出错了
};


#endif
