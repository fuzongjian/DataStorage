//
//  SQLite_Thread.m
//  DataStorage
//
//  Created by 陈舒澳 on 16/4/15.
//  Copyright © 2016年 xingbida. All rights reserved.
//

#import "SQLite_Thread.h"
static sqlite3 * _db;
@implementation SQLite_Thread
+ (NSString *)getFilePath{
    NSString * document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    return [document stringByAppendingPathComponent:@"second.db"];
}
+ (void)sqlite_thread{
    NSString * path = [self getFilePath];
     NSLog(@"%@",path);
/**
 *  配置线程模式， 单线程：SQLITE_CONFIG_SINGLETHREAD    多线程：SQLITE_CONFIG_MULTITHREAD    串行：SQLITE_CONFIG_SERIALIZED
 *  默认的是SQLite默认是多线程，多个线程同时使用同一个数据库连接对象，将会发生异常，所以open之前配置线程模式
 *
 */
    sqlite3_config(SQLITE_CONFIG_SERIALIZED);
    
    if (sqlite3_open(path.UTF8String, &_db) != SQLITE_OK) {
        NSLog(@"sqlite3_open===fail");
        return;
    }
    NSString * sql = [NSString stringWithFormat:@"create table if not exists t_people(id integer primary key autoincrement,name text,age integer)"];
    char * errorMsg;
    if (sqlite3_exec(_db, sql.UTF8String, NULL, NULL, &errorMsg) != SQLITE_OK) {
        sqlite3_close(_db);
        NSLog(@"创表===fail");
        return;
    }
    dispatch_queue_t  insertQueue = dispatch_queue_create("insertQueue", NULL);
    dispatch_async(insertQueue, ^{
        [self insert];
    });
    
    dispatch_queue_t  deleteQueue = dispatch_queue_create("deleteQueue", NULL);
    dispatch_async(deleteQueue, ^{
        [self delete];
    });
}
+ (void)insert{
    for (int i = 0; i < 100; i ++) {
        NSString * name = [NSString stringWithFormat:@"name===%d",3];
        NSInteger age = arc4random() % 50;
        NSString * sql = [NSString stringWithFormat:@"insert into t_people(name,age) values ('%@',%d);",name,age];
        char * errorMsg;
        if (sqlite3_exec(_db, sql.UTF8String, NULL, NULL, &errorMsg) != SQLITE_OK) {
            NSLog(@"insert===fail");
            return;
        }
    }
}
+ (void)delete{
    sqlite3_open([self getFilePath].UTF8String, &_db);
    NSString * sql = [NSString stringWithFormat:@"delete from t_people where name = 'name===3'"];
    char * errorMsg = NULL;
    if (sqlite3_exec(_db, sql.UTF8String, NULL, NULL, &errorMsg) != SQLITE_OK) {
        NSLog(@"delete===fail");
        return;
    }
}
@end
