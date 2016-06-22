//
//  NSObject+ScottKeyValue.h
//  ScottExtension
//
//  Created by Scott_Mr on 16/6/20.
//  Copyright © 2016年 Scott_Mr. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ScottKeyValue <NSObject>

@optional
+ (NSDictionary *)replacedKeyFromPropertyName;
+ (NSDictionary *)objectClassInArray;

@end

@interface NSObject (ScottKeyValue)<ScottKeyValue>

+ (instancetype)objectWithKeyValues:(id)keyValues;

@end
