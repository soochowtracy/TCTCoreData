//
//  TCTCoreData.m
//  TCTCoreDataHelper
//
//  Created by Tracy-One on 15/6/26.
//  Copyright (c) 2015年 Tracy-One. All rights reserved.
//

#import "TCTCoreData.h"
#import "TCTCoreDataConst.h"

static NSString * const kModelNameExtension = @"momd";

static NSString * TCT_StoreType(TCTCoreDataStoreType type){
    switch (type) {
        case TCTCoreDataStoreTypeSqlite:
            return NSSQLiteStoreType;
            break;
        case TCTCoreDataStoreTypeInMemory:
            return NSInMemoryStoreType;
            break;
        case TCTCoreDataStoreTypeBinary:
            return NSBinaryStoreType;
            break;
        default:
            return NSSQLiteStoreType;
            break;
    }
}

static NSString * TCT_FileNameExtension(TCTCoreDataStoreType type){
    switch (type) {
        case TCTCoreDataStoreTypeSqlite:
            return @"sqlite";
            break;
        case TCTCoreDataStoreTypeInMemory:
            return nil;
            break;
        case TCTCoreDataStoreTypeBinary:
            return nil;
            break;
        default:
            return @"sqlite";
            break;
    }
}

//static NSString * TCT_

@interface TCTCoreData ()

@property (strong, nonatomic) NSManagedObjectContext *managedObjectMainContext;
@property (strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@end

@implementation TCTCoreData

#pragma mark --init
+ (instancetype)defaultCoreData{
    static TCTCoreData *singleton;
    static dispatch_once_t singletonToken;
    dispatch_once(&singletonToken, ^{
        singleton = [[self alloc] init];
    });
    return singleton;
}

- (NSManagedObjectContext *)managedObjectMainContext{
    if (_managedObjectMainContext) {
        return _managedObjectMainContext;
    }
    
    if (self.persistentStoreCoordinator) {
        _managedObjectMainContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        [_managedObjectMainContext setPersistentStoreCoordinator:self.persistentStoreCoordinator];
    }
    return _managedObjectMainContext;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator{
    if (_persistentStoreCoordinator) {
        return _persistentStoreCoordinator;
    }
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.managedObjectModel];
    
    NSDictionary *options = @{ NSMigratePersistentStoresAutomaticallyOption: @YES,
                               NSInferMappingModelAutomaticallyOption: @YES };
    
    
    NSURL *fileURL = [[[self applicationDocumentsDirectory] URLByAppendingPathComponent:self.storeFileName] URLByAppendingPathExtension:TCT_FileNameExtension(self.storeType)];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if (![fileManager fileExistsAtPath:[fileURL path]]) {
        NSURL *storeURL = [self URLOfFileName:self.storeFileName withExtension:TCT_FileNameExtension(self.storeType)];
        if (storeURL) {
            [fileManager copyItemAtURL:storeURL toURL:fileURL error:NULL];
        }
    }
    
    NSError *error = nil;
    if (![_persistentStoreCoordinator addPersistentStoreWithType:TCT_StoreType(self.storeType) configuration:nil URL:fileURL options:options error:&error]) {
#if DEBUG
        [self dealWithLinkStoreError:error];
#endif
    }
    
    return _persistentStoreCoordinator;
}

- (NSManagedObjectModel *)managedObjectModel {
    if (_managedObjectModel) {
        return _managedObjectModel;
    }
    
    NSURL *modelURL = [self URLOfFileName:self.modelName withExtension:kModelNameExtension];
    
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
   
    return _managedObjectModel;
}

#pragma mark - private
- (NSURL *)applicationDocumentsDirectory {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSURL *)URLOfFileName:(NSString *)fileName withExtension:(NSString *)extension{
    return [[NSBundle bundleForClass:[self class]] URLForResource:fileName withExtension:extension];
}

- (void)dealWithLinkStoreError:(NSError *)error{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
    dict[NSLocalizedFailureReasonErrorKey] =  @"There was an error creating or loading the application's saved data.";
    dict[NSUnderlyingErrorKey] = error;
    error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
    NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
    abort();
}

#pragma mark - accessor

- (NSString *)modelName{
    if (_modelName) {
        return _modelName;
    }
    
    _modelName = TCTCoreDataModelName;
    return _modelName;
}

- (NSString *)storeFileName{
    if (_storeFileName) {
        return _storeFileName;
    }
    
    _storeFileName = TCTCoreDataStoreFileName;
    return _storeFileName;
}
@end
