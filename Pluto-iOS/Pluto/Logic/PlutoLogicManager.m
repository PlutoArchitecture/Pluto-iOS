//
//  PlutoLogicManager.m
//  Videor
//
//  Created by minggo on 2017/4/27.
//  Copyright © 2017年 MengMengDa. All rights reserved.
//

#import "PlutoLogicManager.h"
#import "Handler.h"
#import "SysInfoParam.h"
#import "PlutoAPIEngine.h"
#import "Result.h"

@implementation PlutoLogicManager{
    
    NSMutableDictionary *params;
    NSString *cacheKey;
    NSInteger minute;
    id reflectParam;
    Class resultClass;
    LogicManagerType logicManagerType;
    UIHandler handler;
    LogicType logicType;
    ReturnDataType returnDataType;
    NetworkRequestType networkRequestType;
    NSString *url;
    NSInteger what;
    
}

-(PlutoLogicManager *)initPlutoLogicManager:(UIHandler)uihandler result:(Class)resultClazz logicType:(LogicManagerType)type{
    
    handler = uihandler;
    resultClass = resultClazz;
    logicManagerType = type;
    [self splitEnum:logicManagerType];
    return self;
}

/*-(PlutoLogicManager *)setKVCParamObject:(id)object{
    
    reflectParam = object;
    url = [object valueForKey:@"URL"]==nil?@"没有定义URL":[object valueForKey:@"URL"];
    
    what = (int)[object valueForKey:@"WHAT"];
    cacheKey = [object valueForKey:@"CACHE_KEY"];
    
    NSLog(@"KVCParamObject url-->%@",url);
    
    return self;
}*/

-(PlutoLogicManager *)setURL:(NSString *)_url{
    url = _url;
    return self;
    
}
-(PlutoLogicManager *)setWhat:(NSInteger)_what{
    what = _what;
    return self;
    
}
-(PlutoLogicManager *)setCacheKey:(NSString *)_cacheKey{
    cacheKey = _cacheKey;
    return self;
}

-(PlutoLogicManager *)setParamWithKey:(NSString *)key param:(NSObject *)param{
    
    [params setObject:param forKey:key];
    return self;
}

-(PlutoLogicManager *)setLimitedTime:(NSInteger)min{
    minute = min;
    return self;
}

-(NSMutableDictionary *)getParam{
    if (params==nil) {
        params = [SysInfoParam getInstance].URLParams;
    }
    return params;
}

-(id)init{
    
    if (self = [super init]) {
        [self getParam];
    }
    return self;
}

-(void)splitEnum:(LogicManagerType)type{
    
    NSString *strType = [self getLogicManagerTypeStr:type];
    NSArray<NSString *> *strArray = [strType componentsSeparatedByString:@"__"];
    networkRequestType = [self getNetworkRequestType:strArray[0]];
    returnDataType = [self getReturnDataType:strArray[1]];
    logicType = [self getLogicType:strArray[2]];
    
}

-(NetworkRequestType)getNetworkRequestType:(NSString *) type{
    if ([type isEqualToString:@"POST"]) {
        return POST;
    }else if ([type isEqualToString:@"GET"]){
        return GET;
    }
    return GET;
}

-(ReturnDataType)getReturnDataType:(NSString *)type{
    
    if ([type isEqualToString:@"MODEL"]) {
        return MODEL;
    }else if ([type isEqualToString:@"LIST"]){
        return LIST;
    }
    return MODEL;
}

-(LogicType)getLogicType:(NSString *)type{
    if ([type isEqualToString:@"CACHE_ADVANCE_AND_NETWORK_RETURN"]) {
        return CACHE_ADVANCE_AND_NETWORK_RETURN;
    }else if ([type isEqualToString:@"CACHE_ADVANCE_AND_NETWORK_RETURN"]){
        return CACHE_ADVANCE_AND_NETWORK_RETURN;
    }else if ([type isEqualToString:@"ONLY_NETWORK"]){
        return ONLY_NETWORK;
    }
    return ONLY_NETWORK;
}

-(NSString *)getLogicManagerTypeStr:(LogicManagerType)type{
    
    NSString *str = @"";
    
    switch (type) {
        case GET__MODEL__CACHE_ADVANCE_AND_NETWORK_RETURN:
            str = @"GET__MODEL__CACHE_ADVANCE_AND_NETWORK_RETURN";
            break;
        case GET__MODEL__CACHE_EXPIRED_AND_NETWORK_RETURN:
            str = @"GET__MODEL__CACHE_EXPIRED_AND_NETWORK_RETURN";
            break;
        case GET__MODEL__ONLY_NETWORK:
            str = @"GET__MODEL__ONLY_NETWORK";
            break;
        case POST__MODEL__CACHE_ADVANCE_AND_NETWORK_RETURN:
            str = @"POST__MODEL__CACHE_ADVANCE_AND_NETWORK_RETURN";
            break;
        case POST__MODEL__CACHE_EXPIRED_AND_NETWORK_RETURN:
            str = @"POST__MODEL__CACHE_EXPIRED_AND_NETWORK_RETURN";
            break;
        case POST__MODEL__ONLY_NETWORK:
            str = @"POST__MODEL__ONLY_NETWORK";
            break;
        case GET__LIST__CACHE_ADVANCE_AND_NETWORK_RETURN:
            str = @"GET__LIST__CACHE_ADVANCE_AND_NETWORK_RETURN";
            break;
        case GET__LIST__CACHE_EXPIRED_AND_NETWORK_RETURN:
            str = @"GET__LIST__CACHE_EXPIRED_AND_NETWORK_RETURN";
            break;
        case GET__LIST__ONLY_NETWORK:
            str = @"GET__LIST__ONLY_NETWORK";
            break;
            
        case POST__LIST__CACHE_ADVANCE_AND_NETWORK_RETURN:
            str = @"POST__LIST__CACHE_ADVANCE_AND_NETWORK_RETURN";
            break;
        case POST__LIST__CACHE_EXPIRED_AND_NETWORK_RETURN:
            str = @"POST__LIST__CACHE_EXPIRED_AND_NETWORK_RETURN";
            break;
        case POST__LIST__ONLY_NETWORK:
            str = @"POST__LIST__ONLY_NETWORK";
            break;
            
        default:
            break;
    }
    return str;
}

-(void)startEngine{
    
    if (networkRequestType == GET){
        if (returnDataType==LIST) {
            if (logicType == CACHE_ADVANCE_AND_NETWORK_RETURN) {
                [[PlutoAPIEngine getInstance] apiListCacheAdvacneGet:resultClass apiURL:url params:params cacheKey:cacheKey callBackHandler:^(NSInteger status, id data, NSString *errorMsg) {
                    handler(what,status,data,errorMsg);
                }];
               
            } else if (logicType == ONLY_NETWORK) {
                [[PlutoAPIEngine getInstance] apiListCacheNoCacheGet:resultClass apiURL:url params:params callBackHandler:^(NSInteger status, id data, NSString *errorMsg) {
                    handler(what,status,data,errorMsg);
                }];
                
            } else if (logicType == CACHE_EXPIRED_AND_NETWORK_RETURN) {
                //TODO: 判断是否过期，过期只拿网络数据，不过去返回缓存同时获取最新数据
            }
        }else if (returnDataType == MODEL){
            
            if ([resultClass isKindOfClass:[Result class]]){
                [[PlutoAPIEngine getInstance] apiJustResultNetWithURL:url param:params callBackHandler:^(NSInteger status, id data, NSString *errorMsg) {
                    Result *result = data;
                    handler(what,status,result,errorMsg);
                }];
            }else {
                
                if (logicType == CACHE_ADVANCE_AND_NETWORK_RETURN) {
                    [[PlutoAPIEngine getInstance] apiModelCacheAdvanceGet:resultClass apiURL:url params:params cacheKey:cacheKey callBackHandler:^(NSInteger status, id data, NSString *errorMsg) {
                        handler(what,status,data,errorMsg);
                    }];
                    
                } else if (logicType == ONLY_NETWORK) {
                    [[PlutoAPIEngine getInstance] apiModelNoCacheGet:resultClass apiURL:url params:params callBackHandler:^(NSInteger status, id data, NSString *errorMsg) {
                        handler(what,status,data,errorMsg);
                    }];
                    
                } else if (logicType == CACHE_EXPIRED_AND_NETWORK_RETURN) {
                    //TODO: 判断是否过期，过期只拿网络数据，不过去返回缓存同时获取最新数据
                }
            }
        }
    }else if (networkRequestType == POST){
        if (returnDataType==LIST) {
            
            [[PlutoAPIEngine getInstance] apiListCacheNoCachePost:resultClass apiURL:url params:params callBackHandler:^(NSInteger status, id data, NSString *errorMsg) {
                handler(what,status,data,errorMsg);
            }];
        }else if (returnDataType == MODEL){
            if ([resultClass isKindOfClass:[Result class]]){
                [[PlutoAPIEngine getInstance] apiJustResultNetWithURLPost:url param:params callBackHandler:^(NSInteger status, id data, NSString *errorMsg) {
                    handler(what,status,data,errorMsg);
                }];
                
            }else {
                if (logicType == CACHE_ADVANCE_AND_NETWORK_RETURN) {
                    //TODO:以后根据需求添加post
                } else if (logicType == ONLY_NETWORK) {
                    [[PlutoAPIEngine getInstance] apiModelNoCachePost:resultClass apiURL:url params:params callBackHandler:^(NSInteger status, id data, NSString *errorMsg) {
                        handler(what,status,data,errorMsg);
                    }];
                } else if (logicType == CACHE_EXPIRED_AND_NETWORK_RETURN) {
                    //TODO:以后根据需求添加post
                    
                }
            }
        }
        
    }
}

@end
