//
//  TCTDatabaseHelper.h
//  TCTCoreDataHelper
//
//  Created by Tracy-One on 15/6/29.
//  Copyright (c) 2015年 Tracy-One. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TCTCoreDataConst.h"

typedef struct databaseSettings {
    char *modelName;
    char *storeFileName;
    TCTCoreDataStoreType storeType;
}DatabaseSettings;

typedef void(^TCTDatabaseSettingsBlock)(DatabaseSettings *settings);

@interface TCTDatabaseHelper : NSObject

+ (void)configureDatabaseWithSetting:(TCTDatabaseSettingsBlock)setting;

+ (NSArray *)searchAllModelsWithEntityName:(NSString *)entityName;
+ (NSArray *)searchModelsWithEntityName:(NSString *)entityName predicate:(NSPredicate *)predicate sorts:(NSArray *)sorts;

+ (void)deleteAllModels:(NSArray *)models;
+ (id)createModelWithEntityName:(NSString *)entityName;
+ (BOOL)saveContext;

@end
