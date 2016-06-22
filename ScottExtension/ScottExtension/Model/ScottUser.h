//
//  ScottUser.h
//  ScottExtension
//
//  Created by Scott_Mr on 16/6/18.
//  Copyright © 2016年 Scott_Mr. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, Sex) {
    SexMale,    // 男
    SexFemale   // 女
};

@interface ScottUser : NSObject

/**  姓名 */
@property (nonatomic, copy) NSString *name;
/**  头像 */
@property (nonatomic, copy) NSString *icon;
/**  年龄 */
@property (nonatomic, assign) unsigned int age;
/**  身高 */
@property (nonatomic, strong) NSNumber *height;
/**  财富 */
@property (nonatomic, copy) NSString *money;
/**  性别 */
@property (nonatomic, assign) Sex sex;
/**  是否同性 */
@property (nonatomic, assign, getter=isGay) BOOL gay;



@end
