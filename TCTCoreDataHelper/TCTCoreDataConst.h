//
//  TCTCoreDataConst.h
//  TCTCoreDataHelper
//
//  Created by Tracy-One on 15/6/26.
//  Copyright (c) 2015年 Tracy-One. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, TCTCoreDataStoreType) {
    TCTCoreDataStoreTypeSqlite,
    TCTCoreDataStoreTypeInMemory,
    TCTCoreDataStoreTypeBinary
};

extern NSString * const TCTCoreDataModelName;
extern NSString * const TCTCoreDataStoreFileName;

