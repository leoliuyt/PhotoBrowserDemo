//
//  LEOPicTitleView.h
//  PhotoBrowserDemo
//
//  Created by leoliu on 15/6/25.
//  Copyright (c) 2015年 leoliu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LEOAlbumModel.h"


@interface LEOPicTitleView : UIView

@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UILabel *pageLabel;
@property (nonatomic, weak) IBOutlet UITextView *contentTextView;
@property (nonatomic, strong) LEOAlbumItemModel *albumItemModel;
//@property (nonatomic, strong) NTVPicSetModel *picSetModel;

//- (void)setPicSetModel:(NTVPicSetModel *)picSetModel;

- (void)initPicTitleViewWithModel:(LEOAlbumItemModel *)picSetModel andCurrentPage:(NSUInteger)currentPage andTotalPages:(NSUInteger)totalPages;

@end
