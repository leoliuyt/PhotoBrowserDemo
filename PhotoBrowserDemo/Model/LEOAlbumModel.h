//
//  LEOAlbumModel.h
//  PhotoBrowserDemo
//
//  Created by leoliu on 15/6/25.
//  Copyright (c) 2015年 leoliu. All rights reserved.
//

#import "LEOBaseModel.h"

@interface LEOAlbumModel : LEOBaseModel

@property (nonatomic, assign) NSInteger code;
@property (nonatomic, assign) NSInteger albumId;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *summary;
@property (nonatomic, assign) NSInteger pictureCount;
@property (nonatomic, strong) NSArray *albumItems;
@property (nonatomic, assign) BOOL favorite;

@end


@interface LEOAlbumItemModel : LEOBaseModel

@property (nonatomic, assign) NSInteger code;
@property (nonatomic, assign) NSInteger albumItemId;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *summary;
@property (nonatomic, assign) NSInteger pictureId;
@property (nonatomic, strong) NSString *pictureHttpUrl;
@property (nonatomic, assign) NSInteger pictureWidth;
@property (nonatomic, assign) NSInteger pictureHeight;
@property (nonatomic, assign) NSInteger sortOrder;

@end