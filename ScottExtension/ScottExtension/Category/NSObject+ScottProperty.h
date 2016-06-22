//
//  NSObject+ScottProperty.h
//  ScottExtension
//
//  Created by Scott_Mr on 16/6/18.
//  Copyright © 2016年 Scott_Mr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (ScottProperty)

+ (NSArray *)properties;

// 用于判断当前类是否来自于foundation框架
+ (BOOL)isClassFromFoundation:(Class)c;

@end
