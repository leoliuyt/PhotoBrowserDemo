//
//  UIView+Toast.m
//  PhotoBrowserDemo
//
//  Created by leoliu on 15/6/25.
//  Copyright (c) 2015年 leoliu. All rights reserved.
//

#import "UIView+Toast.h"
#import <objc/runtime.h>


#define kFadeDuration               0.2
#define kToastAlpha                 0.9
#define kOpacity                    0.8

#define kToastViewWidth             110
#define kToastViewHeight            110
#define kSuccessImageViewW          42
#define kSuccessImageViewH          32
#define kToastLabelH                22

static NSString *kDurationKey = @"CSToastDurationKey";

@implementation UIView (Toast)
/**
 *  用于普通toast
 *
 *  @param interval       toast时间
 *  @param message        toast内容
 *  @param isSuccessToast 是否为成功的toast
 */
- (void)showToastWithDuration:(CGFloat)interval message:(NSString *)message isSuccessToast:(BOOL)isSuccessToast
{
    
    interval = 1.2f;
    
    UIView *toastView = [[UIView alloc]initWithFrame:CGRectMake((self.bounds.size.width - kToastViewWidth)/2, (self.bounds.size.height - kToastViewHeight)/2, kToastViewWidth, kToastViewHeight)];
    toastView.layer.cornerRadius = kToastViewWidth / 10;
    toastView.layer.masksToBounds = YES;
    [toastView setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:kOpacity]];
    
    UIImageView *successImageView;
    if (isSuccessToast == YES) {
        
        successImageView = [[UIImageView alloc]initWithFrame:CGRectMake((kToastViewWidth - kSuccessImageViewW)/2,((CGRectGetHeight(toastView.frame) - 12 -kSuccessImageViewH - kToastLabelH)/2),kSuccessImageViewW,kSuccessImageViewH)];
        [successImageView setAlpha:kToastAlpha];
        [successImageView setImage:[UIImage imageNamed:@"toast_success"]];
        [toastView addSubview:successImageView];
    }
    UILabel *label = [[UILabel alloc] init];
    if (isSuccessToast == YES) {
        [label setFrame:CGRectMake(0, CGRectGetMaxY(successImageView.frame) + 12, CGRectGetWidth(toastView.frame), kToastLabelH)];
    }else{
        if (message.length > 5) {
            [label setFrame:CGRectMake(0, (kToastViewHeight-2 * kToastLabelH)/2, CGRectGetWidth(toastView.frame), 2 * kToastLabelH)];
        }else{
            [label setFrame:CGRectMake(0, (kToastViewHeight-kToastLabelH)/2, CGRectGetWidth(toastView.frame), kToastLabelH)];
        }
    }
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont boldSystemFontOfSize:17];
    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.numberOfLines = 2;
    label.text = message;
    [label setAlpha:kToastAlpha];
    [toastView addSubview:label];
    
    objc_setAssociatedObject (toastView, &kDurationKey, [NSNumber numberWithFloat:interval], OBJC_ASSOCIATION_RETAIN);
    [toastView setAlpha:0.0f];
    [self addSubview:toastView];
    
#if !__has_feature(objc_arc)
    [UIView beginAnimations:@"fade_in" context:toastView];
#else
    [UIView beginAnimations:@"fade_in" context:(__bridge void*)toastView];
#endif
    [UIView setAnimationDuration:kFadeDuration];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [toastView setAlpha:kToastAlpha];
    [UIView commitAnimations];
}

- (UIImage *)convertViewToImage
{
    UIGraphicsBeginImageContext(self.bounds.size);
    if ([self respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)]) {
        [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:NO];
    }else{
        [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    }
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

#pragma mark - Animation Delegate Method

- (void)animationDidStop:(NSString*)animationID finished:(BOOL)finished context:(void *)context {
#if !__has_feature(objc_arc)
    UIView *toast = (UIView *)context;
#else
    UIView *toast = (UIView *)(__bridge id)context;
#endif
    
    // retrieve the display interval associated with the view
    CGFloat interval = [(NSNumber *)objc_getAssociatedObject(toast, &kDurationKey) floatValue];
    
    if([animationID isEqualToString:@"fade_in"]) {
        
#if !__has_feature(objc_arc)
        [UIView beginAnimations:@"fade_out" context:toast];
#else
        [UIView beginAnimations:@"fade_out" context:(__bridge void*)toast];
#endif
        [UIView setAnimationDelay:interval];
        [UIView setAnimationDuration:kFadeDuration];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        [toast setAlpha:0.0];
        [UIView commitAnimations];
        
    } else if ([animationID isEqualToString:@"fade_out"]) {
        
        [toast removeFromSuperview];
        
    }
    
}

@end
