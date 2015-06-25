//
//  NSDictionary+NullReplace.h
//  PhotoBrowserDemo
//
//  Created by leoliu on 15/4/8.
//  Copyright (c) 2015年 leoliu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (NullReplace)

- (id)objectForKeyNotNull:(NSString *)key;

@end
