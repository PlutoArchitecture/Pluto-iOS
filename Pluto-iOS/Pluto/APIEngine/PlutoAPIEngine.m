//
//  PlutoAPIEngine.m
//  Videor
//
//  Created by minggo on 2017/5/2.
//  Copyright © 2017年 MengMengDa. All rights reserved.
//

#import "PlutoAPIEngine.h"
#import "APIURL.h"
#import "FTWCache.h"
#import "Result.h"
#import "UserInfo.h"
#import "HtmlUtil.h"
#import "NSObject+YYModel.h"
#import "DataManagerProxy.h"
#import "Pluto.h"

static PlutoAPIEngine *singleton = nil;
@implementation PlutoAPIEngine
//缓存优先回调到页面上，缓存没有或者过期后才获取网络数据，转化成Model回调到页面
-(MKNetworkOperation *) apiModelCacheAdvanceGet:(Class) clazz apiURL:(NSString *)apiURL params:(NSDictionary *)params cacheKey:(NSString *)key callBackHandler:(CallBackHandler)
callBackHandler{
    
    NSData *cacheContent = [[DataManagerProxy getInstance:FILECACHE] queryData:key];
    
    if (cacheContent&&cacheContent.length>0) {
        NSString *jsonString = [[NSString alloc] initWithData:cacheContent encoding:NSUTF8StringEncoding];
        NSLog(@"apiModelCacheAdvanceGet缓存-->%@",jsonString);
        
        callBackHandler(200,[clazz yy_modelWithJSON:jsonString],@"success");
    }
    
    MKNetworkOperation *op = [singleton operationWithPath:apiURL params:params httpMethod:@"GET"];
    
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        
        NSString *jsonStr = [completedOperation responseString];
        NSLog(@"获取有缓存单个实体网络数据-->%@",[completedOperation responseString]);
        
        Result *result = [Result yy_modelWithJSON:jsonStr];
        
        if (result!=nil) {
            
            if (result.status==200) {//请求成功
                
                id data = [clazz yy_modelWithJSON:result.content];
                
                if (data!=nil) {
                    
                    NSData *jsonData = [data yy_modelToJSONData];
                    [[DataManagerProxy getInstance:FILECACHE] saveData:jsonData key:key];
                    callBackHandler(200,data,@"success");
                }else{
                    callBackHandler(400,nil,@"content中的json部分不是一个NSArray或者是NSDictionary");
                }
                
            }else {//请求失败
                //NSLog(@"请求数据为不符合");
                callBackHandler(result.status,nil,result.errorMsg);
            }
        }else{
            callBackHandler(500,nil,@"failed");
        }
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        callBackHandler(600,error,[error localizedDescription]);
    }];
    
    [singleton enqueueOperation:op];
    
    return op;
    
}

//显示缓存，如果缓存没有或者过期获取网路数据并保存
-(MKNetworkOperation *) apiModelReturnCacheAdvanceGet:(Class) clazz apiURL:(NSString *)apiURL params:(NSDictionary *)params cacheKey:(NSString *)key callBackHandler:(CallBackHandler)
callBackHandler{
    
    NSData *cacheContent =  [[DataManagerProxy getInstance:FILECACHE] queryData:key];
    
    if (cacheContent&&cacheContent.length>0) {
        NSString *jsonString = [[NSString alloc] initWithData:cacheContent encoding:NSUTF8StringEncoding];
        NSLog(@"apiModelCacheAdvanceGet缓存-->%@",jsonString);
        
        callBackHandler(200,[clazz yy_modelWithJSON:jsonString],@"success");
    }else{
        
        MKNetworkOperation *op = [singleton operationWithPath:apiURL params:params httpMethod:@"GET"];
        
        [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
            
            //NSDictionary *data = [completedOperation responseJSON];
            NSString *jsonStr = [completedOperation responseString];
            NSLog(@"获取有缓存单个实体网络数据-->%@",[completedOperation responseString]);
            
            //Result *result = [[Result alloc] initWithString:jsonStr error:nil];
            Result *result = [Result yy_modelWithJSON:jsonStr];
            
            if (result!=nil) {
                
                if (result.status==200) {//请求成功
                    
                    id data = [clazz yy_modelWithJSON:result.content];
                    
                    if (data!=nil) {
                        
                        NSData *jsonData = [data yy_modelToJSONData];
                       
                        [[DataManagerProxy getInstance:FILECACHE] saveData:jsonData key:key];
                        callBackHandler(200,data,@"success");
                    }else{
                        callBackHandler(400,nil,@"content中的json部分不是一个NSArray或者是NSDictionary");
                    }
                    
                }else {//请求失败
                    //NSLog(@"请求数据为不符合");
                    callBackHandler(result.status,nil,result.errorMsg);
                }
            }else{
                callBackHandler(500,nil,@"failed");
            }
        } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
            callBackHandler(600,error,[error localizedDescription]);
        }];
        
        [singleton enqueueOperation:op];
        return op;
    }
    return nil;
    
}

//缓存优先回调到页面上，缓存没有或者过期后才获取网络数据，转化成Model缓存下来不返回页面
-(MKNetworkOperation *) apiModelFromNetThanCached:(Class) clazz apiURL:(NSString *)apiURL params:(NSDictionary *)params cacheKey:(NSString *)key callBackHandler:(CallBackHandler)callBackHandler{
    
    MKNetworkOperation *op = [singleton operationWithPath:apiURL params:params httpMethod:@"GET"];
    
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        
        //NSDictionary *data = [completedOperation responseJSON];
        NSLog(@"获取有缓存单个实体网络数据-->%@",[completedOperation responseString]);
        NSString *jsonstr = [completedOperation responseString];
        //Result *result = [[Result alloc] initWithString:jsonstr error:nil];
        Result *result = [Result yy_modelWithJSON:jsonstr];
        if (result!=nil) {
            if (result.status==200) {//请求成功
                //  NSLog(@"保存用户信息%@",[data objectForKey:@"content"]);
                
                //id data = [[clazz alloc] initWithString:result.content error:nil];
                id data = [clazz yy_modelWithJSON:result.content];
                if (data!=nil) {
                    NSData *jsonData = [data yy_modelToJSONData];
                    
                    [[DataManagerProxy getInstance:FILECACHE] saveData:jsonData key:key];
                    callBackHandler(200,data,@"success");
                }else{
                    callBackHandler(400,nil,@"content中的json部分不是一个NSArray或者是NSDictionary");
                }
                
            }else {//请求失败
                //NSLog(@"请求数据为不符合");
                callBackHandler(result.status,nil,result.errorMsg);
            }
        }else{
            callBackHandler(500,nil,@"failed");
        }
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        callBackHandler(600,error,[error localizedDescription]);
    }];
    
    [singleton enqueueOperation:op];
    
    return op;
    
}




//不考虑缓存，直接获取网络数据，转化成model回调到页面上
-(MKNetworkOperation *) apiModelNoCacheGet:(Class) clazz apiURL:(NSString *) apiURL params:(NSDictionary *)params callBackHandler:(CallBackHandler)
callBackHandler{
    
    MKNetworkOperation *op = [singleton operationWithPath:apiURL params:params httpMethod:@"GET"];
    
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        
        //NSDictionary *data = [completedOperation responseJSON];
        
        NSLog(@"获取无缓存单个实体网络数据-->%@",[completedOperation responseString]);
        
        NSString *jsonStr = [completedOperation responseString];
        //Result *result = [[Result alloc] initWithString:jsonStr error:nil];
        Result *result = [Result yy_modelWithJSON:jsonStr];
        
        if (result!=nil) {
            //NSNumber *status = [data objectForKey:@"status"];
            // NSLog(@"获取的内容-->%@",contentStr);
            
            if (result.status==200) {//请求成功
                callBackHandler(200,[clazz yy_modelWithJSON:result.content],@"success");
            }else{//请求失败
                callBackHandler(result.status,nil,result.errorMsg);
            }
        }else{
            callBackHandler(500,nil,@"failed");
        }
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        callBackHandler(600,nil,[error localizedDescription]);
    }];
    
    [singleton enqueueOperation:op];
    
    return op;
}

//不考虑缓存，直接获取网络数据，转化成model回调到页面上
-(MKNetworkOperation *) apiModelNoCachePost:(Class) clazz apiURL:(NSString *) apiURL params:(NSDictionary *)params callBackHandler:(CallBackHandler)callBackHandler{
    
    MKNetworkOperation *op = [singleton operationWithPath:apiURL params:params httpMethod:@"POST"];
    
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        
        //NSDictionary *data = [completedOperation responseJSON];
        
        NSLog(@"获取无缓存单个实体网络数据-->%@",[completedOperation responseString]);
        
        NSString *jsonStr = [completedOperation responseString];
        
        //Result *result = [[Result alloc] initWithString:jsonStr error:nil];
        
        Result *result = [Result yy_modelWithJSON:jsonStr];
        
        if (result!=nil) {
            
            if (result.status==200) {//请求成功
                callBackHandler(200,[clazz yy_modelWithJSON:result.content],@"success");
            }else{//请求失败
                callBackHandler(result.status,nil,result.errorMsg);
            }
        }else{
            callBackHandler(500,nil,@"failed");
        }
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        callBackHandler(600,nil,[error localizedDescription]);
    }];
    
    [singleton enqueueOperation:op];
    
    return op;
}

//不考虑缓存，直接获取网络数据，转化成model回调到页面上[上传图片]
-(MKNetworkOperation *) apiModelNoCacheImagePost:(Class) clazz apiURL:(NSString *) apiURL filePath:(NSString *)filePath fileKey:(NSString *) key params:(NSDictionary *)params callBackHandler:(CallBackHandler)callBackHandler{
    
    MKNetworkOperation *op = [singleton operationWithPath:apiURL params:params httpMethod:@"POST"];
    [op addFile:filePath forKey:key];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        
        //NSDictionary *data = [completedOperation responseJSON];
        
        NSLog(@"获取无缓存单个实体网络数据-->%@",[completedOperation responseString]);
        
        NSString *jsonStr = [completedOperation responseString];
        
        //Result *result = [[Result alloc] initWithString:jsonStr error:nil];
        
        Result *result = [Result yy_modelWithJSON:jsonStr];
        
        if (result!=nil) {
            
            if (result.status==200) {//请求成功
                callBackHandler(200,[clazz yy_modelWithJSON:result.content],@"success");
            }else{//请求失败
                callBackHandler(result.status,nil,result.errorMsg);
            }
        }else{
            callBackHandler(500,nil,@"failed");
        }
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        callBackHandler(600,nil,[error localizedDescription]);
    }];
    
    [singleton enqueueOperation:op];
    
    return op;
}


-(MKNetworkOperation *) apiModelNoCachePostWithReturn:(Class) clazz apiURL:(NSString *) apiURL params:(NSDictionary *)params callBackHandler:(BOOL(^)(int status,id data,NSString *errorMsg)) callBackHandler{
    MKNetworkOperation *op = [singleton operationWithPath:apiURL params:params httpMethod:@"POST"];
    
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        
        //NSDictionary *data = [completedOperation responseJSON];
        
        NSLog(@"获取无缓存单个实体网络数据-->%@",[completedOperation responseString]);
        
        NSString *jsonStr = [completedOperation responseString];
        
        //Result *result = [[Result alloc] initWithString:jsonStr error:nil];
        Result *result = [Result yy_modelWithJSON:jsonStr];
        if (result!=nil) {
            
            if (result.status==200) {//请求成功
                callBackHandler(200,[clazz yy_modelWithJSON:result.content],@"success");
            }else{//请求失败
                callBackHandler(result.status,nil,result.errorMsg);
            }
        }else{
            callBackHandler(500,nil,@"failed");
        }
        
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        callBackHandler(600,nil,[error localizedDescription]);
    }];
    
    [singleton enqueueOperation:op];
    
    return op;
    
}

//缓存优先，缓存没有或者过期才获取网络数据，转成成List回调到页面上
-(MKNetworkOperation *) apiListCacheAdvacneGet:(Class) clazz apiURL:(NSString *) apiURL params:(NSDictionary *) params cacheKey:(NSString *)key  callBackHandler:(CallBackHandler) callBackHandler{
    
    NSData *cacheContent =  [[DataManagerProxy getInstance:FILECACHE] queryData:key];
    
    //NSLog(@"列表缓存信息%@",[[NSString alloc] initWithData:cacheContent encoding:NSUTF8StringEncoding]);
    if (cacheContent!=nil) {
        //NSString *jsonCache = [[NSString alloc] initWithData:cacheContent encoding:NSUTF8StringEncoding];
        //NSMutableArray *list = [clazz arrayOfModelsFromData:cacheContent error:nil];
        NSMutableArray *list =[NSMutableArray arrayWithArray:[NSArray yy_modelArrayWithClass:clazz json:cacheContent]];
        NSLog(@"缓存不为空");
        callBackHandler(200,list,@"success");
    }else{
        if (cacheContent==nil) {
            NSLog(@"缓存数据为nil");
        }
        // NSLog(@"缓存数据为空");
    }
    
    
    MKNetworkOperation *op = [singleton operationWithPath:apiURL params:params httpMethod:@"GET"];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        
        //NSDictionary *data = [completedOperation responseJSON];
        NSLog(@"获取有缓存列表网络数据-->%@",[completedOperation responseString]);
        NSString *jsonStr = [completedOperation responseString];
        
        //Result *result = [[Result alloc] initWithString:jsonStr error:nil];
        Result *result = [Result yy_modelWithJSON:jsonStr];
        if (result!=nil) {
            NSLog(@"获取列表结果回来了");
            if (result.status==200) {
                
                NSData *data = [result.content yy_modelToJSONData];
                
                NSMutableArray *dataList = [NSMutableArray arrayWithArray:[NSArray yy_modelArrayWithClass:clazz json:data]];
                //NSLog(@"获取列表的长度-->%lu",(unsigned long)[dataList count]);
                if (dataList&&dataList.count>0) {
                    
                    
                    [[DataManagerProxy getInstance:FILECACHE] saveData:data key:key];
                    
                    callBackHandler(200,dataList,@"success");
                }else{
                    callBackHandler(400,nil,@"返回的content中的内容部分json格式不正确");
                }
                
            }else{
                callBackHandler(result.status,nil,result.errorMsg);
            }
            
        }else{
            callBackHandler(500,nil,@"failed");
            
        }
        
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        callBackHandler(600,nil,[error localizedDescription]);
    }];
    
    [singleton enqueueOperation:op];
    
    return op;
}

//网络数据优先，返回数据保存下来
-(MKNetworkOperation *) apiListNetAdvacneThenSaveGet:(Class) clazz apiURL:(NSString *) apiURL params:(NSDictionary *) params cacheKey:(NSString *)key  callBackHandler:(CallBackHandler) callBackHandler{
    
    MKNetworkOperation *op = [singleton operationWithPath:apiURL params:params httpMethod:@"GET"];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        
        NSLog(@"获取有缓存列表网络数据-->%@",[completedOperation responseString]);
        NSString *jsonStr = [completedOperation responseString];
        
        Result *result = [Result yy_modelWithJSON:jsonStr];
        if (result!=nil) {
            NSLog(@"获取列表结果回来了");
            if (result.status==200) {
                NSData *data = [result.content yy_modelToJSONData];
                NSMutableArray *dataList = [NSMutableArray arrayWithArray:[NSArray yy_modelArrayWithClass:clazz json:data]];
                [[DataManagerProxy getInstance:FILECACHE] saveData:data key:key];
                callBackHandler(200,dataList,@"success");
            }else{
                callBackHandler(result.status,nil,result.errorMsg);
            }
        }else{
            callBackHandler(500,nil,@"failed");
        }
        
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        callBackHandler(600,nil,[error localizedDescription]);
    }];
    
    [singleton enqueueOperation:op];
    
    return op;
    
}

//网络数据优先，网络无数据显示缓存，转成成List回调到页面上
-(MKNetworkOperation *) apiListNetAdvacneGet:(Class) clazz apiURL:(NSString *) apiURL params:(NSDictionary *) params cacheKey:(NSString *)key  callBackHandler:(CallBackHandler) callBackHandler{
    
    NSData *cacheContent =  [[DataManagerProxy getInstance:FILECACHE] queryData:key];
    NSMutableArray *list = nil;
    //NSLog(@"列表缓存信息%@",[[NSString alloc] initWithData:cacheContent encoding:NSUTF8StringEncoding]);
    if (cacheContent!=nil) {
        //NSString *jsonCache = [[NSString alloc] initWithData:cacheContent encoding:NSUTF8StringEncoding];
        //NSMutableArray *list = [clazz arrayOfModelsFromData:cacheContent error:nil];
        list =[NSMutableArray arrayWithArray:[NSArray yy_modelArrayWithClass:clazz json:cacheContent]];
        NSLog(@"缓存不为空");
        //callBackHandler(200,list,@"success");
    }else{
        if (cacheContent==nil) {
            NSLog(@"缓存数据为nil");
        }
        // NSLog(@"缓存数据为空");
    }
    
    
    MKNetworkOperation *op = [singleton operationWithPath:apiURL params:params httpMethod:@"GET"];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        
        //NSDictionary *data = [completedOperation responseJSON];
        NSLog(@"获取有缓存列表网络数据-->%@",[completedOperation responseString]);
        NSString *jsonStr = [completedOperation responseString];
        
        //Result *result = [[Result alloc] initWithString:jsonStr error:nil];
        Result *result = [Result yy_modelWithJSON:jsonStr];
        if (result!=nil) {
            NSLog(@"获取列表结果回来了");
            if (result.status==200) {
                
                NSData *data = [result.content yy_modelToJSONData];
                
                //NSMutableArray *dataList = [clazz arrayOfModelsFromData:data error:nil];
                NSMutableArray *dataList = [NSMutableArray arrayWithArray:[NSArray yy_modelArrayWithClass:clazz json:data]];
                //NSLog(@"获取列表的长度-->%lu",(unsigned long)[dataList count]);
                if (dataList&&dataList.count>0) {
                    
                    [[DataManagerProxy getInstance:FILECACHE] saveData:data key:key];
                    
                    callBackHandler(200,dataList,@"success");
                }else{
                    if (list!=nil&&list.count>0) {
                        callBackHandler(200,list,@"success");
                    }else{
                        callBackHandler(400,nil,@"返回的content中的内容部分json格式不正确");
                    }
                    
                }
                
            }else{
                if (list!=nil&&list.count>0) {
                    callBackHandler(200,list,@"success");
                }else{
                    callBackHandler(result.status,nil,result.errorMsg);
                }
            }
            
        }else{
            if (list!=nil&&list.count>0) {
                callBackHandler(200,list,@"success");
            }else{
                callBackHandler(500,nil,@"failed");
            }
        }
        
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        if (list!=nil&&list.count>0) {
            callBackHandler(200,list,@"success");
        }else{
            callBackHandler(600,nil,[error localizedDescription]);
        }
    }];
    
    [singleton enqueueOperation:op];
    
    return op;
}




//先获取缓存显示页面，再判断缓存是否过期，如过期获取网络数据缓存下来，不再返回页面
-(MKNetworkOperation *) apiListCacheAdvacneThanNetSaveGet:(Class) clazz apiURL:(NSString *) apiURL params:(NSDictionary *) params cacheKey:(NSString *)key  callBackHandler:(CallBackHandler) callBackHandler{
    
    NSData *cacheContent =  [[DataManagerProxy getInstance:FILECACHE] queryData:key];
    
    //NSLog(@"列表缓存信息%@",[[NSString alloc] initWithData:cacheContent encoding:NSUTF8StringEncoding]);
    if (cacheContent!=nil) {
        NSLog(@"缓存不为空");
        callBackHandler(200,[NSArray yy_modelArrayWithClass:clazz json:cacheContent],@"success");
    }else{
        if (cacheContent==nil) {
            NSLog(@"缓存数据为nil");
        }
        // NSLog(@"缓存数据为空");
        MKNetworkOperation *op = [singleton operationWithPath:apiURL params:params httpMethod:@"GET"];
        [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
            
            //NSDictionary *data = [completedOperation responseJSON];
            NSLog(@"获取有缓存列表网络数据-->%@",[completedOperation responseString]);
            NSString *jsonStr = [completedOperation responseString];
            // Result *result = [[Result alloc] initWithString:jsonStr error:nil];
            Result *result = [Result yy_modelWithJSON:jsonStr];
            if (result!=nil) {
                if (result.status==200) {
                    NSData *jsondata = [result.content yy_modelToJSONData];
                    //NSMutableArray *dataList = [clazz arrayOfModelsFromData:jsondata error:nil];
                    NSMutableArray *dataList = [NSMutableArray arrayWithArray:[NSArray yy_modelArrayWithClass:clazz json:jsondata]];
                    NSLog(@"获取列表的长度-->%lu",(unsigned long)[dataList count]);
                    if (dataList&&dataList.count>0) {
                        NSData *jsonData = [result.content yy_modelToJSONData];
                        [[DataManagerProxy getInstance:FILECACHE] saveData:jsonData key:key];
                        
                        callBackHandler(200,dataList,@"success");
                        
                    }else{
                        callBackHandler(result.status,dataList,@"list is nil");
                    }
                }else{
                    callBackHandler(result.status,nil,result.errorMsg);
                }
                
            }else{
                callBackHandler(500,nil,@"failed");
                
            }
            
        } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
            callBackHandler(600,nil,[error localizedDescription]);
        }];
        
        [singleton enqueueOperation:op];
        
        return op;
    }
    return nil;
}


//先获取缓存显示页面，有缓存返回，没有则获取网络数返回页面，有则据缓存网络数据下来，不再返回页面
-(MKNetworkOperation *) apiListCacheReturnThanNetSaveGet:(Class) clazz apiURL:(NSString *) apiURL params:(NSDictionary *) params cacheKey:(NSString *)key  callBackHandler:(CallBackHandler) callBackHandler{
    
    //不需要判断过期
    NSData *cacheContent =  [[DataManagerProxy getInstance:FILECACHE] queryData:key];
    
    //NSLog(@"列表缓存信息%@",[[NSString alloc] initWithData:cacheContent encoding:NSUTF8StringEncoding]);
    if (cacheContent!=nil) {
        NSLog(@"缓存不为空");
        callBackHandler(200,[NSArray yy_modelArrayWithClass:clazz json:cacheContent],@"success");
    }else{
        if (cacheContent==nil) {
            NSLog(@"缓存数据为nil");
        }
        // NSLog(@"缓存数据为空");
    }
    MKNetworkOperation *op = [singleton operationWithPath:apiURL params:params httpMethod:@"GET"];
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        
        //NSDictionary *data = [completedOperation responseJSON];
        NSLog(@"获取有缓存列表网络数据-->%@",[completedOperation responseString]);
        NSString *jsonStr = [completedOperation responseString];
        //Result *result = [[Result alloc] initWithString:jsonStr error:nil];
        Result *result = [Result yy_modelWithJSON:jsonStr];
        if (result!=nil) {
            if (result.status==200) {
                NSData *jsondata = [result.content yy_modelToJSONData];
                //NSMutableArray *dataList = [clazz arrayOfModelsFromData:jsondata error:nil];
                NSMutableArray *dataList = [NSMutableArray arrayWithArray:[NSArray yy_modelArrayWithClass:clazz json:jsondata]];
                NSLog(@"获取列表的长度-->%lu",(unsigned long)[dataList count]);
                if (dataList&&dataList.count>0) {
                    
                    NSData *jsonData = [result.content yy_modelToJSONData];
                    [[DataManagerProxy getInstance:FILECACHE] saveData:jsonData key:key];
                    if (cacheContent==nil||cacheContent.length==0) {
                        callBackHandler(200,dataList,@"success");
                    }
                    
                }else{
                    callBackHandler(300,dataList,@"list is nil");
                }
            }else{
                callBackHandler(result.status,nil,result.errorMsg);
            }
            
        }else{
            callBackHandler(500,nil,@"failed");
            
        }
        
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        callBackHandler(600,nil,[error localizedDescription]);
    }];
    
    [singleton enqueueOperation:op];
    
    return op;
    
}



//不考虑缓存，直接获取获取网络数据，转成List回调到页面上
-(MKNetworkOperation *) apiListCacheNoCacheGet:(Class) clazz apiURL:(NSString *) apiURL params:(NSDictionary *) params callBackHandler:(CallBackHandler) callBackHandler{
    
    MKNetworkOperation *op = [singleton operationWithPath:apiURL params:params httpMethod:@"GET"];
    //op.stringEncoding = NSUTF8StringEncoding;
    
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        //NSDictionary *data = [completedOperation responseJSON];
        
        NSLog(@"获取无缓存列表网络数据-->%@",[completedOperation responseString]);
        
        NSString *jsonStr = [completedOperation responseString];
        //Result *result = [[Result alloc] initWithString:jsonStr error:nil];
        Result *result = [Result yy_modelWithJSON:jsonStr];
        if (result!=nil) {
            
            if (result.status==200) {
                
                NSMutableArray *clazzList = [NSMutableArray arrayWithArray:[NSArray yy_modelArrayWithClass:clazz json:result.content]];
                //NSData *jsondata = [result.content dataUsingEncoding:NSUTF8StringEncoding];
                //NSMutableArray *clazzList = [clazz arrayOfModelsFromData:jsondata error:nil];
                if (clazzList&&clazzList.count>0) {
                    callBackHandler(200,clazzList,@"success");
                }else{
                    callBackHandler(300,nil,@"clazzList is empty");
                }
            }else{
                callBackHandler(result.status,nil,result.errorMsg);
            }
        }else{
            callBackHandler(500,nil,@"failed");
        }
        
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        //NSString *string = error.localizedDescription;
        
        callBackHandler(600,nil,[error localizedDescription]);
    }];
    
    [singleton enqueueOperation:op];
    
    return op;
    
}

//不考虑缓存，直接获取获取网络数据，转成List回调到页面上[POST]
-(MKNetworkOperation *) apiListCacheNoCachePost:(Class) clazz apiURL:(NSString *) apiURL params:(NSDictionary *) params callBackHandler:(CallBackHandler) callBackHandler{
    
    MKNetworkOperation *op = [singleton operationWithPath:apiURL params:params httpMethod:@"POST"];
    
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        //NSDictionary *data = [completedOperation responseJSON];
        
        NSLog(@"获取无缓存列表网络数据-->%@",[completedOperation responseString]);
        
        NSString *jsonStr = [completedOperation responseString];
        //Result *result = [[Result alloc] initWithString:jsonStr error:nil];
        Result *result = [Result yy_modelWithJSON:jsonStr];
        if (result!=nil) {
            
            if (result.status==200) {
                NSData *jsondata = [result.content dataUsingEncoding:NSUTF8StringEncoding];
                
                NSMutableArray *clazzList = [NSMutableArray arrayWithArray:[NSArray yy_modelArrayWithClass:clazz json:jsondata]];
                if (clazzList&&clazzList.count>0) {
                    callBackHandler(200,clazzList,@"success");
                }else{
                    callBackHandler(300,nil,@"clazzList is empty");
                }
            }else{
                callBackHandler(result.status,nil,result.errorMsg);
            }
        }else{
            callBackHandler(500,nil,@"failed");
        }
        
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        callBackHandler(600,nil,[error localizedDescription]);
    }];
    
    [singleton enqueueOperation:op];
    
    return op;
    
}



-(MKNetworkOperation *) apiJustResultNetWithURL:(NSString *) apiURL param:(NSDictionary *) params callBackHandler:(CallBackHandler) callBackHandler {
    MKNetworkOperation *op = [singleton operationWithPath:apiURL params:params httpMethod:@"GET"];
    
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        
        NSString *string = [completedOperation responseString];
        NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];

        
        [[DataManagerProxy getInstance:FILECACHE] saveData:data key:@"temple"];
        data =  [[DataManagerProxy getInstance:FILECACHE] queryData:@"temple"];
        
        Result *result = [Result yy_modelWithJSON:data];
        NSLog(@"获取无缓存列表网络数据-->%@",string);
        
        if (result!=nil) {
            callBackHandler(result.status,result,result.errorMsg);
        }else{
            callBackHandler(500,nil,@"failed");
        }
        
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        callBackHandler(600,nil,[error localizedDescription]);
    }];
    
    [singleton enqueueOperation:op];
    
    return op;
}

-(MKNetworkOperation *) apiJustResultNetWithURLPost:(NSString *) apiURL param:(NSDictionary *) params callBackHandler:(CallBackHandler) callBackHandler {
    MKNetworkOperation *op = [singleton operationWithPath:apiURL params:params httpMethod:@"POST"];
    
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        
        NSString *string = [completedOperation responseString];
        
        //Result *result = [[Result alloc] initWithString:string error:nil];
        Result *result = [Result yy_modelWithJSON:string];
        NSLog(@"获取无缓存列表网络数据-->%@",string);
        
        if (result!=nil) {
            callBackHandler(result.status,result,result.errorMsg);
        }else{
            callBackHandler(500,nil,@"failed");
        }
        
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        callBackHandler(600,nil,[error localizedDescription]);
    }];
    
    [singleton enqueueOperation:op];
    
    return op;
}

+ (PlutoAPIEngine *) getInstance{
    
    @synchronized(self)
    {
        if (!singleton) {
            //NSLog(@"PlutoAPIEngine-->%@",SERVER_DOMAIN);
            singleton = [[self alloc] initWithHostName:[Pluto getInstance].URL_DOMAIN];
        }
    }
    return singleton;
}

//这里重写allocWithZone主要防止[[SysInfoParam alloc] init]这种方式调用多次会返回多个对象
+ (id)allocWithZone:(NSZone *)zone
{
    @synchronized(self){
        if (!singleton) {
            singleton = [super allocWithZone:zone];
            return singleton;
        }
    }
    return nil;
}


@end
