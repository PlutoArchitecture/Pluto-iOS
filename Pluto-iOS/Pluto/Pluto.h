//
//  Pluto.h
//  Videor
//
//  Created by minggo on 2017/5/2.
//  Copyright © 2017年 MengMengDa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Pluto : NSObject
@property(nonatomic,copy) NSString * URL_DOMAIN;
@property(nonatomic,copy) NSString * APP_CACHE_FILE;
@property(nonatomic,copy) NSString * IMAGE_CACHE_FILE;
+ (Pluto *) getInstance;
-(void)initPluto:(NSString *)domain cacheFile:(NSString *)cacheFile imageCacheFile:(NSString *)imageCacheFile;
@end
