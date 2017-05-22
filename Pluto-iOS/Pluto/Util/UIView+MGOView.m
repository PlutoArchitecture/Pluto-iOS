//
//  UIView+MGOView.m
//  Jimihua
//
//  Created by minggo on 15/12/9.
//  Copyright © 2015年 mengmengda. All rights reserved.
//

#import "UIView+MGOView.h"

@implementation UIView (MGOView)


+(void)cornerView:(UIView *)view radus:(int)radus{
    view.layer.cornerRadius = radus;
    view.layer.masksToBounds = YES;
}
@end
