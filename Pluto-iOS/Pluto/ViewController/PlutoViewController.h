//
//  PlutoViewController.h
//  Videor
//
//  Created by minggo on 2017/4/26.
//  Copyright © 2017年 MengMengDa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Handler.h"
#import "PlutoViewControllerDelegate.h"

@interface PlutoViewController : UIViewController<PlutoViewControllerDelegate>

-(UIHandler)obtainUIHandler;

/**
 * 简单Toast提醒
 * @param content 提醒内容
 */
-(void)showToast:(NSString *)content;

/**
 * 显示输入法
 */
-(void)showSoftInput;
/**
 * 隐藏输入法
 */
-(void)hideSoftInput;
/**
 * 显示加载中
 */
-(void)showLoading;
/**
 * 隐藏加载中
 */
-(void)hideLoading;
@end
