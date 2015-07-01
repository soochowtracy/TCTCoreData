//
//  TCTCoreDataHelper.m
//  TCTravel_IPhone
//
//  Created by Tracyone on 15/4/27.
//
//

#import "TCTCoreDataHelper.h"
#import "TCTCoreDataManager.h"

static NSString * const kCoreDataManagerDatabaseName = @"TCTravel_Iphone_V630.sqlite";
static NSString * const kCoreDataManagerModelName = @"tongchengNew";


@implementation TCTCoreDataSortOption
{
    NSString *_key;
    BOOL _acsend;
}

- (instancetype)initWithKey:(NSString *)key isAcsend:(BOOL)acsend{
    if (self = [super init]) {
        _key = key;
        _acsend = acsend;
    }
    return self;
}

+ (instancetype)coreDataSortOptionWithKey:(NSString *)key isAcsend:(BOOL)acsend{
    TCTCoreDataSortOption *coreDataSortOption = [[TCTCoreDataSortOption alloc] initWithKey:key isAcsend:acsend];
    return coreDataSortOption;
}

- (NSString *)sortOptionKey{
    return _key;
}

- (BOOL)sortOptionAcsend{
    return _acsend;
}

@end

@interface TCTCoreDataHelper ()

@property (nonatomic, strong) TCTCoreDataManager *manager;

@end

@implementation TCTCoreDataHelper

+ (instancetype)sharedHelper{
    static TCTCoreDataHelper *singleton;
    static dispatch_once_t singletonToken;
    dispatch_once(&singletonToken, ^{
        singleton = [[self alloc] init];
    });
    return singleton;
}

- (instancetype)init{
    if (self = [super init]) {
        _manager = [TCTCoreDataManager sharedManager];
        _manager.databaseName = kCoreDataManagerDatabaseName;
        _manager.modelName = kCoreDataManagerModelName;
        
        [_manager copyDefaultStoreIfNeeded:[_manager sqliteStoreURL]];
    }
    
    return self;
}


- (NSArray *)searchAllByEntity:(NSString *)entityName where:(NSString *)conditionName orderByOptions:(NSArray *)options{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    if (conditionName) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:conditionName];
        request.predicate = predicate;
    }
    
    if (options) {
        NSMutableArray *array = [NSMutableArray array];
        
        [options enumerateObjectsUsingBlock:^(TCTCoreDataSortOption *obj, NSUInteger idx, BOOL *stop) {
            if ([obj isKindOfClass:[TCTCoreDataSortOption class]]) {
                NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:obj.sortOptionKey ascending:obj.sortOptionAcsend];
                [array addObject:sort];
            }
        }];
        
        request.sortDescriptors = array;
    }
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:self.manager.managedObjectContext];
    request.entity = entity;
    
    NSError *error;
    NSArray* objects = [self.manager.managedObjectContext executeFetchRequest:request error:&error];
    
    if (!objects) {
        NSLog(@"%@", error.description);
    }
    return objects;
}

//- (NSArray *)searchAllByEntity:(NSString *)entityName where:(NSString *)conditionName orderByOptions:(NSDictionary *)options{
//    NSFetchRequest *request = [[NSFetchRequest alloc] init];
//    if (conditionName) {
//        NSPredicate *predicate = [NSPredicate predicateWithFormat:conditionName];
//        request.predicate = predicate;
//    }
//    
//    if (options) {
//        NSMutableArray *array = [NSMutableArray array];
//        [options enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSNumber *obj, BOOL *stop) {
//            NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:key ascending:[obj boolValue]];
//            [array addObject:sort];
//        }];
//        
//        request.sortDescriptors = array;
//    }
//    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:self.manager.managedObjectContext];
//    request.entity = entity;
//    
//    NSError *error;
//    NSArray* objects = [self.manager.managedObjectContext executeFetchRequest:request error:&error];
//    
//    if (!objects) {
//        NSLog(@"%@", error.description);
//    }
//    return objects;
//}

- (NSArray *)searchAllByEntity:(NSString *)entityName{
    return [self searchAllByEntity:entityName where:nil orderByOptions:nil];
}

- (NSArray *)searchAllByEntity:(NSString *)entityName where:(NSString *)conditionName{
    return [self searchAllByEntity:entityName where:conditionName orderByOptions:nil];
}

- (NSArray *)searchAllByEntity:(NSString *)entityName orderByOptions:(NSArray *)options{
    return [self searchAllByEntity:entityName where:nil orderByOptions:options];
}

- (void)deleteAllByManagedObject:(NSManagedObject *)managedObject{
    [self.manager.managedObjectContext deleteObject:managedObject];
}

- (void)deleteAllByManagedObjects:(NSArray *)managedObjects{
    [managedObjects enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [self deleteAllByManagedObject:obj];
    }];
}

- (id)insertByEntity:(NSString *)entityName{
    return [NSEntityDescription insertNewObjectForEntityForName:entityName inManagedObjectContext:self.manager.managedObjectContext];
}

- (BOOL)save{
    return [self.manager saveContext];
}

@end

@implementation TCTCoreDataHelper (TCTExtendedCoreDataHelper)


+ (TCTCoreDataSortOption *)sortOptionWithkey:(NSString *)key isAcsend:(BOOL)acsend{
    return [TCTCoreDataSortOption coreDataSortOptionWithKey:key isAcsend:acsend];
}

+ (NSArray *)searchAllByEntity:(NSString *)entityName{
    return [[self sharedHelper] searchAllByEntity:entityName where:nil orderByOptions:nil];
}

+ (NSArray *)searchAllByEntity:(NSString *)entityName where:(NSString *)conditionName{
    return [[self sharedHelper] searchAllByEntity:entityName where:conditionName orderByOptions:nil];
}

+ (NSArray *)searchAllByEntity:(NSString *)entityName orderByOptions:(NSArray *)options{
    return [self searchAllByEntity:entityName where:nil orderByOptions:options];
}

+ (NSArray *)searchAllByEntity:(NSString *)entityName where:(NSString *)conditionName orderByOptions:(NSArray *)options{
    return [[self sharedHelper] searchAllByEntity:entityName where:conditionName orderByOptions:options];
}

+ (void)deleteAllByManagedObject:(NSManagedObject *)managedObject{
    [[self sharedHelper] deleteAllByManagedObject:managedObject];
}
+ (void)deleteAllByManagedObjects:(NSArray *)managedObjects{
    [[self sharedHelper] deleteAllByManagedObjects:managedObjects];
}

+ (id)insertByEntity:(NSString *)entityName{
    return [[self sharedHelper] insertByEntity:entityName];
}

+ (BOOL)save{
    return [[self sharedHelper] save];
}

- (BOOL)saveContext {
    if (self.managedObjectContext == nil) {
        return NO;
    }
    if (![self.managedObjectContext hasChanges]){
        return NO;
    }
    
    NSError *error = nil;
    
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Unresolved error in saving context! %@, %@", error, [error userInfo]);
        return NO;
    }
    
    return YES;
}

@end
