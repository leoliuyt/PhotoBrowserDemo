//
//  LEOPicBrowserCollectionViewCell.h
//  PhotoBrowserDemo
//
//  Created by leoliu on 15/6/25.
//  Copyright (c) 2015年 leoliu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LEOZoomingScrollView.h"
#import "LEOPicTitleView.h"
#import "LEOAlbumModel.h"

extern NSString *const PicBrowserCollectionViewCellIdentify;
@interface LEOPicBrowserCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) LEOAlbumModel *albumModel;

@property (nonatomic, assign) int totalPages;
@property (nonatomic,strong) IBOutlet LEOZoomingScrollView *zoomingScrollView;
@property (nonatomic,strong) IBOutlet LEOPicTitleView *picTitleView;
@property (nonatomic,strong) IBOutlet UIImageView *backgroundImgV;

- (void)setAlbumModel:(LEOAlbumModel *)albumModel;


- (void)initCellWithModel:(LEOAlbumItemModel *)picSetModel andCurrentPage:(NSUInteger)currentPage andTotalPages:(NSUInteger)totalPages;

@end







