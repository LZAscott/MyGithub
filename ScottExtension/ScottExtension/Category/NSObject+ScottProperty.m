//
//  NSObject+ScottProperty.m
//  ScottExtension
//
//  Created by Scott_Mr on 16/6/18.
//  Copyright © 2016年 Scott_Mr. All rights reserved.
//

#import "NSObject+ScottProperty.h"
#import <objc/runtime.h>
#import "ScottProperty.h"
#import "ScottPropertyType.h"


@implementation NSObject (ScottProperty)

static NSSet *foundationClasses_;

// 设置一个全局字典用来将类的属性都缓存起来
static NSMutableDictionary *cachedProperties_;

+ (void)load
{
    cachedProperties_ = [NSMutableDictionary dictionary];
}

+ (NSSet *)foundationClass {
    if (foundationClasses_ == nil) {
        foundationClasses_ = [NSSet setWithObjects:[NSURL class],
                              [NSDate class],
                              [NSValue class],
                              [NSData class],
                              [NSArray class],
                              [NSDictionary class],
                              [NSString class],
                              [NSMutableString class], nil];
    }
    return foundationClasses_;
}

+ (BOOL)isClassFromFoundation:(Class)c {
    // 因为foundationClasses_里面的类都是继承NSObject，因此NSObject不能放到上面的集合，需要额外做判断
    if (c == [NSObject class]) return YES;
    
    __block BOOL result = NO;
    [[self foundationClass] enumerateObjectsUsingBlock:^(Class foundationClass, BOOL *stop) {
        if ([c isSubclassOfClass:foundationClass]) {
            result = YES;
            *stop = YES;
        }
    }];
    
    return result;
}


+ (NSArray *)properties {
    NSMutableArray *propertiesArr = cachedProperties_[NSStringFromClass(self)];
    
    if (!propertiesArr) {
//        NSLog(@"%@调用了properties方法",[self class]);
        propertiesArr = [NSMutableArray array];
        
        unsigned int outCount = 0;
        objc_property_t *properties = class_copyPropertyList(self, &outCount);
        
        for (int i=0; i<outCount; i++) {
            objc_property_t property = properties[i];
            ScottProperty *propertyObj = [ScottProperty propertyWithProperty:property];
            [propertiesArr addObject:propertyObj];
            //        NSLog(@"name:%@--type:%@",propertyObj.name,propertyObj.type.typeClass);
            
            // 为了以后方便使用，将C字符串转化成OC对象
            //        char *name = property_getName(property);
            //        NSString *name = @(property_getName(property));
            
            //        char *att = property_getAttributes(property);
            //        NSString *att = @(property_getAttributes(property));
            
            //        NSUInteger loc = 1;
            //        NSUInteger len = [att rangeOfString:@","].location - loc;
            
            //        NSString *type = [att substringWithRange:NSMakeRange(loc, len)];
            //        NSLog(@"%@",type);
        }
        
        free(properties);
        cachedProperties_[NSStringFromClass(self)] = propertiesArr;
    }
    
    return propertiesArr;
}


@end
