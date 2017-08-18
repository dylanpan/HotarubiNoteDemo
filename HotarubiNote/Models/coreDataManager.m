//
//  coreDataManager.m
//  HotarubiNote
//
//  Created by 潘安宇 on 2017/8/11.
//  Copyright © 2017年 潘安宇. All rights reserved.
//

#import "coreDataManager.h"

//定义一个单例对象
static coreDataManager *instance = nil;

@implementation coreDataManager

//单例方法实现
+ (instancetype) shareCoreDataManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[coreDataManager alloc] init];
    });
    return instance;
}

//等效属性只有get方法
@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

//1.模型文件对象
- (NSManagedObjectModel *) managedObjectModel{
    //懒加载
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    //获取到自己创建的core data model文件的路径，这个xcdatamodel的文件名不能与工程名称一致
    NSURL *modelPath = [[NSBundle mainBundle] URLForResource:@"MyCoreData" withExtension:@"momd"];
    if (modelPath != nil) {
        _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelPath];
        NSLog(@"entity:%@",[_managedObjectModel entities]);
        NSLog(@"model path is %@",modelPath);
    }else{
        //_managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
        NSLog(@"entity:%@",[_managedObjectModel entities]);
        NSLog(@"model path is nil");
    }
    
    return _managedObjectModel;
    
}

//2.创建协调器
- (NSPersistentStoreCoordinator *) persistentStoreCoordinator{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.managedObjectModel];
    
    //数据库的存储路径
    NSURL * dataPath = [NSURL fileURLWithPath:[NSHomeDirectory() stringByAppendingString:@"/Documents/MyCoreData.sqlite"]];
    NSLog(@"data path is %@",dataPath);
    //以下方法获取的路径是一样的
    //NSString *dataPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    //dataPath = [dataPath stringByAppendingFormat:@"/%@.sqlite",modelName];
    
    NSError *error = nil;
    //给协调器添加一个可持久化的对象
    NSPersistentStore *persitentStore = [_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                                                                  configuration:nil
                                                                                            URL:dataPath
                                                                                        options:nil
                                                                                          error:&error];
    
    if (!persitentStore) {
        //有错误，记录错误日志
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initalize the application's saved data.";
        dict[NSLocalizedFailureReasonErrorKey] = @"There was an error creating or loading the application's saved data.";
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        NSLog(@"Unresolved error %@,%@",error,[error userInfo]);
        //开发阶段可使用，app退出，生成一个崩溃文件
        abort();
    }
    
    return _persistentStoreCoordinator;
    
}

//3.上下文
- (NSManagedObjectContext *) managedObjectContext{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    //拷贝一份协调器
    NSPersistentStoreCoordinator *psc = [self persistentStoreCoordinator];
    //判断是否为空
    if (!psc) {
        return nil;
    }
    //创建对象，并设置操作类型，在主队列
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    //协调器
    _managedObjectContext.persistentStoreCoordinator = psc;
    return _managedObjectContext;
    
}

//4.保存上下文，当存储数据需要改变时调用，比如：insert、delete、update
- (void) saveContext{
    NSManagedObjectContext *context = self.managedObjectContext;
    if (context !=nil) {
        NSError *error = nil;
        if ([context hasChanges] && ![context save:&error]) {
            NSLog(@"Unresolved error %@,%@",error,[error userInfo]);
            abort();
        }
    }
}

- (NSManagedObject *) addManagerObjectWithEntityName:(NSString *)entityName{
    NSManagedObject *managerObject = [NSEntityDescription insertNewObjectForEntityForName:entityName inManagedObjectContext:self.managedObjectContext];
    return managerObject;
}

- (NSArray *)fetchEntityName:(NSString *)entityName predicate:(NSPredicate *)predicate orderby:(NSArray *)sortDescriptors{
    //抓取请求
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    //实体对象
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    //使用自定义谓词
    [fetchRequest setPredicate:predicate];
    
    //使用自己定义的排序操作
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    NSError *error = nil;
    NSArray *fetchedObjects = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if (fetchedObjects == nil) {
        NSLog(@"error");
    }
    
    return fetchedObjects;

}























@end
