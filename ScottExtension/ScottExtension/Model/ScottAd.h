//
//  ScottAd.h
//  ScottExtension
//
//  Created by Scott_Mr on 16/6/21.
//  Copyright © 2016年 Scott_Mr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ScottAd : NSObject

/** 广告图片 */
@property (nonatomic, copy) NSString *image;
/** 广告url */
@property (nonatomic, strong) NSURL *url;

@end
