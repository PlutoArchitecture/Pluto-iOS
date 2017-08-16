//
//  Pluto.m
//  Videor
//
//  Created by minggo on 2017/5/2.
//  Copyright © 2017年 MengMengDa. All rights reserved.
//

#import "Pluto.h"
//#import "APIURL.h"

static Pluto *singleton = nil;
@implementation Pluto

/**
 初始化Pluto
 @param domain 域名
 @param cacheFile 缓存文件
 @param imageCacheFile 图片缓存文件
 */
-(void)initPluto:(NSString *)domain  cacheFile:(NSString *)cacheFile imageCacheFile:(NSString *)imageCacheFile{
    self.URL_DOMAIN = domain;
    self.APP_CACHE_FILE = cacheFile;
    self.IMAGE_CACHE_FILE = imageCacheFile;
}

+(Pluto *)getInstance{
    
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        singleton = [[super alloc] init];
    });
    return singleton;
}


+ (id)allocWithZone:(NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleton = [super allocWithZone:zone];
    });
    return singleton;
}

-(id)copyWithZone:(NSZone *)zone{
    return singleton;
}

@end
