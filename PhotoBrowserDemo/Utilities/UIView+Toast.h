//
//  UIView+Toast.h
//  PhotoBrowserDemo
//
//  Created by leoliu on 15/6/25.
//  Copyright (c) 2015年 leoliu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Toast)

- (void)showToastWithDuration:(CGFloat)interval message:(NSString *)message isSuccessToast:(BOOL)isSuccessToast;

- (UIImage *)convertViewToImage;

@end
