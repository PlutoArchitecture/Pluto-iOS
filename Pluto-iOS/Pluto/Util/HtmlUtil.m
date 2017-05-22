//
//  HtmlUtil.m
//  Jimihua
//
//  Created by minggo on 15/10/27.
//  Copyright © 2015年 mengmengda. All rights reserved.
//

#import "HtmlUtil.h"

@implementation HtmlUtil
+(NSString *)flattenHTML:(NSString *)html trimWhiteSpace:(BOOL)trim{
    NSScanner *theScanner = [NSScanner scannerWithString:html];
    NSString *text = nil;
    while ([theScanner isAtEnd] == NO) {
        // find start of tag
        [theScanner scanUpToString:@"<" intoString:NULL] ;
        // find end of tag
        [theScanner scanUpToString:@">" intoString:&text] ;
        // replace the found tag with a space
        //(you can filter multi-spaces out later if you wish)
        html = [html stringByReplacingOccurrencesOfString:
                [ NSString stringWithFormat:@"%@>", text]
                                               withString:@""];
    }
    
    //    NSCharacterSet *whitespaces = [NSCharacterSet whitespaceCharacterSet];
    //    NSPredicate *noEmptyStrings = [NSPredicate predicateWithFormat:@"SELF != ''"];
    //
    //    NSArray *parts = [html componentsSeparatedByCharactersInSet:whitespaces];
    //    NSArray *filteredArray = [parts filteredArrayUsingPredicate:noEmptyStrings];
    //    html = [filteredArray componentsJoinedByString:@" "];
    html = [html stringByReplacingOccurrencesOfString:@" " withString:@""];
    html = [html stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    //html = [html stringByReplacingOccurrencesOfString:@"\n\n" withString:@"\n"];
    
    return trim ? [html stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] : html;
}
+(NSString *)removeHtml:(NSString *)html{
    
    NSScanner *theScanner = [NSScanner scannerWithString:html];
    NSString *text = nil;
    while ([theScanner isAtEnd] == NO) {
        // find start of tag
        [theScanner scanUpToString:@"<" intoString:NULL] ;
        // find end of tag
        [theScanner scanUpToString:@">" intoString:&text] ;
        // replace the found tag with a space
        //(you can filter multi-spaces out later if you wish)
        html = [html stringByReplacingOccurrencesOfString:
                [ NSString stringWithFormat:@"%@>", text]
                                               withString:@""];
    }
    
    NSCharacterSet *whitespaces = [NSCharacterSet whitespaceCharacterSet];
    NSPredicate *noEmptyStrings = [NSPredicate predicateWithFormat:@"SELF != ''"];
    
    NSArray *parts = [html componentsSeparatedByCharactersInSet:whitespaces];
    NSArray *filteredArray = [parts filteredArrayUsingPredicate:noEmptyStrings];
    html = [filteredArray componentsJoinedByString:@" "];
    html = [html stringByReplacingOccurrencesOfString:@"\n\n\n" withString:@"\n"];
    html = [html stringByReplacingOccurrencesOfString:@"\n\n" withString:@"\n"];
    //html = [html stringByReplacingOccurrencesOfString:@"\n\n" withString:@"\n"];
    
    return [html stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
}

+(NSString *) replaceReturnChar:(NSString *)string {
    return [string stringByReplacingOccurrencesOfString:@"§" withString:@"\n"];
}
+(NSString *)replaceReturnRepeatChar:(NSString *)string{
    string = [string stringByReplacingOccurrencesOfString:@"\n\n\n" withString:@"\n"];
    return [string stringByReplacingOccurrencesOfString:@"\n\n" withString:@"\n"];
}
+(NSString *) removeReturnChar:(NSString *)string {
    return [string stringByReplacingOccurrencesOfString:@"\n" withString:@""];
}

+(NSString *) replaceHtmlReturnChar:(NSString *)string {
    return [string stringByReplacingOccurrencesOfString:@"§" withString:@"<br>"];
}
+(NSString *)replaceHtmlReturnRepeatChar:(NSString *)string{
    string = [string stringByReplacingOccurrencesOfString:@"<br><br><br>" withString:@"<br>"];
    return [string stringByReplacingOccurrencesOfString:@"<br><br>" withString:@"<br>"];
}

+(NSString *) feelingContentShow:(NSString *) feeling{
    return [self replaceHtmlReturnChar:feeling];
}

+(NSString *) replaceEmotion:(NSString *)string {
    
    return [string stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"file:/%@/",[[NSBundle mainBundle] resourcePath]] withString:@"http://res.jmihua.com/emotion/"];
}

@end
