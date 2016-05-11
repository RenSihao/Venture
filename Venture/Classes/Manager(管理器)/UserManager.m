//
//  UserManager.m
//  Venture
//
//  Created by RenSihao on 16/5/11.
//  Copyright © 2016年 RenSihao. All rights reserved.
//

#import "UserManager.h"

@implementation UserManager

+ (instancetype)sharedInstance
{
    static UserManager *userManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        userManager = [[UserManager alloc] init];
    });
    return userManager;
}

#pragma mark - setter && getter

- (void)setUserModel:(UserModel *)userModel
{
    NSData *userData = [NSKeyedArchiver archivedDataWithRootObject:userModel];
    [[NSUserDefaults standardUserDefaults] setObject:userData forKey:UserInfoKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (UserModel *)userModel
{
    NSData *userData = [[NSUserDefaults standardUserDefaults] objectForKey:UserInfoKey];
    UserModel *userModel = [NSKeyedUnarchiver unarchiveTopLevelObjectWithData:userData error:nil];
    return userModel;
}










@end
