//
//  UserModel.h
//  Venture
//
//  Created by RenSihao on 16/5/11.
//  Copyright © 2016年 RenSihao. All rights reserved.
//

#import "BaseModel.h"

@interface UserModel : BaseModel <NSCoding>

@property (nonatomic, copy) NSString *account;
@property (nonatomic, copy) NSString *password;
@end
