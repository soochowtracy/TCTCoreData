//
//  Book.m
//  TCTCoreDataHelper
//
//  Created by Tracy-One on 15/6/29.
//  Copyright (c) 2015年 Tracy-One. All rights reserved.
//

#import "Book.h"


@implementation Book

@dynamic title,pages;

+ (NSString *)entityName{
    return NSStringFromClass(self);
}
@end
