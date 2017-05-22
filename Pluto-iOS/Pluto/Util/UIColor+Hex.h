//
//  UIColor+Hex.h
//  Jimihua
//
//  Created by minggo on 15/7/14.
//  Copyright © 2015年 mengmengda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Hex)
+(UIColor*)colorWithHexValue:(uint)hexValue;
+(UIColor*)colorWithHexString:(NSString*)hexString;
@end