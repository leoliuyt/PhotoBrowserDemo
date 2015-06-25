//
//  LEOZoomingScrollView.h
//  PhotoBrowserDemo
//
//  Created by leoliu on 15/6/25.
//  Copyright (c) 2015年 leoliu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LEOTapDetectingImageView.h"
#import "LEOTapDetectingView.h"
@interface LEOZoomingScrollView : UIScrollView

@property (nonatomic, strong) UIImage *photo;

@property (nonatomic, strong) NSString *photoUrl;

@property (nonatomic, strong) LEOTapDetectingImageView *photoImageView;


//- (void)displayImage;
- (void)setMaxMinZoomScalesForCurrentBounds;
- (void)prepareForReuse;

- (void)setPhotoImageView:(LEOTapDetectingImageView *)photoImageView;

- (void)setPhoto:(UIImage *)photo;

- (void)setPhotoUrl:(NSString *)photoUrl;

@end
