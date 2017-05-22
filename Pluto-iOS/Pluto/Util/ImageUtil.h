//
//  ImageUtil.h
//  Jimihua
//
//  Created by minggo on 15/7/29.
//  Copyright (c) 2015年 mengmengda. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageUtil : NSObject

+(UIImage*) circleImage:(UIImage*) image withParam:(CGFloat) inset;
+(UIImageView *) circleImageView:(UIImageView *)imageView;
+(UIImageView *) circleImageViewWithBorder:(UIImageView *)imageView;
+(UIImage *) creatImageWithColor:(UIColor *)color size:(CGSize)size;
@end
