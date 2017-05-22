//
//  PlutoAPIEngine.h
//  Videor
//
//  Created by minggo on 2017/5/2.
//  Copyright © 2017年 MengMengDa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MKNetworkEngine.h"
#import "Handler.h"
@interface PlutoAPIEngine : MKNetworkEngine
extern NSString *const NET_CACHE;
/**
 * 缓存优先回调到页面上，缓存没有或者过期后才获取网络数据，转化成Model回调到页面
 */
-(MKNetworkOperation *) apiModelCacheAdvanceGet:(Class) clazz apiURL:(NSString *)apiURL params:(NSDictionary *)params cacheKey:(NSString *)key callBackHandler:(CallBackHandler)
callBackHandler;

/**
 * 不考虑缓存，直接获取网络数据，转化成model回调到页面上
 */
-(MKNetworkOperation *) apiModelNoCacheGet:(Class) clazz apiURL:(NSString *) apiURL params:(NSDictionary *)params callBackHandler:(CallBackHandler)
callBackHandler;

/**
 * 缓存优先，缓存没有或者过期才获取网络数据，转成成List回调到页面上
 */
-(MKNetworkOperation *) apiListCacheAdvacneGet:(Class) clazz apiURL:(NSString *) apiURL params:(NSDictionary *) params cacheKey:(NSString *)key  callBackHandler:(CallBackHandler) callBackHandler;

/**
 * 不考虑缓存，直接获取获取网络数据，转成List回调到页面上
 */
-(MKNetworkOperation *) apiListCacheNoCacheGet:(Class) clazz apiURL:(NSString *) apiURL params:(NSDictionary *) params callBackHandler:(CallBackHandler) callBackHandler;

/**
 *  只考虑返回的直接的json结果
 *  @param apiURL          请求的URL
 *  @param params          参数
 *  @param callBackHandler 回调方法
 *
 */
-(MKNetworkOperation *) apiJustResultNetWithURL:(NSString *) apiURL param:(NSDictionary *) params callBackHandler:(CallBackHandler) callBackHandler;

+(PlutoAPIEngine *) getInstance;
/**
 *  直接获取网络数据显示并保存，不考虑缓存显示
 *
 *  @param clazz           回调实体类型
 *  @param apiURL          请求URL
 *  @param params          参数
 *  @param key             key样子
 *  @param callBackHandler 回调函数
 *
 *  @return 网络请求操作实体
 */
-(MKNetworkOperation *) apiModelFromNetThanCached:(Class) clazz apiURL:(NSString *)apiURL params:(NSDictionary *)params cacheKey:(NSString *)key callBackHandler:(CallBackHandler)
callBackHandler;
/**
 *  显示缓存，网络数据只做保存不返回页面
 *
 *  @param clazz           返回的列表类型
 *  @param apiURL          请求URL地址
 *  @param params          参数
 *  @param key             缓存key
 *  @param callBackHandler 页面回调接口
 *
 *  @return 网络list
 */
-(MKNetworkOperation *) apiListCacheAdvacneThanNetSaveGet:(Class) clazz apiURL:(NSString *) apiURL params:(NSDictionary *) params cacheKey:(NSString *)key  callBackHandler:(CallBackHandler) callBackHandler;
/**
 *  仅获取网络mode数据部使用缓存[POST]
 *
 *  @param clazz           返回实体类型
 *  @param apiURL          请求地址URL
 *  @param params          请求参数
 *  @param callBackHandler 页面回调接口
 *
 *  @return 返回post请求实体类
 */
-(MKNetworkOperation *) apiModelNoCachePost:(Class) clazz apiURL:(NSString *) apiURL params:(NSDictionary *)params callBackHandler:(CallBackHandler)
callBackHandler;

-(MKNetworkOperation *) apiModelNoCachePostWithReturn:(Class) clazz apiURL:(NSString *) apiURL params:(NSDictionary *)params callBackHandler:(BOOL(^)(int status,id data,NSString *errorMsg)) callBackHandler;
/**
 *  仅获取网络mode数据部使用缓存[POST]
 *
 *  @param clazz           返回实体类型
 *  @param apiURL          请求URL地址
 *  @param params          请求参数
 *  @param callBackHandler 页面回调接口
 *
 *  @return 返回post请求的list
 */
-(MKNetworkOperation *) apiListCacheNoCachePost:(Class) clazz apiURL:(NSString *) apiURL params:(NSDictionary *) params callBackHandler:(CallBackHandler) callBackHandler;
/**
 *  获取本地缓存数据，如果没有缓存,获取网络数据并返回，如果有返回缓存，获取网络数据保存不返回
 *
 *  @param clazz           返回的列表的元素的实体类
 *  @param apiURL          请求接口抵制
 *  @param params          请求地址参数
 *  @param key             保存的key
 *  @param callBackHandler 回调接口
 *
 *  @return 返回get到的列表结构
 */
-(MKNetworkOperation *) apiListCacheReturnThanNetSaveGet:(Class) clazz apiURL:(NSString *) apiURL params:(NSDictionary *) params cacheKey:(NSString *)key  callBackHandler:(CallBackHandler) callBackHandler;
/**
 *  上传文件
 *
 *  @param clazz           返回类型
 *  @param apiURL          URL地址
 *  @param filePath        文件路径
 *  @param key             文件参数
 *  @param params          参数
 *  @param callBackHandler 回调页面
 *
 *  @return 返回类型实体
 */
-(MKNetworkOperation *) apiModelNoCacheImagePost:(Class) clazz apiURL:(NSString *) apiURL filePath:(NSString *)filePath fileKey:(NSString *) key params:(NSDictionary *)params callBackHandler:(CallBackHandler)callBackHandler;
/**
 *  post请求只返回 Result实体
 *
 *  @param apiURL          请求URL
 *  @param params          请求参数
 *  @param callBackHandler 回调接口
 *
 *  @return 实体类
 */
-(MKNetworkOperation *) apiJustResultNetWithURLPost:(NSString *) apiURL param:(NSDictionary *) params callBackHandler:(CallBackHandler) callBackHandler;

/**
 *  网络优先，没有网络数据显示缓存数据
 *
 *  @param apiURL          请求URL
 *  @param params          请求参数
 *  @param callBackHandler 回调接口
 *
 *  @return 列表类
 */
-(MKNetworkOperation *) apiListNetAdvacneGet:(Class) clazz apiURL:(NSString *) apiURL params:(NSDictionary *) params cacheKey:(NSString *)key  callBackHandler:(CallBackHandler) callBackHandler;
/**
 *  显示缓存，如果缓存没有或者过期获取网路数据并保存
 *
 *  @param clazz           返回类型
 *  @param apiURL          请求URL
 *  @param params          参数
 *  @param key             key
 *  @param callBackHandler 回调函数
 *
 *  @return 实体类
 */
-(MKNetworkOperation *) apiModelReturnCacheAdvanceGet:(Class) clazz apiURL:(NSString *)apiURL params:(NSDictionary *)params cacheKey:(NSString *)key callBackHandler:(CallBackHandler)
callBackHandler;
/**
 *  只用网络数据，并且更新本数据
 *
 *  @param clazz           返回类型
 *  @param apiURL          请求URL
 *  @param params          参数
 *  @param key             key
 *  @param callBackHandler 回调接口
 *
 *  @return 列表
 */
-(MKNetworkOperation *) apiListNetAdvacneThenSaveGet:(Class) clazz apiURL:(NSString *) apiURL params:(NSDictionary *) params cacheKey:(NSString *)key  callBackHandler:(CallBackHandler) callBackHandler;
@end
