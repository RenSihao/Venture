//
//  SeaSlashLabel.m
//  Sea

//

#import "SeaSlashLabel.h"

@implementation SeaSlashLabel

- (void)setText:(NSString *)text
{
    //设置斜线样式
    NSAttributedString *attributedText = [[NSAttributedString alloc] initWithString:text attributes:[NSDictionary dictionaryWithObjectsAndKeys:self.font, NSFontAttributeName,self.textColor, NSForegroundColorAttributeName,[NSNumber numberWithUnsignedInteger:NSUnderlineStyleSingle],NSStrikethroughStyleAttributeName,  nil]];
    self.attributedText = attributedText;
}


@end
