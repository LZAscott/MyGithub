//
//  ScottStatusResult.m
//  ScottExtension
//
//  Created by Scott_Mr on 16/6/21.
//  Copyright © 2016年 Scott_Mr. All rights reserved.
//

#import "ScottStatusResult.h"

@implementation ScottStatusResult

+ (NSDictionary *)objectClassInArray
{
    return @{
             @"statuses":@"ScottStatus",
             @"ads":@"ScottAd"
             };
}


@end
