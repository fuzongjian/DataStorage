//
//  SQLite_Test.m
//  DataStorage
//
//  Created by 陈舒澳 on 16/4/13.
//  Copyright © 2016年 xingbida. All rights reserved.
//

#import "SQLite_Test.h"
#import "SQLite_Tool.h"
#import "Person.h"
@implementation SQLite_Test
+ (void)sqlite_test{
    [SQLite_Tool dataBase];
   
    for (int i = 0; i < 10; i ++) {
        Person * person = [[Person alloc] init];
//        person.age = arc4random() % 20;
//        person.name = @"fuzongjian";
        [SQLite_Tool save:person];
    }
}
@end
