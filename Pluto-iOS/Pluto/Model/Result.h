//
//  Result.h
//  Jimihua
//
//  Created by minggo on 15/10/20.
//  Copyright © 2015年 mengmengda. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Result : NSObject
@property(nonatomic,assign) int status;
@property(nonatomic,retain) id content;
@property(nonatomic,copy) NSString *errorMsg;
@end
