//
//  DataManagerDelegate.h
//  Videor
//
//  Created by minggo on 2017/5/2.
//  Copyright © 2017年 MengMengDa. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DataManagerDelegate <NSObject>
-(void)saveData:(id)data key:(NSString *)key;
-(id)queryData:(NSString *)key;
-(void)updateData:(id)data key:(NSString *)key;
-(void)deleteData:(NSString *)key;
@end
