//
//  ScottStatus.h
//  ScottExtension
//
//  Created by Scott_Mr on 16/6/21.
//  Copyright © 2016年 Scott_Mr. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ScottUser;
@interface ScottStatus : NSObject

/**  微博原文内容 */
@property (nonatomic, copy) NSString *text;
/**  微博作者 */
@property (nonatomic, strong) ScottUser *user;
/**  转发的微博 */
@property (nonatomic, strong) ScottStatus *retweetedStatus;

@end
