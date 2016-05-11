//
//  NSAttributedString+Utlities.m

//
//

#import "NSAttributedString+Utlities.h"
#import <CoreText/CoreText.h>

@implementation NSAttributedString (Utlities)

/**获取富文本框大小
 *@param with 每行最大宽度
 *@return 富文本框大小
 */
- (CGSize)boundsWithConstraintWidth:(CGFloat) width
{
    return [self boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading  context:nil].size;
}
@end
