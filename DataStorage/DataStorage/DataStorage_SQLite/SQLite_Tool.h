//
//  SQLite_Tool.h
//  DataStorage
//
//  Created by 陈舒澳 on 16/4/13.
//  Copyright © 2016年 xingbida. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "Person.h"
@interface SQLite_Tool : NSObject
+ (void)createDataBase;
+ (void)save:(Person *)perosn;
+ (void)update:(Person *)person;
+ (void)deletePerson:(Person *)person;
+ (void)deleteAll;
+ (NSArray *)getAll;
+ (Person *)getSomeOneByName:(NSString *)name;
@end
