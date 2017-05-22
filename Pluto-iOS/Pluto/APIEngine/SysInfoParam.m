//
//  SysInfoParam.m
//  NKusFramework
//
//  Created by minggo on 15/6/17.
//  Copyright (c) 2015年 minggo. All rights reserved.
//

#import "SysInfoParam.h"
//#import "MD5Util.h"
#import "CommonCrypto/CommonDigest.h"
#import "NSString+MD5.h"
#import "NativeData.h"

@interface SysInfoParam()
    -(void)initData;
@end


@implementation SysInfoParam

static SysInfoParam *singleton = nil;

-(void)initData{
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary]; //app信息
   // NSString *app_Name = [infoDictionary objectForKey:@"CFBundleName"]; //app名称
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"]; // app版本代号
    NSString *app_Version_Code = [infoDictionary objectForKey:@"IVersionCode"];// app build版本
    [singleton setPlatfromid:[infoDictionary objectForKey:@"IPlatform"]];
    [singleton setVersionName:app_Version];
    [singleton setVersionCode:app_Version_Code];
    [singleton setIphoneVersion:[[UIDevice currentDevice] systemVersion]];
    [singleton setIOSSystem:[[UIDevice currentDevice] model]];
    [singleton setUUID:[NativeData onlyKey]];
    
}

-(NSMutableDictionary *) URLParams{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    NSString *timeSp = [NSString stringWithFormat:@"%d", (int)[[NSDate new] timeIntervalSince1970]];
    //NSLog(@"timeSp:%@",timeSp);
    NSString *strPass=[NSString stringWithFormat:@"%@%@%@%@", [singleton platfromid],[singleton versionCode],timeSp,@"readeriOS"];
    
    strPass=[strPass md5];
    
    [params setObject:[singleton versionCode] forKey:@"versionCode"];
    [params setObject:[singleton versionName] forKey:@"versionName"];
    [params setObject:[singleton platfromid] forKey:@"pid"];
    [params setObject:[singleton IphoneVersion] forKey:@"IphoneVersion"];
    [params setObject:[singleton IOSSystem] forKey:@"setIOSSystem"];
    [params setObject:timeSp forKey:@"timestamp"];
    [params setObject:strPass  forKey:@"pass"];
    [params setObject:[singleton UUID] forKey:@"UUID"];
    
    return params;
}

+(SysInfoParam *) getInstance{
    
    @synchronized(self)
    {
        if (!singleton) {
            // 这里调用alloc方法会进入下面的allocWithZone方法
            singleton = [[self alloc] init];
            //[singleton initData];
        }
    }
    
    return singleton;
}
// 这里重写allocWithZone主要防止[[SysInfoParam alloc] init]这种方式调用多次会返回多个对象
+ (id)allocWithZone:(NSZone *)zone
{
    if (!singleton) {
        singleton = [super allocWithZone:zone];
        [singleton initData];
        return singleton;
    }
    
    return nil;
}

- (NSString *)md5HexDigest:(NSString*)input
{
    const char* str = [input UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, strlen(str), result);
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH];
    
    for(int i = 0; i<CC_MD5_DIGEST_LENGTH; i++) {
        [ret appendFormat:@"%2s",result];
    }
    return ret;
}

@end
