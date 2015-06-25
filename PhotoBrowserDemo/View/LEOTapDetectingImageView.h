//
//  LEOTapDetectingImageView.h
//  PhotoBrowserDemo
//
//  Created by leoliu on 15/6/25.
//  Copyright (c) 2015年 leoliu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LEOTapDetectingImageViewDelegate;
@interface LEOTapDetectingImageView : UIImageView

@property (nonatomic, weak) id <LEOTapDetectingImageViewDelegate> tapDelegate;

- (void)handleSingleTap:(UITouch *)touch;
- (void)handleDoubleTap:(UITouch *)touch;
- (void)handleTripleTap:(UITouch *)touch;

@end

@protocol LEOTapDetectingImageViewDelegate <NSObject>
@optional
- (void)imageView:(UIImageView *)imageView singleTapDetected:(UITouch *)touch;
- (void)imageView:(UIImageView *)imageView doubleTapDetected:(UITouch *)touch;
- (void)imageView:(UIImageView *)imageView tripleTapDetected:(UITouch *)touch;
@end
