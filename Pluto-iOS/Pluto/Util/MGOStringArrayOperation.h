//
//  MGOStringArrayOperation.h
//  Jimihua
//
//  Created by minggo on 15/10/27.
//  Copyright © 2015年 mengmengda. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MGOStringArrayOperation : NSObject
/**
 *  将字符串数组拼接成以逗号隔开的字符串
 *
 *  @param list 字符串数据
 *  @return 拼接数据
 */
+(NSString *)arrayOperateString:(NSArray<NSString *> *) list;
/**
 *  将以逗号隔开的字符串转成字符串数组
 *
 *  @param string 字符串
 *
 *  @return 字符串数据
 */
+(NSMutableArray<NSString *> *) stringSpiltArray:(NSString *) string;

@end
