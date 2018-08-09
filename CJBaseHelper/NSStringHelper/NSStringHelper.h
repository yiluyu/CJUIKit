//
//  NSStringHelper.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 6/25/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//
//  知识点：判断是否为空字符串，不能通过NSString的实例方法来进行判断。因为实例方法是通过对象调用的，当这个对象为空时调用方法的时候就不会执行。所以以下两个方法，当string = nil的时候，如果调用[string isEmpty]等类似的实例方法，会返回NO，也就无法返回正确的YES值了。

#import <Foundation/Foundation.h>

//判断是否空字符串
#define cjIsNullString(s)   (!s || [s isEqual:[NSNull null]] || [s isEqualToString:@""])

@interface NSStringHelper : NSObject

#pragma mark - 判断是否为空字符串
///是否为空字符串
+ (BOOL)isEmptyForString:(NSString *)string;

///判断自己是否为空
+ (BOOL)isBlankForString:(NSString *)string;

@end