//
//  AppDelegate.m
//  TCTCoreDataHelper
//
//  Created by Tracy-One on 15/6/26.
//  Copyright (c) 2015年 Tracy-One. All rights reserved.
//

#import "AppDelegate.h"
#import "Person.h"
#import "Book.h"

#import "TCTDatabaseHelper.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [TCTDatabaseHelper configureDatabaseWithSetting:^(DatabaseSettings *settings) {
        (*settings).modelName = "TCTCoreDataHelper";
        (*settings).storeFileName = "TCTCoreDataHelper";
        (*settings).storeType = TCTCoreDataStoreTypeSqlite;
    }];
    
    Person *person = [TCTDatabaseHelper createModelWithEntityName:[Person entityName]];
    Book *book = [TCTDatabaseHelper createModelWithEntityName:[Book entityName]];
    book.title = @"iOS";
//    book.pages = @(100);
    
    person.name = @"tracy";
    person.age = @21;
    person.sex = @"male";
    person.books = [NSSet setWithObjects:book, nil];
    
    [TCTDatabaseHelper saveContext];
    
    NSArray *persons = [TCTDatabaseHelper searchAllModelsWithEntityName:[Person entityName]];
    NSLog(@"persons:%li", persons.count);
    
    
    [TCTDatabaseHelper deleteAllModels:persons];
    [TCTDatabaseHelper saveContext];
    NSArray *persons1 = [TCTDatabaseHelper searchAllModelsWithEntityName:[Person entityName]];
    
    NSLog(@"persons:%li", persons.count);
    NSLog(@"persons1:%li", persons1.count);
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [TCTDatabaseHelper saveContext];
}

@end
