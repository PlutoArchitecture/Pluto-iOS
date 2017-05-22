//
//  DataManagerProxy.m
//  Videor
//
//  Created by minggo on 2017/5/2.
//  Copyright © 2017年 MengMengDa. All rights reserved.
//

#import "DataManagerProxy.h"
#import "DataManagerStub.h"
#import "DataManagerDelegate.h"
#import "FTWCache.h"
#import "NativeData.h"
@implementation DataManagerProxy

static DataManagerProxy *dataManagerProxy = nil;
static id<DataManagerDelegate> dataManagerStub = nil;

-(void)saveData:(id)data key:(NSString *)key{
    [dataManagerStub saveData:data key:key];
}
-(id)queryData:(NSString *)key{
    
    return [dataManagerStub queryData:key];
}

-(void)updateData:(id)data key:(NSString *)key{
    [dataManagerStub saveData:data key:key];
}
-(void)deleteData:(NSString *)key{
    [dataManagerStub deleteData:key];
}

-(BOOL)isExpiredFile:(NSString *)key min:(NSInteger)min{
    
    return [(FTWCache *)dataManagerStub isExpiredWithKey:key cacheTimeMin:min];
}

+(id)getDataManager:(DataType)type{
    
    switch (type){
            
        case FILECACHE:
            dataManagerStub = [FTWCache new];
            break;
        case USERDEFAULTS:
            dataManagerStub = [NativeData new];
            break;
        default:
            
            break;
    }
    
    return dataManagerStub;
}

+(DataManagerProxy *)getInstance:(DataType)dataType{
    
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        dataManagerProxy = [[super alloc] init];
    });
    [self getDataManager:dataType];
    return dataManagerProxy;
}


+ (id)allocWithZone:(NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dataManagerProxy = [super allocWithZone:zone];
    });
    return dataManagerProxy;
}

-(id)copyWithZone:(NSZone *)zone{
    return dataManagerProxy;
}

@end
