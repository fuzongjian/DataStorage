//
//  SQLite_Tool.m
//  DataStorage
//
//  Created by 陈舒澳 on 16/4/13.
//  Copyright © 2016年 xingbida. All rights reserved.
//

#import "SQLite_Tool.h"
 static sqlite3 * _db;
@implementation SQLite_Tool
+ (void)dataBase{
    //文件路径
    NSString * doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString * filename = [doc stringByAppendingPathComponent:@"first.db"];
     NSLog(@"%@",filename);
    //将OC字符串转成C字符串
    const char * Cfilename = filename.UTF8String;
    //打开数据库（如果数据库文件不存在，sqlite_open函数会自动创建数据库文件）
    int result = sqlite3_open(Cfilename, &_db);
    if (result == SQLITE_OK) {
        //创表              "CREATE TABLE IF NOT EXISTS t_person (id integer PRIMARY KEY AUTOINCREMENT, name text NOT NULL, age integer NOT NULL);"
        const char * sql = "CREATE TABLE IF NOT EXISTS t_person (id integer PRIMARY KEY AUTOINCREMENT, name text NOT NULL, age integer NOT NULL);";
        char * errorMeg = NULL;
        result = sqlite3_exec(_db, sql, NULL, NULL, &errorMeg);
        if (result == SQLITE_OK) {
            NSLog(@"创建表成功");
        }else{
            NSLog(@"创建表失败");
        }
    }else{
        NSLog(@"打开数据库失败");
    }
}
+ (void)save:(Person *)person{
    //拼接SQL语句
    NSString * sql = [NSString stringWithFormat:@"INSERT INTO t_person (name, age) VALUES ('%@', '%d')",person.name,person.age];
    //执行SQL语句
    char * errorMsg = NULL;
    sqlite3_exec(_db, sql.UTF8String, NULL, NULL, &errorMsg);
    if (errorMsg) {
         NSLog(@"fail---%s",errorMsg);
    }else{
        NSLog(@"success");
    }
}
@end
