//
//  LEOAlbumViewController.h
//  PhotoBrowserDemo
//
//  Created by leoliu on 15/6/25.
//  Copyright (c) 2015年 leoliu. All rights reserved.
//

#import "LEOBaseViewController.h"

@interface LEOAlbumViewController : LEOBaseViewController

@property (nonatomic, strong) NSNumber *albumId;
@property (nonatomic, strong) IBOutlet UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray *photoUrls;

@end
