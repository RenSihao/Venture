//
//  SeaHttpRequestParam.m

//

#import "SeaHttpRequestParam.h"

@implementation SeaHttpRequestParam

- (id)init
{
    self = [super init];
    if(self)
    {
        self.paramType = SeaHttpRequestParamTypeDefault;
    }
    return self;
}

#pragma mark- dealloc

- (void)dealloc
{
    
}

/**参数是否有效
 */
- (BOOL)paramIsAvaliable
{
    return [_value isKindOfClass:[NSString class]] || [_value isKindOfClass:[NSNumber class]] || [_value isKindOfClass:[NSData class]];
}

/**获取二进制的参数值
 */
- (NSData*)NSDataValue
{
    if([_value isKindOfClass:[NSString class]])
    {
        return [(NSString*)_value dataUsingEncoding:NSUTF8StringEncoding];
    }
    else if([_value isKindOfClass:[NSNumber class]])
    {
        return [[NSString stringWithFormat:@"%@", _value] dataUsingEncoding:NSUTF8StringEncoding];
    }
    else
    {
        return (NSData*)_value;
    }
}

/**构造方法 paramType 为SeaHttpRequestParamTypeDefault
 *@param value 参数值 NSString 或 NSNumber
 *@param key 参数
 *@return 一个实例
 */
+ (id)requestParamWithValue:(id) value key:(NSString*) key
{
    SeaHttpRequestParam *param = [[SeaHttpRequestParam alloc] init];
    param.value = value;
    param.key = key;
    
    return param;
}

/**构造方法 paramType 为SeaHttpRequestParamTypeFile
 *@param filePath 参数值,文件全路径
 *@param key 参数
 *@return 一个实例
 */
+ (id)requestParamWithFilePath:(NSString*) filePath key:(NSString*) key
{
    SeaHttpRequestParam *param = [[SeaHttpRequestParam alloc] init];
    param.value = filePath;
    param.key = key;
    param.paramType = SeaHttpRequestParamTypeFile;
    
    return param;
}

/**构造方法
 *@param value 参数值 NSString 或 NSNumber
 *@param key 参数
 *@param type 参数类型
 *@return 一个实例
 */
+ (id)requestParamWithValue:(id) value key:(NSString*) key paramType:(SeaHttpRequestParamType) type
{
    SeaHttpRequestParam *param = [[SeaHttpRequestParam alloc] init];
    param.value = value;
    param.key = key;
    param.paramType = type;
    
    return param;
}



@end
