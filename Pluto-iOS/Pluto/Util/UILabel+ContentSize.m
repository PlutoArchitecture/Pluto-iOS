//
//  UILabel+ContentSize.m
//  Jimihua
//
//  Created by minggo on 16/1/11.
//  Copyright © 2016年 mengmengda. All rights reserved.
//

#import "UILabel+ContentSize.h"

@implementation UILabel (ContentSize)
- (CGSize)contentSize{
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = self.lineBreakMode;
    paragraphStyle.alignment = self.textAlignment;
    
    NSDictionary * attributes = @{NSFontAttributeName : self.font,
                                  NSParagraphStyleAttributeName : paragraphStyle};
    
    CGSize contentSize = [self.text boundingRectWithSize:self.frame.size
                                                 options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                              attributes:attributes
                                                 context:nil].size;
    return contentSize;
}
@end
