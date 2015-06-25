//
//  LEOBaseModel.h
//  PhotoBrowserDemo
//
//  Created by leoliu on 15/6/25.
//  Copyright (c) 2015年 leoliu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSDictionary+NullReplace.h"

@interface LEOBaseModel : NSObject

@end

@interface NSObject (DictionaryToModel)

/**
 *  字典转model，实例化
 */
-(id)initWithDic:(NSDictionary *)dic;

/**
 *  获取当前类的属性列表
 */
-(NSArray *)propertyList;

@end