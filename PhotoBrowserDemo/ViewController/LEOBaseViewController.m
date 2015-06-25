//
//  LEOBaseViewController.m
//  PhotoBrowserDemo
//
//  Created by leoliu on 15/6/25.
//  Copyright (c) 2015年 leoliu. All rights reserved.
//

#import "LEOBaseViewController.h"
#import "AppDelegate.h"
#import "constant.h"
#import "AFNetworkReachabilityManager.h"

@interface LEOBaseViewController ()


@property (nonatomic, strong) UIActivityIndicatorView *activityView;

@property (nonatomic, strong) UILabel *promptLabel;

@end

@implementation LEOBaseViewController

- (void)showToastMessage:(NSString *)message isSuccessToast:(BOOL)isSuccessToast
{
    [SharedAppDelegate.window showToastWithDuration:1.0f message:message isSuccessToast:isSuccessToast];
}

- (void)viewDidLoad
{
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
            {
                DLog(@"未知")
                [self showToastMessage:@"未知网络错误"];
                break;
            }
            case AFNetworkReachabilityStatusNotReachable:
            {
                DLog(@"未连接")
                [self showToastMessage:@"网络未连接"];
                break;
            }
            case AFNetworkReachabilityStatusReachableViaWiFi:
            {
                DLog(@"wifi")
                //                [self showToastMessage:@"wifi"];
                //                break;
            }
            case AFNetworkReachabilityStatusReachableViaWWAN:
            {
                DLog(@"wan")
                //                [self showToastMessage:@"网络已连接"];
                break;
            }
            default:
                break;
        }
    }];
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}


-(void)startActivity{
    if (!_activityView) {
        _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    }
    _activityView.frame = CGRectMake((kWidth - 30) / 2, kHeight * 2/ 5,30, 30);
    _activityView.hidesWhenStopped = YES;
    [self.view addSubview:_activityView];
    [_activityView startAnimating];
    
    if (!_promptLabel) {
        _promptLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_activityView.frame) +5, kWidth, 30)];
    }
    _promptLabel.text = @"数据加载中";
    _promptLabel.textAlignment = NSTextAlignmentCenter;
    //    _promptLabel.textColor = kBtnBackColor;
    _promptLabel.font = [UIFont systemFontOfSize:16.0f];
    _promptLabel.hidden = NO;
    [self.view addSubview:_promptLabel];
}

-(void)stopActivity{
    _promptLabel.hidden = YES;
    [_activityView stopAnimating];
}

- (void)showToastMessage:(NSString *)message
{
    _progressHUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _progressHUD.mode = MBProgressHUDModeText;
    _progressHUD.labelText = message;
    _progressHUD.margin = 10.f;
    _progressHUD.yOffset = 150.f;
    _progressHUD.removeFromSuperViewOnHide = YES;
    [_progressHUD hide:YES afterDelay:1.5];
}


-(void)reachabilityChanged:(NSNotification*)noti{
    Reachability* curReach = [noti object];
    NSParameterAssert([curReach isKindOfClass: [Reachability class]]);
    self.netStatus = [curReach currentReachabilityStatus];
    
}

@end
