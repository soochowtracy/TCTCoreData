//
//  TCTCoreDataManager.h
//  TCTravel_IPhone
//
//  Created by Tracyone on 15/4/24.
//
//

#import <Foundation/Foundation.h>

@interface TCTCoreDataManager : NSObject

@property (readonly, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (copy, nonatomic) NSString *databaseName;
@property (copy, nonatomic) NSString *modelName;

+ (instancetype)sharedManager;
- (BOOL)saveContext;
@end



@interface TCTCoreDataManager (TCTExtendedCoreDataManager)

- (NSURL *)applicationDocumentsDirectory;
- (NSURL *)sqliteStoreURL;
- (void)copyDefaultStoreIfNeeded:(NSURL *)url;
- (void)createApplicationSupportDirIfNeeded:(NSURL *)url;

@end