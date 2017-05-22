//
//  NSDate+MGO.m
//  Jimihua
//
//  Created by minggo on 15/10/26.
//  Copyright © 2015年 mengmengda. All rights reserved.
//

#import "NSDate+MGO.h"

@implementation NSDate (MGO)


+(long)stringtoDate:(NSString *)dateStr {
    
    if (dateStr!=nil&&![dateStr isEqualToString:@""]) {
        NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
        [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
        [inputFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate* inputDate = [inputFormatter dateFromString:dateStr];
        
        long timelong =  (long)[inputDate timeIntervalSince1970];
        
        NSLog(@"date = %ld", timelong);
        
        return timelong;
    }else{
        return 0;
    }
}

+(NSString *)dateToString:(NSDate *)date {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //用[NSDate date]可以获取系统当前时间
    NSString *currentDateStr = [dateFormatter stringFromDate:date];
    
    return currentDateStr;
}

+(NSString *)dateToStringWithDot:(NSDate *)date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy.MM.dd"];
    //用[NSDate date]可以获取系统当前时间
    NSString *currentDateStr = [dateFormatter stringFromDate:date];
    
    return currentDateStr;
}

+(NSString *)hourMinDate:(NSDate *)date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //用[NSDate date]可以获取系统当前时间
    NSString *currentDateStr = [dateFormatter stringFromDate:date];
    NSRange range = {11,5};
    NSString *hourMin = [currentDateStr substringWithRange:range];
    NSLog(@"%@",hourMin);
    return hourMin;
}
+(NSString *)monthString:(NSString *)date{
    NSRange range = {5,2};
    NSString *month = [date substringWithRange:range];
    return month;
}
+(NSString *)dayString:(NSString *)date{
    NSRange range = {8,2};
    NSString *day = [date substringWithRange:range];
    return day;
}
+(NSString *)hourMinString:(NSString *)date{
    NSRange range = {11,5};
    NSString *hourMin = [date substringWithRange:range];
    return hourMin;
}

+(NSString *) yearMonthDay:(NSString *)date{
    NSRange range = {0,10};
    return [date substringWithRange:range];
}

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
+ (NSString *)formateDate:(NSString *)dateString
{
    
    @try {
        //实例化一个NSDateFormatter对象
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        
        NSDate * nowDate = [NSDate date];
        
        /////  将需要转换的时间转换成 NSDate 对象
        NSDate * needFormatDate = [dateFormatter dateFromString:dateString];
        /////  取当前时间和转换时间两个日期对象的时间间隔
        /////  这里的NSTimeInterval 并不是对象，是基本型，其实是double类型，是由c定义的:  typedef double NSTimeInterval;
        NSTimeInterval time = [nowDate timeIntervalSinceDate:needFormatDate];
        
        //// 再然后，把间隔的秒数折算成天数和小时数：
        
        NSString *dateStr = @"";
        
        if (time<=60) {  //// 1分钟以内的
            dateStr = @"刚刚";
        }else if(time<=60*60){  ////  一个小时以内的
            
            int mins = time/60;
            dateStr = [NSString stringWithFormat:@"%d分钟前",mins];
            
        }else if(time<=60*60*24){   //// 在两天内的
            
            [dateFormatter setDateFormat:@"YYYY/MM/dd"];
            NSString * need_yMd = [dateFormatter stringFromDate:needFormatDate];
            NSString *now_yMd = [dateFormatter stringFromDate:nowDate];
            
            [dateFormatter setDateFormat:@"HH:mm"];
            if ([need_yMd isEqualToString:now_yMd]) {
                //// 在同一天
                dateStr = [NSString stringWithFormat:@"今天 %@",[dateFormatter stringFromDate:needFormatDate]];
            }else{
                ////  昨天
                dateStr = [NSString stringWithFormat:@"昨天 %@",[dateFormatter stringFromDate:needFormatDate]];
            }
        }else {
            
            [dateFormatter setDateFormat:@"yyyy"];
            NSString * yearStr = [dateFormatter stringFromDate:needFormatDate];
            NSString *nowYear = [dateFormatter stringFromDate:nowDate];
            
            if ([yearStr isEqualToString:nowYear]) {
                ////  在同一年
                [dateFormatter setDateFormat:@"MM月dd日"];
                dateStr = [dateFormatter stringFromDate:needFormatDate];
            }else{
                [dateFormatter setDateFormat:@"yyyy/MM/dd"];
                dateStr = [dateFormatter stringFromDate:needFormatDate];
            }
        }
        
        return dateStr;
    }
    @catch (NSException *exception) {
        return @"";
    }
    
}

@end
