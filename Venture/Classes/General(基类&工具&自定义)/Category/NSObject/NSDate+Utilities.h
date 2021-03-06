//
//  NSDate+timeIntreval.h

//

#import <UIKit/UIKit.h>

/*
字母  日期或时间元素    表示   示例

G      Era标志符      Text   AD

y         年         Year   1996; 96

M      年中的月份     Month  July; Jul; 07   
 
w      年中的周数     Number  27
 
W     月份中的周数    Number   2

D      年中的天数     Number  189

d     月份中的天数    Number  10

F     月份中的星期    Number  2

E     星期中的天数    Text    Tuesday; Tue

a      Am/pm标记     Text    PM

H  一天中的小时数（0-23）Number  0

k  一天中的小时数（1-24） Number 24

K  am/pm中的小时数（0-11）Number  0

h  am/pm中的小时数（1-12）Number  12

m    小时中的分钟数    Number   30

s    分钟中的秒数     Number   55

S     毫秒数         Number   978

z      时区          NSTimeZone   Pacific Standard Time; PST; GMT-08:00

Z      时区       RFC 822 time zone   -0800
*/

///YYYY-MM-dd HH:mm:ss
static NSString *const DateFormatYMdHms = @"YYYY-MM-dd HH:mm:ss";

///YYYY-MM-dd HH:mm
static NSString *const DateFormatYMdHm = @"YYYY-MM-dd HH:mm";

///YYYY-MM-dd
static NSString *const DateFromatYMd = @"YYYY-MM-dd";

//

///YYY/MM/dd HH:mm:ss
static NSString *const DateFormatYMdHmsSlash = @"YYYY/MM/dd HH:mm:ss";

///北京时区
static NSString *const BeiJingTimeZone = @"Asia/BeiJing";

@interface NSDate (Utilities)

#pragma mark- 时间获取

/**通过给定 timeInterval 返回一个距离当前时间的 时间组合
 */
+ (NSDateComponents *)componetsWithTimeInterval:(NSTimeInterval)timeInterval;

/**通过给定时间 返回一个距离当前时间长度的字符串, 01:02:28
 */
+ (NSString *)timeDescriptionOfTimeInterval:(NSTimeInterval)timeInterval;

/**通过日期获取星期
 */
+ (NSString*)getWeekday:(NSInteger) weekday;

/**获取中文月份
 */
+ (NSString*)getChineseMonthFormNum:(NSInteger) num;

/**获取当前时间格式为 YYYY-MM-dd HH:mm:ss
 *@return 当前时间
 */
+ (NSString*)getCurrentTime;

/**通过给的格式获取当前时间
 *@param format 时间格式， 如 YYYY-MM-dd HH:mm:ss
 *@return 当前时间
 */
+ (NSString*)getCurrentTimeWithFormat:(NSString*) format;

/**以当前时间为准，获取以后或以前的时间 时间格式为YYYY-MM-dd HH:mm:ss
 *@param timeInterval 时间间隔 大于0时，获取以后的时间,小于0时，获取以前的时间
 *@return 时间
 */
+ (NSString*)getTimeWithTimeInterval:(NSTimeInterval) timeInterval;

/**以当前时间为准，获取以后或以前的时间
 *@param timeInterval 时间间隔 大于0时，获取以后的时间,小于0时，获取以前的时间
 *@param format 时间格式为，如YYYY-MM-dd HH:mm:ss
 *@return 时间
 */
+ (NSString*)getTimeWithTimeInterval:(NSTimeInterval)timeInterval format:(NSString*) format;

/**通过给定时间，获取以后或以前的时间
 *@param timeInterval 时间间隔 大于0时，获取以后的时间,小于0时，获取以前的时间
 *@param format 时间格式为，如YYYY-MM-dd HH:mm:ss
 *@param time 时间基准
 *@return 时间
 */
+ (NSString*)getTimeWithTimeInterval:(NSTimeInterval)timeInterval format:(NSString *)format time:(NSString*) time;

#pragma mark- 时间转换

/**把时间转换成其他形式 如 当天的不显示日期，08:00 同一个星期内的显示星期几
 *@param datetime 要格式化的时间
 *@Param formatString 时间格式 和 dateTime对应， 如 YYYY-MM-dd HH:mm:ss
 *@return 格式化后的时间，或nil，如果时间格式和时间不对应
 */
+ (NSString*)datetime:(NSString*) datetime formatString:(NSString*) formatString;

/**转换时间成---秒，分 前 如1小时前
 *@param time 要转换的时间
 *@param formatString 时间格式 和 dateTime对应， 如 YYYY-MM-dd HH:mm:ss
*@return 转换后的时间，或nil，如果时间格式和时间不对应
 */
+ (NSString*)previousDateWithTime:(NSString*) time formatString:(NSString*) formatString;

/**时间格式转换 从@"YYYY-MM-dd HH:mm:ss" 转换成给定格式
 *@param format 要转换成的格式
 *@retrun 转换后的时间
 */
+ (NSString*)formatDate:(NSString*) time format:(NSString*) format;

/**时间格式转换
 *@param time 要转换的时间
 *@param fromFormat 要转换的时间的格式
 *@param toFormat 要转换成的格式
 *@retrun 转换后的时间
 */
+ (NSString*)formatDate:(NSString*) time fromFormat:(NSString*) fromFormat toFormat:(NSString*) toFormat;

#pragma mark- 时间比较

/**判断给定时间距离当前时间是否超过这个时间段
 *@param time 要比较的时间
 *@param timeInterval 时间约束
 */
+ (BOOL)compareTime:(NSString*) time beyondTimeIntervalFromNow:(NSTimeInterval) timeInterval;

/**判断两个时间的间隔是否超过这个时间段
 *@param time1 要比较的时间1
 *@param time2 要比较的时间2
 *@param timeInterval 时间约束
 */
+ (BOOL)compareTime:(NSString *)time1 andTime:(NSString*) time2 beyondTimeInterval:(NSTimeInterval)timeInterval;

/**比较两个时间是否相等
 */
+ (BOOL)isTime:(NSString*) time1 equalTime:(NSString*) time2;

#pragma mark- other

/**当前时间和随机数生成的字符串
 *@return 如 1989072407080998
 */
+ (NSString*)getTimeAndRandom;

/**通过出生日期获取年龄
 *@param date 出生日期
 *@param format 时间格式
 *@return 年龄，如 16岁
 */
+ (NSString*)ageFromBirthDate:(NSString*) date format:(NSString*) format;

/**计算时间距离现在有多少秒
 */
+ (NSTimeInterval)timeIntervalFromNowWithDate:(NSString*) date;

/**通过时间戳获取具体时间
*@param time 时间戳，是距离1970年到当前的秒
*@param 要返回的时间格式
*@return 具体时间
*/
+ (NSString*)formatTimeInterval:(NSString*) time format:(NSString*) format;

@end
