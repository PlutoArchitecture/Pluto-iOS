//
//  NativeData.h
//  Jimihua
//
//  Created by minggo on 15/10/15.
//  Copyright © 2015年 mengmengda. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfo.h"
#import <objc/runtime.h>
#import "DataManagerStub.h"

@interface NativeData : DataManagerStub
/**
 *  根据沙盒中的key获取实体类
 *
 *  @param key key
 *
 *  @return 实体类
 */
+(id)getNativeDataWithKey:(NSString *) key;
/**
 *  获取沙盒中的用户实体类
 *
 *  @return UserInfo
 */
+(id)getUserInfo;
/**
 *  删除用户信息
 */
+(void)removeUserInfo;
/**
 *  保存本地格式化数据
 *
 *  @param key  key
 *  @param data 数据
 */
+(void)setNativeDataWithKey:(NSString *)key data:(id)data;
/**
 删除本地格式化数据
 @param key key
 */
+(void)removeNativeDataWithKey:(NSString *)key;
/**
 *  保存格式化用户信息
 *
 *  @param user 用户信息实体
 */
+(void)setUser:(UserInfo *)user;
/**
 *  获取唯一标记uuid
 *
 *  @return 唯一标记符
 */
+(NSString *)onlyKey;

@end
