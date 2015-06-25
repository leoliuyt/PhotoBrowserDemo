//
//  LEOEmptyView.h
//  PhotoBrowserDemo
//
//  Created by leoliu on 15/6/25.
//  Copyright (c) 2015年 leoliu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "enumtype.h"
#import "LEOButton.h"

@protocol LEOEmptyViewDelegate;

@interface LEOEmptyView : UIButton

@property (nonatomic, assign) LoadViewType loadViewType;

@property (nonatomic, assign) id<LEOEmptyViewDelegate>delegate;

- (void)setLoadViewType:(LoadViewType)loadViewType;

@end

@protocol LEOEmptyViewDelegate <NSObject>

- (void)refreshData;

@end