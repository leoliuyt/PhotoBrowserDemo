//
//  LEOBaseModel.m
//  PhotoBrowserDemo
//
//  Created by leoliu on 15/6/25.
//  Copyright (c) 2015年 leoliu. All rights reserved.
//

#import "LEOBaseModel.h"
#import "NSDictionary+NullReplace.h"
#import <objc/runtime.h>

@implementation LEOBaseModel

-(NSString *)description
{
    NSMutableString *value = [[NSMutableString alloc] init];
    
    [self.propertyList enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [value appendFormat:@"%@:%@,\n",obj,[self valueForKey:obj]];
    }];
    
    return [NSString stringWithFormat:@"%s:%p:\n%@",class_getName([self class]),self,value];
}

@end


@implementation NSObject (DictionaryToModel)

-(id)initWithDic:(NSDictionary *)dic
{
    if([dic isKindOfClass:[NSDictionary class]])
    {
        [self.propertyList enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            if (dic[obj] == nil||[dic[obj] isKindOfClass:[NSNull class]]){
                [self setValue:@"" forKey:obj];
            }else{
                [self setValue:[dic objectForKeyNotNull:obj] forKey:obj];
            }
        }];
    }
    return [self init];
    
}

-(NSArray *)propertyList
{
    unsigned int propertyCount;
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    objc_property_t *property_t = class_copyPropertyList([self class], &propertyCount);
    
    for (int i = 0; i < propertyCount; i++) {
        objc_property_t item = property_t[i];
        const char *tmp = property_getName(item);
        [array addObject:[NSString stringWithCString:tmp encoding:NSUTF8StringEncoding]];
    }
    free(property_t);
    return array;
}


@end