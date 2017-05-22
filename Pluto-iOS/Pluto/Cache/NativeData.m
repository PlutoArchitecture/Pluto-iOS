//
//  NativeData.m
//  Jimihua
//
//  Created by minggo on 15/10/15.
//  Copyright © 2015年 mengmengda. All rights reserved.
//

#import "NativeData.h"
#import "UserInfo.h"

@implementation NativeData
static NSObject *obj;
+(id)getNativeDataWithKey:(NSString *) key{
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSData *data = [userDefault objectForKey:key];
    
    if (data) {
        return [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
    return nil;
}
+(void)setNativeDataWithKey:(NSString *)key data:(id)data {
    unsigned int count = 0;
    class_copyIvarList([data class], &count);
    
    if(count>0){
        if ((![data isKindOfClass:[NSArray class]]&&![data isKindOfClass:[NSMutableArray class]]&&![NSDictionary isKindOfClass:[NSArray class]])&&![data isKindOfClass:[NSMutableDictionary class]]&&![data isKindOfClass:[NSMutableSet class]]&&![data isKindOfClass:[NSSet class]]) {
            [self initCoder:data];
        }
    }
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSData *datanew = [NSKeyedArchiver archivedDataWithRootObject:data];
    [userDefault setObject:datanew forKey:key];
}

+(void)removeNativeDataWithKey:(NSString *)key{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    
    [defaults removeObjectForKey:key];
    
    [defaults synchronize];
}


/**
 *使用Runtimed对MODEL动态重写encodeWithCoder和initWithCoder方法
 @param data 类
 */
+(void)initCoder:(id)data{
    obj = data;
    class_addMethod([data class], @selector(encodeWithCoder:), (IMP)encodeWithCoder, "v@:@");
    class_addMethod([data class], @selector(initWithCoder:), (IMP)initWithCoder, "id@:@");
}

void encodeWithCoder(id self,SEL _cmd,NSCoder *coder){
    
    unsigned int count = 0;
    Ivar *ivar = class_copyIvarList([obj class], &count);
    for (int i = 0; i<count; i++) {
        Ivar var = ivar[i];
        const char *varName = ivar_getName(var);
        NSString *name = [NSString stringWithUTF8String:varName];
        [coder encodeObject:[obj valueForKey:name] forKey:name];
    }
    
}

id initWithCoder(id self,SEL _cmd,NSCoder *coder){
    
    unsigned int count = 0;
    Ivar *ivar = class_copyIvarList([obj class], &count);
    for (int i = 0; i<count; i++) {
        Ivar var = ivar[i];
        const char *varName = ivar_getName(var);
        NSString *name = [NSString stringWithUTF8String:varName];
        [obj setValue:[coder decodeObjectForKey:name] forKey:name];
    }
    
    return obj;
}


+(id)getUserInfo {
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSData *data = [userDefault objectForKey:@"user_info"];
    
    if (data) {
        return [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
    return nil;
}
+(void)removeUserInfo{
    
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    
    [defaults removeObjectForKey:@"user_info"];
    
    [defaults synchronize];
}

+(void)setUser:(UserInfo *)user {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSData *datanew = [NSKeyedArchiver archivedDataWithRootObject:user];
    [userDefault setObject:datanew forKey:@"user_info"];
}

+(NSString *)onlyKey {
    NSString *key = [self getNativeDataWithKey:@"onlyKey"]==nil?nil:[self getNativeDataWithKey:@"onlyKey"];
    NSLog(@"UUID-->%@",key);
    if (key!=nil&&![key isEqualToString:@""]) {
        return key;
    }else{
        NSUUID *uuid = [NSUUID UUID];
        key = uuid.UUIDString;
        [self setNativeDataWithKey:@"onlyKey" data:key];
        return key;
    }
}

-(void)saveData:(id)data key:(NSString *)key{
    [NativeData setNativeDataWithKey:key data:data];
    
}
-(id)queryData:(NSString *)key{
    return [NativeData getNativeDataWithKey:key];
}
-(void)updateData:(id)data key:(NSString *)key{
    [NativeData setNativeDataWithKey:key data:data];
}
-(void)deleteData:(NSString *)key{
    [NativeData removeNativeDataWithKey:key];
}

@end
