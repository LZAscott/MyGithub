//
//  ScottProperty.m
//  ScottExtension
//
//  Created by Scott_Mr on 16/6/19.
//  Copyright © 2016年 Scott_Mr. All rights reserved.
//

#import "ScottProperty.h"
#import "ScottPropertyType.h"

@implementation ScottProperty

+ (instancetype)propertyWithProperty:(objc_property_t)property {
    return [[ScottProperty alloc] initWithProperty:property];
}

- (instancetype)initWithProperty:(objc_property_t)property {
    if (self = [super init]) {
        _name = @(property_getName(property));
        _type = [ScottPropertyType propertiesWithAttributeString:@(property_getAttributes(property))];
    }
    return self;
}

@end
