//
//  HtmlUtil.h
//  Jimihua
//
//  Created by minggo on 15/10/27.
//  Copyright © 2015年 mengmengda. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HtmlUtil : NSObject
/**
 *  替代换行符号 §
 *  @param orginalStr 原始字符串
 *  @return 带有\r\n字符串
 */
+(NSString *) replaceReturnChar:(NSString *)string;
+(NSString *) removeHtml:(NSString *)html;
+(NSString *)flattenHTML:(NSString *)html trimWhiteSpace:(BOOL)trim;
+(NSString *)replaceReturnRepeatChar:(NSString *)string;
+(NSString *) removeReturnChar:(NSString *)string;
+(NSString *) feelingContentShow:(NSString *) feeling;
+(NSString *) replaceHtmlReturnChar:(NSString *)string;
+(NSString *) replaceEmotion:(NSString *)string;
@end
