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
//    [SQLite_Tool dataBase];
//
    
//    [SQLite_Tool createDataBase];
//    /[SQLite_Tool getAll];
    
//    for (Person * person in [SQLite_Tool getAll]) {
//         NSLog(@"%d",person.age);
//    }
    
    Person * person = [SQLite_Tool getSomeOneByName:@"lisis"];
    NSLog(@"%@---%d",person.name,person.age);
    
//    for (int i = 0; i < 10; i ++) {
//        Person * person = [[Person alloc] init];
//        person.age = arc4random() % 20;
//        person.name = @"fuzongjian";
//        [SQLite_Tool save:person];
//    }
    
//    Person * person = [[Person alloc] init];
//    person.name = @"lisis";
//    person.age = 929;
//    [SQLite_Tool save:person];

//    [SQLite_Tool deleteAll];
    
    
// 
//    for (Person * person in  [SQLite_Tool getAll]) {
//         NSLog(@"%@--%d",person.name,person.age);
//    }
}
@end
