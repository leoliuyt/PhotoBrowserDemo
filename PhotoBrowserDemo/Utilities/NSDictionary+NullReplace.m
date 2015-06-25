//
//  NSDictionary+NullReplace.m
//  PhotoBrowserDemo
//
//  Created by leoliu on 15/4/8.
//  Copyright (c) 2015年 leoliu. All rights reserved.
//

#import "NSDictionary+NullReplace.h"

@implementation NSDictionary (NullReplace)

- (id)objectForKeyNotNull:(NSString *)key
{
    if([self isKindOfClass:[NSString class]])
    {
        return nil;
    }
    id object = [self objectForKey:key];
    if ([object isKindOfClass:[NSNumber class]] ||
        [object isKindOfClass:[NSString class]] ||
        [object isKindOfClass:[NSArray class]] ||
        [object isKindOfClass:[NSDictionary class]])
    {
        return object;
    }
    return nil;
}

@end
