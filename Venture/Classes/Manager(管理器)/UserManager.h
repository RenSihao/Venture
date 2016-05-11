//
//  UserManager.h
//  Venture
//
//  Created by RenSihao on 16/5/11.
//  Copyright © 2016年 RenSihao. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UserModel;

@interface UserManager : NSObject

/**
 *  当前登录用户信息
 */
@property (nonatomic, strong) UserModel *userModel;

/**
 *  用户管理器单例
 *
 *  @return 
 */
+ (instancetype)sharedInstance;
@end
