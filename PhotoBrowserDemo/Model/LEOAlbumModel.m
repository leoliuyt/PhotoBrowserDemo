//
//  LEOAlbumModel.m
//  PhotoBrowserDemo
//
//  Created by leoliu on 15/6/25.
//  Copyright (c) 2015年 leoliu. All rights reserved.
//

#import "LEOAlbumModel.h"

@implementation LEOAlbumModel
- (id)initWithDic:(NSDictionary *)dic
{
    self = [super initWithDic:dic];
    if (self) {
        NSMutableArray *itemsArr = [NSMutableArray array];
        if([_albumItems isKindOfClass:[NSArray class]]){
            [_albumItems enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                LEOAlbumItemModel *albumItemModel = [[LEOAlbumItemModel alloc]initWithDic:obj];
                [itemsArr addObject:albumItemModel];
            }];
        }
        
        _albumItems = itemsArr;
    }
    return self;
}
@end



@implementation LEOAlbumItemModel

@end
