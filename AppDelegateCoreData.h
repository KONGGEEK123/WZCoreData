//
//  AppDelegateCoreData.h
//  YaGuan
//
//  Created by 王亚振 on 2018/3/15.
//  Copyright © 2018年 DemoKing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegateCoreData : UIResponder
#pragma mark -
#pragma mark - CoreData
/**
 *  被管理对象上下文 （数据管理器）相当于一个临时数据库
 */
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
/**
 *  被管理对象模型 （数据模型器）
 */
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
/**
 *  持久化存储助理 （数据连接器）核心
 */
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
/**
 *  提交临时数据库 commit
 */
- (void)saveContext;
/**
 *  获取真实文件的存储路径
 *
 *  @return URL类型对象
 */
- (NSURL *)applicationDocumentsDirectory;
@end
