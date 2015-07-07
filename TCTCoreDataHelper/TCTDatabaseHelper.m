//
//  TCTDatabaseHelper.m
//  TCTCoreDataHelper
//
//  Created by Tracy-One on 15/6/29.
//  Copyright (c) 2015年 Tracy-One. All rights reserved.
//

#import "TCTDatabaseHelper.h"
#import "TCTCoreData.h"

@implementation TCTDatabaseHelper

+ (void)configureDatabaseWithSetting:(TCTDatabaseSettingsBlock)setting{
    DatabaseSettings settings;
    setting(&settings);
    
    [TCTCoreData defaultCoreData].modelName = [NSString stringWithUTF8String:settings.modelName];
    [TCTCoreData defaultCoreData].storeFileName = [NSString stringWithUTF8String:settings.storeFileName];
    [TCTCoreData defaultCoreData].storeType = settings.storeType;
}

+ (NSArray *)searchAllModelsWithEntityName:(NSString *)entityName{
    return [self searchModelsWithEntityName:entityName predicate:nil sorts:nil];
}

+ (NSArray *)searchModelsWithEntityName:(NSString *)entityName predicate:(NSPredicate *)predicate sorts:(NSArray *)sorts{
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:entityName];
    request.predicate = predicate;
    request.sortDescriptors = sorts;
    
    NSError *error;
    NSArray* objects = [[TCTCoreData defaultCoreData].managedObjectMainContext executeFetchRequest:request error:&error];
    
    if (!objects) {
        NSLog(@"%@", error.description);
    }
    return objects;
}

+ (id)createModelWithEntityName:(NSString *)entityName{
    id obejct = [NSEntityDescription insertNewObjectForEntityForName:entityName inManagedObjectContext:[TCTCoreData defaultCoreData].managedObjectMainContext];
    
    return obejct;
}

+ (void)deleteAllModels:(NSArray *)models{
    [models enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [[TCTCoreData defaultCoreData].managedObjectMainContext deleteObject:obj];
    }];
}

+ (BOOL)saveContext {
    if ([TCTCoreData defaultCoreData].managedObjectMainContext == nil) {
        return NO;
    }
    if (![[TCTCoreData defaultCoreData].managedObjectMainContext hasChanges]){
        return NO;
    }
    
    NSError *error = nil;
    
    if (![[TCTCoreData defaultCoreData].managedObjectMainContext save:&error]) {
        NSLog(@"Unresolved error in saving context! %@, %@", error, [error userInfo]);
        return NO;
    }
    
    return YES;
}
@end
