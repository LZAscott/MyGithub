//
//  ScottPropertyType.h
//  ScottExtension
//
//  Created by Scott_Mr on 16/6/19.
//  Copyright © 2016年 Scott_Mr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ScottPropertyType : NSObject

/**  是否为id类型 */
@property (nonatomic, readonly, getter=isIdType) BOOL idType;
/**  是否为基本数据类型(int、float等) */
@property (nonatomic, readonly, getter=isNumberType) BOOL numberType;
/**  是否为bool类型 */
@property (nonatomic, readonly, getter=isBoolType) BOOL boolType;
/**  对象类型(如果是基本数据类型，此值为nil) */
@property (nonatomic, readonly) Class typeClass;

/**  是否来源于Foundation框架，比如NSString,NSArray等 */
@property (nonatomic, readonly, getter=isFromFoundation) BOOL fromFoundation;

+ (instancetype)propertiesWithAttributeString:(NSString *)att;

@end
