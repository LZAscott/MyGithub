//
//  main.m
//  ScottExtension
//
//  Created by Scott_Mr on 16/6/18.
//  Copyright © 2016年 Scott_Mr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ScottUser.h"
#import "NSObject+ScottProperty.h"
#import "NSObject+ScottKeyValue.h"
#import "ScottStatus.h"
#import "ScottStatusResult.h"
#import "ScottAd.h"
#import "ScottIdAndDescription.h"

#pragma mark - 函数声明
void keyValue2object();
void keyValues2object1();
void keyValues2object2();
void keyValues2object3();
void keyValues2object4();

void excute(void (*func)());


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        excute(keyValue2object);
        excute(keyValues2object1);
        excute(keyValues2object2);
        excute(keyValues2object3);
        excute(keyValues2object4);
    }
    return 0;
}


void excute(void (*func)()){
    func();
    return;
}

#pragma mark - 简单字典转模型
void keyValue2object(){
    NSDictionary *dict = @{@"name":@"Scott",
                           @"icon" : @"lufy.png",
                           @"age" : @"20",
                           @"height" : @1.75,
                           @"money" : @"100.9",
                           @"sex" : @(SexMale),
                           @"gay" : @"ture",
                           };
    
    
    ScottUser *userModel = [ScottUser objectWithKeyValues:dict];
//    NSLog(@"name:%@,icon:%@,age:%d,height:%@,money:%@,sex:%ld,gay:%d",userModel.name,userModel.icon,userModel.age,userModel.height,userModel.money,(long)userModel.sex,userModel.gay);
}

#pragma mark - JSON字符串转模型
void keyValues2object1(){
    // 1.定义一个json字符串
    NSString *jsonString = @"{\"name\":\"scott\",\"icon\":\"lufy.png\",\"age\":20}";
    
    // 2.将json字符串转为LZUser模型
    ScottUser *user = [ScottUser objectWithKeyValues:jsonString];
    
    // 3.打印模型属性
//    NSLog(@"name=%@, icon=%@, age=%d",user.name,user.icon,user.age);
}

#pragma mark - 复杂字典转模型
void keyValues2object2(){
    NSDictionary *dict = @{@"text":@"是啊，今天天气确实不错！",
                           @"user":@{
                                   @"name":@"scott",
                                   @"icon":@"lufy.png"
                                   },
                           @"retweetedStatus":@{
                                   @"text":@"是啊，今天天气确实不错",
                                   @"user":@{
                                           @"name":@"scott_status",
                                           @"icon":@"lufy_status.png"
                                           }
                                   }
                           };
    
    ScottStatus *status = [ScottStatus objectWithKeyValues:dict];
    
    // 打印status属性
    NSString *text = status.text;
    NSString *name = status.user.name;
    NSString *icon = status.user.icon;
//    NSLog(@"text:%@, name:%@, icon:%@",text,name,icon);
    
    // 打印retweetedStatus
    NSString *text2 = status.retweetedStatus.text;
    NSString *name2 = status.retweetedStatus.user.name;
    NSString *icon2 = status.retweetedStatus.user.icon;
//    NSLog(@"text2:%@, name2:%@, icon2:%@",text2,name2,icon2);
}

#pragma mark - 字典数组转模型
void keyValues2object3(){
    NSDictionary *dict = @{
                           @"statuses" : @[
                                   @{
                                       @"text" : @"今天天气真不错！",
                                       
                                       @"user" : @{
                                               @"name" : @"Rose",
                                               @"icon" : @"nami.png"
                                               }
                                       },
                                   
                                   @{
                                       @"text" : @"明天去旅游了",
                                       
                                       @"user" : @{
                                               @"name" : @"Jack",
                                               @"icon" : @"lufy.png"
                                               }
                                       }
                                   
                                   ],
                           
                           @"ads" : @[
                                   @{
                                       @"image" : @"ad01.png",
                                       @"url" : @"http://www.baidu.com"
                                       },
                                   @{
                                       @"image" : @"ad02.png",
                                       @"url" : @"http://www.sina.com"
                                       }
                                   ],
                           
                           @"totalNumber" : @"2014",
                           @"previousCursor" : @"13476589",
                           @"nextCursor" : @"13476599"
                           };
    
    ScottStatusResult *result = [ScottStatusResult objectWithKeyValues:dict];
//    NSLog(@"totalNumber=%@, previousCursor:%lld, nextCursor:%lld",result.totalNumber,result.previousCursor,result.nextCursor);
    
    for (ScottStatus *status in result.statuses) {
        NSString *text = status.text;
        NSString *name = status.user.name;
        NSString *icon = status.user.icon;
//        NSLog(@"text:%@, name:%@, icon:%@",text,name,icon);
    }
    
    for (ScottAd *ad in result.ads) {
        NSString *img = ad.image;
        NSURL *url = ad.url;
//        NSLog(@"img:%@, url:%@",img,url);
    }
}

#pragma mark - key的替换
void keyValues2object4(){
    NSDictionary *dict = @{
                           @"id" : @"Jack",
                           @"description" : @"lufy.png",
                           };
    
    ScottIdAndDescription *result = [ScottIdAndDescription objectWithKeyValues:dict];
    
//    NSLog(@"%@,%@",result.ID,result.Description);
}
