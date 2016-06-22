//
//  ScottStatusResult.h
//  ScottExtension
//
//  Created by Scott_Mr on 16/6/21.
//  Copyright © 2016年 Scott_Mr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ScottStatusResult : NSObject

/** 存放着某一页微博数据（里面都是Status模型） */
@property (nonatomic, strong) NSMutableArray *statuses;
/** 存放着一堆的广告数据（里面都是Ad模型） */
@property (nonatomic, strong) NSArray *ads;
/** 总数 */
@property (nonatomic, strong) NSNumber *totalNumber;
/** 上一页的游标 */
@property (nonatomic, assign) long long previousCursor;
/** 下一页的游标 */
@property (nonatomic, assign) long long nextCursor;

@end
