//
//  LEOBaseViewController.h
//  PhotoBrowserDemo
//
//  Created by leoliu on 15/6/25.
//  Copyright (c) 2015年 leoliu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+Toast.h"
#import "MBProgressHUD.h"
#import "Reachability.h"

@interface LEOBaseViewController : UIViewController

@property (nonatomic, strong) MBProgressHUD *progressHUD;

@property (nonatomic, assign) NetworkStatus netStatus;

- (void)showToastMessage:(NSString *)message;
- (void)showToastMessage:(NSString *)message isSuccessToast:(BOOL)isSuccessToast;

-(void)startActivity;
-(void)stopActivity;

@end
