//
//  PlutoMessage.h
//  Videor
//
//  Created by minggo on 2017/4/26.
//  Copyright © 2017年 MengMengDa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PlutoMessage : NSObject

@property(nonatomic,assign) NSInteger what;
@property(nonatomic,assign) NSInteger status;
@property(nonatomic,retain) id data;
@property(nonatomic,copy) NSString *errorMsg;

@end
