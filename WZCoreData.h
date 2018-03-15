//
//  WZCoreData.h
//  YaGuan
//
//  Created by 王亚振 on 2018/3/14.
//  Copyright © 2018年 DemoKing. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface WZCoreData : NSObject

/**
 必须执行
 */
+ (void)saveContext;

/**
 查询本地是否含有此类数据

 @param predicateString 表格中的参数
 @param identifier 需要传入比较的标识符
 @param clazz  model类别
 @return YES || NO
 */
+ (BOOL)haveDataWithPredicateString:(NSString *)predicateString identifier:(NSString *)identifier clazz:(Class)clazz;

/**
 增 创建需要插入的数据模型 赋值后调用save即可保存

 @param clazz 类型
 @return 对象
 */
+ (id)modelNeedInsertWithClazz:(Class)clazz;

/**
 删 删除数据

 @param model model
 */
+ (void)deleteModel:(id)model;

/**
 删除所有数据
 */
+ (void)deleteAllModelWithClass:(Class)clazz;

/**
 根据identifier查询本地数据

 @param predicateString 表格中的参数
 @param identifier 需要传入比较的标识符
 @param clazz model类别
 @return 数组 或者 model
 */
+ (id)dataWithPredicateString:(NSString *)predicateString identifier:(NSString *)identifier clazz:(Class)clazz;

@end
