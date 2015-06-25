//
//  LEOZoomingScrollView.m
//  PhotoBrowserDemo
//
//  Created by leoliu on 15/6/25.
//  Copyright (c) 2015年 leoliu. All rights reserved.
//

#import "LEOZoomingScrollView.h"
#import "constant.h"
#import "UIImageView+WebCache.h"

@interface LEOZoomingScrollView()<LEOTapDetectingImageViewDelegate,LEOTapDetectingViewDelegate,UIScrollViewDelegate>

@property (nonatomic, strong) LEOTapDetectingView *tapView;

@end

@implementation LEOZoomingScrollView


- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.frame = CGRectMake(0, 0, kWidth, kHeight);
    
    _tapView = [[LEOTapDetectingView alloc] initWithFrame:self.bounds];
    _tapView.tapDelegate = self;
    _tapView.backgroundColor = [UIColor clearColor];
    [self addSubview:_tapView];
    
    _photoImageView = [[LEOTapDetectingImageView alloc] initWithFrame:CGRectZero];
    _photoImageView.tapDelegate = self;
    _photoImageView.backgroundColor = [UIColor clearColor];
    [self addSubview:_photoImageView];
    
    self.backgroundColor = [UIColor clearColor];
    self.delegate = self;
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;
    self.pagingEnabled = NO;
    self.decelerationRate = UIScrollViewDecelerationRateFast;
}



- (void)prepareForReuse {
    self.photo = nil;
}
- (void)setPhoto:(UIImage *)photo
{
    _photoImageView.image = nil; // Release image
    if (_photo != photo) {
        _photo = photo;
    }
    
    [self displayImage:photo];
}

- (void)setPhotoUrl:(NSString *)photoUrl
{
    [_photoImageView sd_setImageWithURL:[NSURL URLWithString:photoUrl] placeholderImage:nil];
    
}

#pragma mark - Image

// Get and display image
- (void)displayImage:(UIImage *)photo {
    if (_photoImageView.image == nil) {
        // Reset
        self.maximumZoomScale = 1;
        self.minimumZoomScale = 1;
        self.zoomScale = 1;
        
        self.contentSize = CGSizeMake(0, 0);
        
        // Get image from browser as it handles ordering of fetching
        //		UIImage *img = [self.photoBrowser imageForPhoto:_photo];
        UIImage *img = photo;
        if (img) {
            
            // Set image
            _photoImageView.image = img;
            _photoImageView.hidden = NO;
            
            // Setup photo frame
            CGRect photoImageViewFrame;
            photoImageViewFrame.origin = CGPointZero;
            photoImageViewFrame.size = img.size;
            
            _photoImageView.frame = photoImageViewFrame;
            self.contentSize = photoImageViewFrame.size;
            
            // Set zoom to minimum zoom
            [self setMaxMinZoomScalesForCurrentBounds];
        } else {
            // Hide image view
            _photoImageView.hidden = YES;
        }
        
        [self setNeedsLayout];
    }
}


#pragma mark - Setup

- (void)setMaxMinZoomScalesForCurrentBounds {
    // Reset
    self.maximumZoomScale = 1;
    self.minimumZoomScale = 1;
    self.zoomScale = 1;
    
    // Bail
    if (_photoImageView.image == nil) return;
    
    // Sizes
    CGSize boundsSize = self.bounds.size;
    CGSize imageSize = _photoImageView.frame.size;
    
    // Calculate Min
    CGFloat xScale = boundsSize.width / imageSize.width;    // the scale needed to perfectly fit the image width-wise
    CGFloat yScale = boundsSize.height / imageSize.height;  // the scale needed to perfectly fit the image height-wise
    CGFloat minScale = MIN(xScale, yScale);                 // use minimum of these to allow the image to become fully visible
    
    // If image is smaller than the screen then ensure we show it at
    // min scale of 1
    if (xScale > 1 && yScale > 1) {
        //minScale = 1.0;
    }
    
    // Calculate Max
    CGFloat maxScale = 4.0f;
    if(iPhone6Plus)
    {
        maxScale = 12.0f;
    }
    //    CGFloat maxScale = 12.0; // Allow double scale
    // on high resolution screens we have double the pixel density, so we will be seeing every pixel if we limit the
    // maximum zoom scale to 0.5.
    if ([UIScreen instancesRespondToSelector:@selector(scale)]) {
        maxScale = maxScale / [[UIScreen mainScreen] scale];
    }
    
    // Set
    self.maximumZoomScale = maxScale;
    self.minimumZoomScale = minScale;
    self.zoomScale = minScale;
    
    // Reset position
    _photoImageView.frame = CGRectMake(0, 0, _photoImageView.frame.size.width, _photoImageView.frame.size.height);
    [self setNeedsLayout];
}

#pragma mark - Layout

- (void)layoutSubviews {
    
    // Super
    [super layoutSubviews];
    
    // Center the image as it becomes smaller than the size of the screen
    CGSize boundsSize = self.bounds.size;
    CGRect frameToCenter = _photoImageView.frame;
    
    // Horizontally
    if (frameToCenter.size.width < boundsSize.width) {
        frameToCenter.origin.x = floorf((boundsSize.width - frameToCenter.size.width) / 2.0);
    } else {
        frameToCenter.origin.x = 0;
    }
    
    // Vertically
    if (frameToCenter.size.height < boundsSize.height) {
        frameToCenter.origin.y = floorf((boundsSize.height - frameToCenter.size.height) / 2.0);
    } else {
        frameToCenter.origin.y = 0;
    }
    
    // Center
    if (!CGRectEqualToRect(_photoImageView.frame, frameToCenter))
        _photoImageView.frame = frameToCenter;
}

#pragma mark - UIScrollViewDelegate

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return _photoImageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

#pragma mark - Tap Detection

- (void)handleSingleTap:(CGPoint)touchPoint {
    
}

- (void)handleDoubleTap:(CGPoint)touchPoint {
    // Zoom
    if (self.zoomScale == self.maximumZoomScale) {
        
        // Zoom out
        [self setZoomScale:self.minimumZoomScale animated:YES];
        
    } else {
        
        // Zoom in
        [self zoomToRect:CGRectMake(touchPoint.x, touchPoint.y, 1, 1) animated:YES];
        
    }
}

// Image View
- (void)imageView:(UIImageView *)imageView singleTapDetected:(UITouch *)touch {
    [self handleSingleTap:[touch locationInView:imageView]];
}
- (void)imageView:(UIImageView *)imageView doubleTapDetected:(UITouch *)touch {
    [self handleDoubleTap:[touch locationInView:imageView]];
}

// Background View
- (void)view:(UIView *)view singleTapDetected:(UITouch *)touch {
    [self handleSingleTap:[touch locationInView:view]];
}
- (void)view:(UIView *)view doubleTapDetected:(UITouch *)touch {
    [self handleDoubleTap:[touch locationInView:view]];
}

@end
