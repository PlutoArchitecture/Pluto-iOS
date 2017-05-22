//
//  UserInfo.h
//  NKusFramework
//
//  Created by mmd_mac01 on 15/6/16.
//  Copyright (c) 2015年 minggo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfo : NSObject <NSCoding>
@property(nonatomic,assign) int uid;
@property(nonatomic,assign) int sex;
@property(nonatomic,copy) NSString *encryptId;
@property(nonatomic,copy) NSString *avatar;
@property(nonatomic,copy) NSString *userName;
@property(nonatomic,copy) NSString *nickName;
@property(nonatomic,copy) NSString *password;
@property(nonatomic,assign) int source;
@property(nonatomic,assign) int expire;
@property(nonatomic,copy) NSString *openid;
@property(nonatomic,copy) NSString *registerType;
@property(nonatomic,copy) NSString *last_login_time;
@property(nonatomic,assign) int word_count;
@property(nonatomic,assign) int quote_count;
@property(nonatomic,assign) int recommendTicket;
@property(nonatomic,assign) int readExperience;
@property(nonatomic,assign) int gold;
@property(nonatomic,assign) int isAuthor;
@property(nonatomic,copy) NSString *telephone;
@property(nonatomic,copy) NSString *payMonthlyEndTime;
@property(nonatomic,assign) int vipLevel;
@property(nonatomic,assign) int commonLevel;
/**
 *  [引用用户类型]1：小说 2：灵感 3：代表用户
 */
@property(nonatomic,assign) int type;
/**
 *  关系 0关注  1被关注  2互相关注 3都未关注
 */
@property(nonatomic,assign) int relationStatus;
@property(nonatomic,assign) int isVistor;
@property(nonatomic,assign) int fansLv;
@property(nonatomic,assign) int integral;

/**
 * 0未充值过用户 1已充值用户但未包月 2已充值和已包月用户
 */
@property(nonatomic,assign) int isVipMonthlyPay;
@property(nonatomic,copy) NSString *monthlyVipMsg;

@end
