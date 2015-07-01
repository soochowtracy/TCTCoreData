//
//  Person.m
//  TCTCoreDataHelper
//
//  Created by Tracy-One on 15/6/29.
//  Copyright (c) 2015年 Tracy-One. All rights reserved.
//

#import "Person.h"
#import "Book.h"


@implementation Person

@dynamic name;
@dynamic age;
@dynamic sex;
@dynamic books;

+ (NSString *)entityName{
    return NSStringFromClass(self);
}
@end
