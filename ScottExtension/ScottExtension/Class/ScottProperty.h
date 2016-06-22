//
//  ScottProperty.h
//  ScottExtension
//
//  Created by Scott_Mr on 16/6/19.
//  Copyright © 2016年 Scott_Mr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@class ScottPropertyType;
@interface ScottProperty : NSObject

/**  属性名 */
@property (nonatomic, readonly) NSString *name;

/**  成员属性的类型 */
@property (nonatomic, readonly) ScottPropertyType *type;

+ (instancetype)propertyWithProperty:(objc_property_t)property;

@end
