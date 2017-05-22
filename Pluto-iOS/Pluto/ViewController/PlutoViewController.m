//
//  PlutoViewController.m
//  Videor
//  Pluto UI层控制基类
//  Created by minggo on 2017/4/26.
//  Copyright © 2017年 MengMengDa. All rights reserved.
//

#import "PlutoViewController.h"
#import "PlutoMessage.h"
#import "UIView+Toast.h"
@interface PlutoViewController ()
@property(nonatomic,copy) UIHandler uiHandler;
@end

@implementation PlutoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUIHandler];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initUIHandler{
    
    PlutoMessage *message = [PlutoMessage new];
    __weak typeof(self) weakSelf = self;
    _uiHandler = ^(NSInteger what,NSInteger status,id data,NSString *errorMsg){
        message.what = what;
        message.status = status;
        message.data = data;
        message.errorMsg = errorMsg;
        [weakSelf handlePlutoMessage:message];
    };
}

-(UIHandler)obtainUIHandler{
    if (_uiHandler==nil) {
        [self initUIHandler];
    }
    __weak typeof(_uiHandler) _wuiHandler = _uiHandler;//需要认证若引用想法
    
    return _wuiHandler;
}


#pragma mark PlutoViewControllerDelegate
-(void)handlePlutoMessage:(PlutoMessage *)data{
    
}

-(void)showToast:(NSString *)content{
    [self.view makeToast:content];
}
-(void)showSoftInput{
    
}
-(void)hideSoftInput{
    
}
-(void)showLoading{
    [ProgressHUD show:nil];
}
-(void)hideLoading{
    [ProgressHUD dismiss];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    //加上统计
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    //加上统计
    
}

@end
