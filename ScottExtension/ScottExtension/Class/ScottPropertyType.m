//
//  ScottPropertyType.m
//  ScottExtension
//
//  Created by Scott_Mr on 16/6/19.
//  Copyright © 2016年 Scott_Mr. All rights reserved.
//

#import "ScottPropertyType.h"
#import "NSObject+ScottProperty.h"

/**
 *  成员变量类型（属性类型）
 */
NSString *const ScottPropertyTypeInt = @"i";
NSString *const ScottPropertyTypeShort = @"s";
NSString *const ScottPropertyTypeFloat = @"f";
NSString *const ScottPropertyTypeDouble = @"d";
NSString *const ScottPropertyTypeLong = @"q";
NSString *const ScottPropertyTypeChar = @"c";
NSString *const ScottPropertyTypeBOOL1 = @"c";
NSString *const ScottPropertyTypeBOOL2 = @"b";
NSString *const ScottPropertyTypePointer = @"*";

NSString *const ScottPropertyTypeIvar = @"^{objc_ivar=}";
NSString *const ScottPropertyTypeMethod = @"^{objc_method=}";
NSString *const ScottPropertyTypeBlock = @"@?";
NSString *const ScottPropertyTypeClass = @"#";
NSString *const ScottPropertyTypeSEL = @":";
NSString *const ScottPropertyTypeId = @"@";

@implementation ScottPropertyType

static NSMutableDictionary *cacheTypes_;
+ (void)load {
    cacheTypes_ = [NSMutableDictionary dictionary];
}

+ (instancetype)propertiesWithAttributeString:(NSString *)att {
    return [[ScottPropertyType alloc] initWithTypeString:att];
}

- (instancetype)initWithTypeString:(NSString *)typeString {
    
    if (self = [super init]) {
        NSUInteger loc = 1;
        NSUInteger len = [typeString rangeOfString:@","].location - loc;
        NSString *typeCode = [typeString substringWithRange:NSMakeRange(loc, len)];

        if (!cacheTypes_[typeCode]) {
            [self getTypeCode:typeCode];
            cacheTypes_[typeCode] = self;
        }
    }
    return self;
}

- (void)getTypeCode:(NSString *)code {
    NSLog(@"%@",code);
    if ([code isEqualToString:ScottPropertyTypeId]) {
        _idType = YES;
    }else if (code.length > 3 && [code hasPrefix:@"@\""]){
        // 去掉@"和"，截取中间的类型名称
        code = [code substringWithRange:NSMakeRange(2, code.length - 3)];
        _typeClass = NSClassFromString(code);
        _numberType = (_typeClass == [NSNumber class] || [_typeClass isSubclassOfClass:[NSNumber class]]);
        
        // 判断是否来自于foundation框架
        _fromFoundation = [NSObject isClassFromFoundation:_typeClass];
    }
    
    // 是否为数字类型
    NSString *lowerCode = code.lowercaseString;
    NSArray *numberTypes = @[ScottPropertyTypeInt,
                             ScottPropertyTypeShort,
                             ScottPropertyTypeFloat,
                             ScottPropertyTypeDouble,
                             ScottPropertyTypeLong,
                             ScottPropertyTypeChar,
                             ScottPropertyTypeBOOL1,
                             ScottPropertyTypeBOOL2];
    if ([numberTypes containsObject:lowerCode]) {
        _numberType = YES;
        if ([lowerCode isEqualToString:ScottPropertyTypeBOOL1] || [lowerCode isEqualToString:ScottPropertyTypeBOOL2]) {
            _boolType = YES;
        }
    }
}

@end
