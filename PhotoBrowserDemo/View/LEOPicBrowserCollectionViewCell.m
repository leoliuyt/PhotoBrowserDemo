//
//  LEOPicBrowserCollectionViewCell.m
//  PhotoBrowserDemo
//
//  Created by leoliu on 15/6/25.
//  Copyright (c) 2015年 leoliu. All rights reserved.
//

#import "LEOPicBrowserCollectionViewCell.h"
#import "UIImage+ImageEffects.h"
#import "AppDelegate.h"
#import "UIImageView+WebCache.h"
#import "UIImageView+AFNetworking.h"
#import "UIActivityIndicatorView+AFNetworking.h"
#import "UIImageView+UIActivityIndicatorForSDWebImage.h"
#import "constant.h"
#define SharedAppDelegate ((AppDelegate*)[[UIApplication sharedApplication] delegate])
#define RGBColor(x,y,z) [UIColor colorWithRed:(x)/255.0f green:(y)/255.0f blue:(z)/255.0f                                                                                  alpha:1.0]

NSString *const PicBrowserCollectionViewCellIdentify = @"PicBrowserCollectionViewCell";
@implementation LEOPicBrowserCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}


- (void)initCellWithModel:(LEOAlbumItemModel *)picSetModel andCurrentPage:(NSUInteger)currentPage andTotalPages:(NSUInteger)totalPages
{
    __weak typeof (_zoomingScrollView) weakScrollView = _zoomingScrollView;
//    [_zoomingScrollView.photoImageView setImageWithURL:[NSURL URLWithString:picSetModel.pictureHttpUrl] placeholderImage:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
//        __strong typeof (weakScrollView) strongScrollView = weakScrollView;
//        strongScrollView.photo = image;
//    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
//        DLog(@"%@",[error description]);
//    }];
    
    [_zoomingScrollView.photoImageView sd_setImageWithURL:[NSURL URLWithString:picSetModel.pictureHttpUrl] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        __strong typeof (weakScrollView) strongScrollView = weakScrollView;
        strongScrollView.photo = image;
    }];
    
    [_picTitleView initPicTitleViewWithModel:picSetModel andCurrentPage:currentPage andTotalPages:totalPages];
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


- (UIImage *)convertViewToImage:(UIImageView *)imgV
{
    UIGraphicsBeginImageContext(imgV.bounds.size);
    if ([imgV respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)]) {
        [imgV drawViewHierarchyInRect:imgV.bounds afterScreenUpdates:NO];
    }else{
        [imgV.layer renderInContext:UIGraphicsGetCurrentContext()];
    }
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


@end
