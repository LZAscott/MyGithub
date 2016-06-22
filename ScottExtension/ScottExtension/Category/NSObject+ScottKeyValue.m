//
//  NSObject+ScottKeyValue.m
//  ScottExtension
//
//  Created by Scott_Mr on 16/6/20.
//  Copyright © 2016年 Scott_Mr. All rights reserved.
//

#import "NSObject+ScottKeyValue.h"
#import "NSObject+ScottProperty.h"
#import "ScottProperty.h"
#import "ScottPropertyType.h"

@implementation NSObject (ScottKeyValue)

+ (instancetype)objectWithKeyValues:(id)keyValues {
    if (!keyValues) return nil;
    
    return [[[self alloc] init] setKeyValues:keyValues];
}

+ (NSString *)propertyKey:(NSString *)propertyName {
    NSString *key;
    if ([self respondsToSelector:@selector(replacedKeyFromPropertyName)]) {
        key = [self replacedKeyFromPropertyName][propertyName];
    }
    return key ? key : propertyName;
}

- (instancetype)setKeyValues:(id)keyValues {
    
    keyValues = [keyValues JSONObject];
    
    NSArray *propertiesArray = [self.class properties];
    for (ScottProperty *property in propertiesArray) {
        ScottPropertyType *type = property.type;
        Class typeClass = type.typeClass;
        
        // 属性名作为键去寻找对应的值
        id value = [keyValues valueForKey:[self.class propertyKey:property.name]];
        if (!value) continue;
        
//        NSLog(@"%@",value);
        
//        if (type.isBoolType) {
//            NSLog(@"Bool");
//        }else if (type.isIdType){
//            NSLog(@"ID");
//        }else if (type.isNumberType){
//            NSLog(@"Number");
//        }else{
//            NSLog(@"%@",typeClass);
//        }
        
        // 如果不是来自foundation框架的类并且不是基本数据类型 ,则递归,如果是基本数据类型，typeClass为nil
        if (!type.isFromFoundation && typeClass) {
            value = [typeClass objectWithKeyValues:value];
        }else if ([self.class respondsToSelector:@selector(objectClassInArray)]){ // 看该类是否实现了objectClassInArray方法
            id objectClass;
            objectClass = [self.class objectClassInArray][property.name];
            
            // 如果是NSString类型
            if ([objectClass isKindOfClass:[NSString class]]) {
                objectClass = NSClassFromString(objectClass);
            }
            
            if (objectClass) {
                // 返回一个装了模型的数组
                value = [objectClass objectArrayWithKeyValuesArray:value];
            }
        }else if (type.isNumberType == YES) {
            NSString *oldValue = value;
            // 字符串-->数字
            if ([value isKindOfClass:[NSString class]]) {
                value = [[[NSNumberFormatter alloc] init] numberFromString:value];
                if (type.isBoolType) {
                    NSString *lower = [oldValue lowercaseString];
                    if ([lower isEqualToString:@"yes"] || [lower isEqualToString:@"ture"]) {
                        value = @YES;
                    }else if ([lower isEqualToString:@"no"] || [lower isEqualToString:@"false"]){
                        value = @NO;
                    }
                }
            }
        } else {
            if (typeClass == [NSString class]) {
                if ([value isKindOfClass:[NSNumber class]]) {
                    if (type.isNumberType)
                        // NSNumber -> NSString
                        value = [value description];
                }else if ([value isKindOfClass:[NSURL class]]){
                    // NSURL -> NSString
                    value = [value absoluteString];
                }
            }
        }
        
        [self setValue:value forKey:property.name];
    }
    
    return self;
}

/**
 *  根据字典/JSON返回模型数组
 *
 *  @param keyValuesArray 字典/JSON数组
 *
 *  @return 模型数组
 */
+ (NSMutableArray *)objectArrayWithKeyValuesArray:(id)keyValuesArray
{
    if ([self isClassFromFoundation:self])
        return keyValuesArray;
    
    keyValuesArray = [keyValuesArray JSONObject];
    
    NSMutableArray *modelArray = [NSMutableArray array];
    
    // 遍历
    for (NSDictionary *keyValues in keyValuesArray) {
        id model;
        model = [self objectWithKeyValues:keyValues];
        if (model) {
            [modelArray addObject:model];
        }
    }
    
    return modelArray;
}


- (id)JSONObject {
    id foundationObj;
    if ([self isKindOfClass:[NSString class]]) {
        NSString *str = (NSString *)self;
        foundationObj = [NSJSONSerialization  JSONObjectWithData:[str dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil];
    }else if ([self isKindOfClass:[NSData class]]){
        foundationObj = [NSJSONSerialization JSONObjectWithData:(NSData *)self options:kNilOptions error:nil];
    }
    
    // 如果foundationObj有值，则返回foundationObj，否则返回self
    return foundationObj ? : self;
}

@end
