//
//  NSDate+MGO.h
//  Jimihua
//
//  Created by minggo on 15/10/26.
//  Copyright © 2015年 mengmengda. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (MGO)
/**
 *  时间字符串转成时间戳
 *
 *  @param dateStr 时间字符串 2015-10-26 15:56:01
 *
 *  @return 时间戳
 */
+(long)stringtoDate:(NSString *)dateStr;
/**
 *  时间格式化(yyyy-mm-dd hh:mm:ss)
 *
 *  @param date 时间
 *
 *  @return 字符
 */
+(NSString *)dateToString:(NSDate *)date;
/**
 *  截取时间的时和分 16:16
 *
 *  @param date 时间
 *
 *  @return 字符串
 */
+(NSString *)hourMinDate:(NSDate *)date;
/**
 *  截取时间的时和分 16:16
 *
 *  @param date 时间字符串
 *
 *  @return 字符串
 */
+(NSString *)hourMinString:(NSString *)date;
/**
 *  截取时间年月日
 *
 *  @param date 时间字符串
 *
 *  @return 年月日字符串 2015-11-16
 */
+(NSString *) yearMonthDay:(NSString *)date;
/**
 *  截取时间月份
 *
 *  @param date 时间字符串
 *
 *  @return 01
 */
+(NSString *)monthString:(NSString *)date;
/**
 *  截取时间日
 *
 *  @param date 时间字符串
 *
 *  @return 01
 */
+(NSString *)dayString:(NSString *)date;

/**
 *   和当前时间比较
 *   1）1分钟以内 显示 : 刚刚
 *   2）1小时以内 显示 : X分钟前
 *   3）今天或者昨天 显示: 今天 09:30   昨天 09:30
 *   4) 今年      显示: 09月12日
 *   5) 大于本年  显示 : 2013/09/09
 *
 *  @param dateString 时间字符串 yyyy-MM-dd HH:mm:ss
 *  @param formate    格式化
 *
 *  @return 响应字符串
 */
+ (NSString *)formateDate:(NSString *)dateString;
/**
 *  返回时间
 *
 *  @param date 时间
 *
 *  @return 时间字符串 yyyy.MM.dd
 */
+(NSString *)dateToStringWithDot:(NSDate *)date;

@end
