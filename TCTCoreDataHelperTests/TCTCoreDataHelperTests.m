//
//  TCTCoreDataHelperTests.m
//  TCTCoreDataHelperTests
//
//  Created by Tracy-One on 15/6/26.
//  Copyright (c) 2015年 Tracy-One. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "TCTDatabaseHelper.h"
#import "Person.h"
#import "Book.h"

@interface TCTCoreDataHelperTests : XCTestCase

@end

@implementation TCTCoreDataHelperTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    [TCTDatabaseHelper configureDatabaseWithSetting:^(DatabaseSettings *settings) {
        (*settings).modelName = "TCTCoreDataHelper";
        (*settings).storeFileName = "TCTCoreDataHelper";
        (*settings).storeType = TCTCoreDataStoreTypeSqlite;
    }];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    
    [super tearDown];
}


- (void)testCreate{
    Person *person = [TCTDatabaseHelper createModelWithEntityName:[Person entityName]];
    Book *book = [TCTDatabaseHelper createModelWithEntityName:[Book entityName]];
    book.title = @"iOS";
    
    person.name = @"tracy";
    person.age = @21;
    person.sex = @"male";
    person.books = [NSSet setWithObjects:book, nil];
    
    [TCTDatabaseHelper saveContext];
    
    NSArray *persons = [TCTDatabaseHelper searchAllModelsWithEntityName:[Person entityName]];
    XCTAssertGreaterThan(persons.count, 0);
    XCTAssertEqual([persons[0] name], @"tracy");
    
}

- (void)testSearch{
    [self testCreate];
    
    
}

- (void)testExample {
    // This is an example of a functional test case.
    XCTAssert(YES, @"Pass");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
