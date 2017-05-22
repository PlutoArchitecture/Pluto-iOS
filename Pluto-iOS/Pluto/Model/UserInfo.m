//
//  UserInfo.m
//  NKusFramework
//
//  Created by mmd_mac01 on 15/6/16.
//  Copyright (c) 2015年 minggo. All rights reserved.
//

#import "UserInfo.h"

@implementation UserInfo


- (void)encodeWithCoder:(NSCoder *)coder
{

    [coder encodeObject:[NSNumber numberWithInt:self.uid] forKey:@"uid"];
    [coder encodeObject:[NSNumber numberWithInt:self.sex] forKey:@"sex"];
    [coder encodeObject:self.encryptId forKey:@"encryptId"];
    [coder encodeObject:self.avatar forKey:@"avatar"];
    [coder encodeObject:self.nickName forKey:@"nickName"];
    [coder encodeObject:self.userName forKey:@"username"];
    [coder encodeObject:self.password forKey:@"password"];
    [coder encodeObject:[NSNumber numberWithInt:self.source] forKey:@"source"];
    [coder encodeObject:[NSNumber numberWithInt:self.expire] forKey:@"expire"];
    [coder encodeObject:[NSNumber numberWithInt:self.type] forKey:@"type"];
    
    [coder encodeObject:self.openid forKey:@"openid"];
    [coder encodeObject:self.registerType forKey:@"registerType"];
    [coder encodeObject:self.last_login_time forKey:@"last_login_time"];
    [coder encodeObject:self.payMonthlyEndTime forKey:@"payMonthlyEndTime"];
    [coder encodeObject:[NSNumber numberWithInt:self.recommendTicket] forKey:@"recommendTicket"];
    [coder encodeObject:[NSNumber numberWithInt:self.readExperience] forKey:@"readExperience"];
    [coder encodeObject:[NSNumber numberWithInt:self.gold] forKey:@"gold"];
    [coder encodeObject:[NSNumber numberWithInt:self.vipLevel] forKey:@"vipLevel"];
    [coder encodeObject:[NSNumber numberWithInt:self.commonLevel] forKey:@"commonLevel"];
    [coder encodeObject:[NSNumber numberWithInt:self.isVistor] forKey:@"isVistor"];
    [coder encodeObject:[NSNumber numberWithInt:self.integral] forKey:@"integral"];
    [coder encodeObject:[NSNumber numberWithInt:self.isVipMonthlyPay] forKey:@"isVipMonthlyPay"];
    [coder encodeObject:self.monthlyVipMsg forKey:@"monthlyVipMsg"];
    
   

}
- (instancetype)initWithCoder:(NSCoder *)coder{
    
    if (self=[self init]) {
        
        self.uid = [[coder decodeObjectForKey:@"uid"] intValue];
        self.sex = [[coder decodeObjectForKey:@"sex"] intValue];
        self.encryptId = [coder decodeObjectForKey:@"encryptId"];
        self.userName = [coder decodeObjectForKey:@"username"];
        self.avatar = [coder decodeObjectForKey:@"avatar"];
        self.nickName = [coder decodeObjectForKey:@"nickName"];
        self.password = [coder decodeObjectForKey:@"password"];
        self.source = [[coder decodeObjectForKey:@"source"] intValue];
        self.expire = [[coder decodeObjectForKey:@"expire"] intValue];
        self.type = [[coder decodeObjectForKey:@"type"] intValue];
        
        self.openid = [coder decodeObjectForKey:@"openid"];
        self.registerType = [coder decodeObjectForKey:@"registerType"];
        self.last_login_time = [coder decodeObjectForKey:@"last_login_time"];
        self.payMonthlyEndTime = [coder decodeObjectForKey:@"payMonthlyEndTime"];
        self.recommendTicket = [[coder decodeObjectForKey:@"recommendTicket"] intValue];
        self.readExperience = [[coder decodeObjectForKey:@"readExperience"] intValue];
        self.gold = [[coder decodeObjectForKey:@"gold"] intValue];
        self.vipLevel = [[coder decodeObjectForKey:@"vipLevel"] intValue];
        self.commonLevel = [[coder decodeObjectForKey:@"commonLevel"] intValue];
        self.isVistor = [[coder decodeObjectForKey:@"isVistor"] intValue];
        self.integral = [[coder decodeObjectForKey:@"integral"] intValue];
        self.isVipMonthlyPay = [[coder decodeObjectForKey:@"isVipMonthlyPay"] intValue];
        self.monthlyVipMsg = [coder decodeObjectForKey:@"monthlyVipMsg"];

    }
    
    return self;
}

@end
