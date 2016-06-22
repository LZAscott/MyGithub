//
//  ScottIdAndDescription.m
//  ScottExtension
//
//  Created by Scott_Mr on 16/6/21.
//  Copyright © 2016年 Scott_Mr. All rights reserved.
//

#import "ScottIdAndDescription.h"

@implementation ScottIdAndDescription

+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{
             @"ID" : @"id",
             @"Description" : @"description"
             };
}


@end
