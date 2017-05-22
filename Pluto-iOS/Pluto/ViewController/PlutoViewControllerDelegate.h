//
//  PlutoViewControllerDelegate.h
//  Videor
//
//  Created by minggo on 2017/4/26.
//  Copyright © 2017年 MengMengDa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PlutoMessage.h"

@protocol PlutoViewControllerDelegate <NSObject>

-(void)handlePlutoMessage:(PlutoMessage *) message;

@end
