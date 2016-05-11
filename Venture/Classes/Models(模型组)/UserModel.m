//
//  UserModel.m
//  Venture
//
//  Created by RenSihao on 16/5/11.
//  Copyright © 2016年 RenSihao. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel

/**
 *  归档
 *
 *  @param aDecoder
 *
 *  @return
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init])
    {
        self.account = [aDecoder decodeObjectForKey:@"account"];
        self.password = [aDecoder decodeObjectForKey:@"password"];
    }
    return self;
}

/**
 *  解档
 *
 *  @param aCoder
 */
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.account forKey:@"account"];
    [aCoder encodeObject:self.password forKey:@"password"];
}


@end
