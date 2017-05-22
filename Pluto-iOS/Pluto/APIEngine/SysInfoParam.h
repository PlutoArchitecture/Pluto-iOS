//
//  SysInfoParam.h
//  NKusFramework
//
//  Created by minggo on 15/6/17.
//  Copyright (c) 2015年 minggo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SysInfoParam : NSObject

@property (assign) NSString *platfromid;                   //合作方推广渠道id
@property (nonatomic, copy) NSString *versionName;       //软件版本号名称
@property (assign) NSString *versionCode;                  //软件版本号升级id
@property (nonatomic, retain) NSString *UUID;              //用户唯一识别码
//@property (nonatomic, retain) NSString* GGID;              //用户GG号
@property (nonatomic, copy) NSString *IphoneVersion;     //手机型号 iphone4,iphone5,6...
@property (nonatomic, copy) NSString *IOSSystem;         //IOS系统版本 IOS4,IOS5,6...
@property (nonatomic, copy) NSString *source;            //平台号
@property (nonatomic, copy) NSString *passport;          //加密字符

+(SysInfoParam *) getInstance;
-(NSMutableDictionary *) URLParams;

@end
