//
//  constant.h
//  PhotoBrowserDemo
//
//  Created by leoliu on 15/6/25.
//  Copyright (c) 2015年 leoliu. All rights reserved.
//

#ifndef PhotoBrowserDemo_constant_h
#define PhotoBrowserDemo_constant_h

#define SharedAppDelegate ((AppDelegate*)[[UIApplication sharedApplication] delegate])

#pragma mark 宏定义DLog输出

#ifdef DEBUG
#ifndef DLog
#   define DLog(fmt, ...) {NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);}
#endif
#ifndef ELog
#   define ELog(err) {if(err) DLog(@"%@", err)}
#endif
#else
#ifndef DLog
#   define DLog(...)
#endif
#ifndef ELog
#   define ELog(err)
#endif
#endif

#pragma mark ---RGB两个宏定义
#define RGBColor(x,y,z) [UIColor colorWithRed:(x)/255.0f green:(y)/255.0f blue:(z)/255.0f                                                                                  alpha:1.0]

#define RGBValue(rgbValue) [UIColor colorWithRed:((float)((rgbValue &0xFF0000) >>16))/255.0 green:((float)((rgbValue &0xFF00) >> 8))/255.0 blue:((float)((rgbValue &0xFF)))/255.0 alpha:1.0]

#pragma mark ---宽、高宏定义
#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height
#define kTabBarHeight 49
#define kNavBarHeight 44
#define kNavAndStateBarHeight 64
#define kStateBarHeight 20
#define kSegementHeight 40

#define iPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(320*2, 480*2), [[UIScreen mainScreen] currentMode].size) : NO)

#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(320*2, 568*2), [[UIScreen mainScreen] currentMode].size) : NO)

#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(375*2, 667*2), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(621*2, 1104*2), [[UIScreen mainScreen] currentMode].size) : NO)

#endif
