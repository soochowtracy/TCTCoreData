//
//  TCTCoreData.h
//  TCTCoreDataHelper
//
//  Created by Tracy-One on 15/6/26.
//  Copyright (c) 2015年 Tracy-One. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "TCTCoreDataConst.h"

@interface TCTCoreData : NSObject

+ (instancetype)defaultCoreData;

@property (nonatomic, copy) NSString *modelName;
@property (nonatomic, copy) NSString *storeFileName;
@property (nonatomic, assign) TCTCoreDataStoreType storeType;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectMainContext;

@end
