//
//  FTWCache.h
//  FTW
//
//  Created by Soroush Khanlou on 6/28/12.
//  Copyright (c) 2012 FTW. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataManagerStub.h"
@interface FTWCache : DataManagerStub

- (void) resetCache:(NSString *)filepath;
- (void) setObject:(NSData*)data forKey:(NSString*)key filepath:(NSString *)filepath;
/**
 *  删除文件
 *
 *  @param filepath 文件所在的文件夹
 *  @param key 文件的名字
 */
- (void) deleteCacheFilePath:(NSString *) filepath filename:(NSString *) key;
/**
 * @description 根据缓存的key获取缓存文件数据
 * @param key 缓存的key
 * @seealso 默认缓存时间为2小时
 */
- (id) objectForKey:(NSString*)key filepath:(NSString *)filepath;
/**
 * @description 根据缓存的key获取缓存数据
 * @param key 缓存的key
 * @seealso 没有缓存过期时间
 */
-(id) objectForKeyWithoutExpire:(NSString *)key filepath:(NSString *)filepath;
-(id) objectForKey:(NSString *) key cacheTimeSeconds:(int) cacheTime filepath:(NSString *)filepath;
/**
 *  判断文件是否存在
 *  @param key      缓存key
 *  @param filePath 文件夹路径
 *  @return 是或否
 */
-(BOOL) isExistFileWithKey:(NSString *)key filePath:(NSString *)filePath;
/**
 *  获取文件相对路径
 *
 *  @param key      key
 *  @param filePath 文件夹路径
 *
 *  @return 文件详细路径
 */
-(NSString *) fileRelatvePathWithKey:(NSString *)key filePath:(NSString *) filePath;

-(float)folderSizeAtPath:(NSString*) folderPath;
/**
 *  总缓存大小
 *
 *  @return 文件夹大小
 */
- (float)readerCacheSize;

/**
 判断文件是否过期

 @param key key
 @param cacheTime 过期时间分钟
 @return BOOL
 */
-(BOOL) isExpiredWithKey:(NSString *) key cacheTimeMin:(NSInteger) cacheTime;

@end
