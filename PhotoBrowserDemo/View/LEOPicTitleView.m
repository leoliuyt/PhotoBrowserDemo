//
//  LEOPicTitleView.m
//  PhotoBrowserDemo
//
//  Created by leoliu on 15/6/25.
//  Copyright (c) 2015年 leoliu. All rights reserved.
//

#import "LEOPicTitleView.h"

@implementation LEOPicTitleView

- (void)awakeFromNib
{
    _titleLabel.backgroundColor = [UIColor clearColor];
    _pageLabel.backgroundColor = [UIColor clearColor];
    _contentTextView.backgroundColor = [UIColor clearColor];
    
    self.backgroundColor = [UIColor clearColor];
}
- (void)initPicTitleViewWithModel:(LEOAlbumItemModel *)picSetModel andCurrentPage:(NSUInteger)currentPage andTotalPages:(NSUInteger)totalPages
{
    _albumItemModel = picSetModel;
    NSDictionary *currentDic = @{
                                 NSFontAttributeName:[UIFont systemFontOfSize:18],
                                 NSForegroundColorAttributeName:[UIColor whiteColor]
                                 };
    NSDictionary *totalDic = @{
                               NSFontAttributeName:[UIFont systemFontOfSize:14],
                               NSForegroundColorAttributeName:[UIColor whiteColor]
                               };
    NSMutableAttributedString *page = [[NSMutableAttributedString alloc]init];
    NSAttributedString *currentPageString = [[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"%lu",currentPage]attributes:currentDic];
    NSAttributedString *totalPageString = [[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"/%lu",totalPages]attributes:totalDic];
    [page appendAttributedString:currentPageString];
    [page appendAttributedString:totalPageString];
    
    _pageLabel.attributedText = page;
    
    //    NSString *page = [NSString stringWithFormat:@"%lu/%lu",currentPage,totalPages];
    //    NSMutableAttributedString *string = [[NSMutableAttributedString alloc]initWithString:page];
    //    [string app]
    //    _pageLabel.text = [NSString stringWithFormat:@"%lu/%lu",currentPage,totalPages];
    _titleLabel.text = picSetModel.title;
    _contentTextView.text = picSetModel.summary;
}


@end
