//
//  coreDataManager.h
//  HotarubiNote
//
//  Created by 潘安宇 on 2017/8/11.
//  Copyright © 2017年 潘安宇. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface coreDataManager : NSObject
//创建单例
+ (instancetype) shareCoreDataManager;

@property (nonatomic, strong, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, strong, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

//保存上下文
- (void) saveContext;

//自定义一个方法，其中的操作就是通过实体名插入想要的数据
- (NSManagedObject *) addManagerObjectWithEntityName:(NSString *)entityName;

//查询方法，需要谓词，排序方式
- (NSArray *) fetchEntityName:(NSString *)entityName predicate:(NSPredicate *)predicate orderby:(NSArray *)sortDescriptors;



@end
