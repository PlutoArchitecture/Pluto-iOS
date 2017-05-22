//
//  MGOStringArrayOperation.m
//  Jimihua
//
//  Created by minggo on 15/10/27.
//  Copyright © 2015年 mengmengda. All rights reserved.
//

#import "MGOStringArrayOperation.h"

@implementation MGOStringArrayOperation

+(NSString *)arrayOperateString:(NSArray<NSString *> *) list{
    
    NSString *arrayStr = @"";
   
    int count = (int)list.count;
    for (int i=0; i<count; i++) {
        if (i==count-1) {
            arrayStr =[arrayStr stringByAppendingString:[NSString stringWithFormat:@"%@",list[i]]];
        }else{
            arrayStr = [arrayStr stringByAppendingString:[NSString stringWithFormat:@"%@,",list[i]]];
        }
    }
    return arrayStr;
}
+(NSMutableArray<NSString *> *) stringSpiltArray:(NSString *) string{
    NSMutableArray *list = [NSMutableArray array];
    NSArray *list1 = [string componentsSeparatedByString:@","];
    [list addObjectsFromArray:list1];
    return list;
}
@end
