//
//  enumtype.h
//  PhotoBrowserDemo
//
//  Created by leoliu on 15/5/13.
//  Copyright (c) 2015年 leoliu. All rights reserved.
//

#ifndef XHTVPortal_enumtype_h
#define XHTVPortal_enumtype_h

typedef NS_OPTIONS(NSUInteger, LoadViewType)
{
    LoadViewTypePicFailure = 0,     //图集详情加载失败
    LoadViewTypePicLoading = 1,     //图集详情加载中
    LoadViewTypeContentEmpty = 2,   //内容删除
    LoadViewTypeCollectEmpty = 3,   //收藏内容加载失败
    LoadViewTypeHistoryEmpty = 4,   // 浏览记录为空
    LoadViewTypeDelete       =5     //内容删除
};

#endif
