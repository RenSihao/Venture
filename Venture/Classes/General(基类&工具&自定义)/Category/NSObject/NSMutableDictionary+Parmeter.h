//
//  NSMutableDictionary+Parmeter.h
//  WeiXueProject
//
//  Created by TBXark on 15/5/6.
//  Copyright (c) 2015年 TBXark. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary (Parmeter)

- (void)xSetObject:(id)anObject forKey:(id<NSCopying>)aKey;

@end
