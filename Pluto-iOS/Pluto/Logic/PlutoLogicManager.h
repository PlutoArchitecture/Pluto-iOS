//
//  PlutoLogicManager.h
//  Videor
//
//  Created by minggo on 2017/4/27.
//  Copyright © 2017年 MengMengDa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Handler.h"
typedef enum{
    CACHE_ADVANCE_AND_NETWORK_RETURN,
    CACHE_EXPIRED_AND_NETWORK_RETURN,
    ONLY_NETWORK
}LogicType;

typedef enum{
    POST,GET
}NetworkRequestType;

typedef enum{
    MODEL,LIST
}ReturnDataType;

typedef enum{
    
    GET__MODEL__CACHE_ADVANCE_AND_NETWORK_RETURN,
    GET__MODEL__CACHE_EXPIRED_AND_NETWORK_RETURN,
    GET__MODEL__ONLY_NETWORK,
    
    POST__MODEL__CACHE_ADVANCE_AND_NETWORK_RETURN,
    POST__MODEL__CACHE_EXPIRED_AND_NETWORK_RETURN,
    POST__MODEL__ONLY_NETWORK,
    
    GET__LIST__CACHE_ADVANCE_AND_NETWORK_RETURN,
    GET__LIST__CACHE_EXPIRED_AND_NETWORK_RETURN,
    GET__LIST__ONLY_NETWORK,
    
    POST__LIST__CACHE_ADVANCE_AND_NETWORK_RETURN,
    POST__LIST__CACHE_EXPIRED_AND_NETWORK_RETURN,
    POST__LIST__ONLY_NETWORK
    
}LogicManagerType;

@interface PlutoLogicManager : NSObject

//@property(nonatomic,copy) NSString *URL;
//@property(nonatomic,assign) NSInteger WHAT;
//@property(nonatomic,copy) NSString *CACHE_KEY;

-(PlutoLogicManager *)initPlutoLogicManager:(UIHandler)uihandler result:(Class)resultClazz logicType:(LogicManagerType)type;
//-(PlutoLogicManager *)setKVCParamObject:(id)object;
-(PlutoLogicManager *)setURL:(NSString *)url;
-(PlutoLogicManager *)setWhat:(NSInteger)what;
-(PlutoLogicManager *)setCacheKey:(NSString *)cacheKey;
-(PlutoLogicManager *)setParamWithKey:(NSString *)key param:(NSObject *)param;
-(PlutoLogicManager *)setLimitedTime:(NSInteger)min;
-(void)startEngine;
@end
