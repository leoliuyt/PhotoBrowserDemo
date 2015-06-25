//
//  LEOButton.m
//  PhotoBrowserDemo
//
//  Created by leoliu on 15/6/25.
//  Copyright (c) 2015年 leoliu. All rights reserved.
//

#import "LEOButton.h"

@implementation LEOButton


- (CGRect)imageRectForContentRect:(CGRect)rect
{
    return self.iconRect;
}

- (CGRect)titleRectForContentRect:(CGRect)rect;
{
    return self.titleRect;
}

@end
