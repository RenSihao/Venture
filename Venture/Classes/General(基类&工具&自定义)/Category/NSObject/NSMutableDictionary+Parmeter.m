//
//  NSMutableDictionary+Parmeter.m
//  WeiXueProject
//
//  Created by TBXark on 15/5/6.
//  Copyright (c) 2015年 TBXark. All rights reserved.
//

#import "NSMutableDictionary+Parmeter.h"

@implementation NSMutableDictionary (Parmeter)

- (void)xSetObject:(id)anObject forKey:(id<NSCopying>)aKey
{
    if (anObject) {
        [self setObject:anObject forKey:aKey];
    }
}

@end
