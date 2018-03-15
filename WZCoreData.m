//
//  WZCoreData.m
//  YaGuan
//
//  Created by 王亚振 on 2018/3/14.
//  Copyright © 2018年 DemoKing. All rights reserved.
//

#import "WZCoreData.h"
#import "AppDelegateCoreData.h"
@implementation WZCoreData
/**
 必须执行
 */
+ (void)saveContext {
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [delegate saveContext];
}

/**
 查询本地是否含有此类数据
 
 @param predicateString 表格中的参数
 @param identifier 需要传入比较的标识符
 @param clazz  model类别
 @return YES || NO
 */
+ (BOOL)haveDataWithPredicateString:(NSString *)predicateString identifier:(NSString *)identifier clazz:(Class)clazz {
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    // 创建过滤器
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:NSStringFromClass([clazz class])];
    if (identifier.length == 0 || predicateString.length == 0) {
        return NO;
    }else {
        // 查询本地是否含有此数据
        NSString *string = [[predicateString stringByAppendingString:@" CONTAINS "]  stringByAppendingString:identifier.uppercaseString];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:string];
        [request setPredicate:predicate];
        NSError *error = nil;
        NSArray *array = [delegate.managedObjectContext executeFetchRequest:request error:&error];
        return array.count;
    }
}
/**
 创建需要插入的数据模型 赋值后调用save即可保存
 
 @param clazz 类型
 @return 对象
 */
+ (id)modelNeedInsertWithClazz:(Class)clazz {
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    // 创建过滤器
    NSEntityDescription *description = [NSEntityDescription
                                        entityForName:NSStringFromClass([clazz class])
                                        inManagedObjectContext:delegate.managedObjectContext];
    return [[[clazz class] alloc]
            initWithEntity:description
            insertIntoManagedObjectContext:delegate.managedObjectContext];
}

/**
 删 删除数据
 
 @param model model
 */
+ (void)deleteModel:(id)model {
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [delegate.managedObjectContext deleteObject:model];
}

/**
 删除所有数据
 */
+ (void)deleteAllModelWithClass:(Class)clazz {
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:NSStringFromClass([clazz class])];
    NSError *error = nil;
    NSArray *array = [delegate.managedObjectContext executeFetchRequest:request error:&error];
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [delegate.managedObjectContext deleteObject:obj];
    }];
}

/**
 根据identifier查询本地数据
 
 @param predicateString 表格中的参数
 @param identifier 需要传入比较的标识符
 @param clazz model类别
 @return 数组 或者 model
 */
+ (id)dataWithPredicateString:(NSString *)predicateString identifier:(NSString *)identifier clazz:(Class)clazz {
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    // 创建过滤器
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:NSStringFromClass([clazz class])];
    if (identifier.length == 0 || predicateString.length == 0) {
        // 如果标识符为空 直接添加新的对象
        return nil;
    }else {
        // 查询本地是否含有此数据
        NSString *string = [[predicateString stringByAppendingString:@" CONTAINS "]  stringByAppendingString:identifier.uppercaseString];
        [request setPredicate:[NSPredicate predicateWithFormat:string]];
        NSError *error = nil;
        NSArray *array = [delegate.managedObjectContext executeFetchRequest:request error:&error];
        return array;
    }
}
@end
