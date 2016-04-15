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
/**  基本介绍
 * 数据定义语句（DDL:Data Definition Language）
 * 包括create和drop等操作
 * 在数据库中创新表或删除表（create table或drop table）
 
 * 数据操作语句（DML：Data Manipulation Language）
 * 包括insert、update、delete等操作
 * 上面的三种操作分别用于添加、修改、删除表中的数据
 * sqlite3_exec
 
 * 数据查询语句（DQL：Data Query Language）
 * 可以用于查询获得表中的数据
 * 关键字select是DQL（也是所有SQL）用的最多的操作
 * 常用关键字有 where、order by、group by和having
 * sqlite3_prepare_v2
 
 *  SQLite将数据划分为以下几种存储类型：
 *  integer：整型值
 *  real：浮点型
 *  text：文本字符串
 *  blob：二进制数据（比如文件）
 *
 */

/**  常用的语句
 *  插入数据（insert）  insert into 表名(字段1，字段2...)values(字段1的值，字段2的值...)  例 insert into t_person(name,age)values('fuzongjian',10)  字符串类型用单引号
 *  删除数据    delete from 表名  delete from t_person  将t_person表中的数据全部删除
 *  更新数据    
 *  更新一个字段 update t_person set name = 'fuzongxiang' where name = 'wangwu'
 *  更新对个字段，每个字之间用，分隔  update t_person set age = 20,height = 2.0 where name = 'zhangsan';
 *  取出数据  limit指令用于限制查询出来的结果数量
 *  第一个数值表示从那条记录开始（起始是 0） 第二个数值表示一次取多少条记录，如果要分页，通常第二个数值固定不变，表示每页需要显示的记录条数
    第一页
    select * from t_person limit 0, 3;
    第二页
    select * from t_person limit 3, 3;
    第三页
    select * from t_person limit 6, 3;
 
    查询排序  ASC升序（默认的排序方法） DESC降序
    Select * from t_person order by age ASC,id DESC;
 
    从数据库查出名字叫做wangwu的记录
    select * from t_person where name = 'wangwu';

    从数据库查出名字以wang开头的记录
    select * from t_person where name like 'wangwu%';
    从数据库查出名字中包含a的记录，通常用于模糊查询，建议不要搞太多字段组合模糊查询，那样性能会非常差！
    select * from t_person where name like '%a%';
 
 */
////**

/**
 *   获取文件路径
 */
+ (NSString *)getFilePath{
    static NSString * path = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString * doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        path = [doc stringByAppendingPathComponent:@"first.db"];
    });
    return path;
}
/**
 *  打开数据库
 */
+ (BOOL)openDataBase{
    int result = sqlite3_open([self getFilePath].UTF8String, &_db);
    if(result == SQLITE_OK){
        return  YES;
    }else{
        return NO;
    }
}
/**
 *  关闭数据库
 */
+ (void)cloesDataBase{
    sqlite3_close(_db);
}
/**
 *  创建数据库 /Users/chenshuao/Library/Developer/CoreSimulator/Devices/06CD8559-C701-481F-9515-CF652B6D459D/data/Containers/Data/Application/B7B1CDC4-3D45-45EF-A71B-ED82934A3737/Documents/first.db
 */
+ (void)createDataBase{
    if(![self openDataBase]) return;
    NSString * sql = [NSString stringWithFormat:@"create table if not exists t_person (id integer PRIMARY KEY AUTOINCREMENT,name text,age integer)"];
    char * errorMeg = NULL;
    int result = sqlite3_exec(_db, sql.UTF8String, NULL, NULL, &errorMeg);
    if(result == SQLITE_OK){
        [self cloesDataBase];
    }else{
        NSLog(@"fail---%s",errorMeg);
    }
}
/**
 * 插入数据
 */
+ (void)save:(Person *)perosn{
    if (![self openDataBase]) return;
    
    
/*------------------------------------------------------华丽的分割线1----------------------------------------------------------------*/
//    NSString * sql = [NSString stringWithFormat:@"insert into t_person (name, age) values ('%@',%d)",perosn.name,perosn.age];
//    char * errorMsg;
//    sqlite3_exec(_db, sql.UTF8String, NULL, NULL, &errorMsg);
//    if (errorMsg) {
//        NSLog(@"fail---%s",errorMsg);
//    }else{
//        
//    }
/*------------------------------------------------------华丽的分割线2----------------------------------------------------------------*/
    NSString * sql = [NSString stringWithFormat:@"insert into t_person (name, age) values (?,?)"];
    char * errorMeg;
    sqlite3_stmt * stmt;
    if (sqlite3_prepare_v2(_db, sql.UTF8String, -1, &stmt, nil) == SQLITE_OK) {
        sqlite3_bind_text(stmt, 1, perosn.name.UTF8String, -1, nil);
        sqlite3_bind_int(stmt, 2, perosn.age);
    }
    if (sqlite3_step(stmt) != SQLITE_DONE) {
         NSLog(@"fail---%s",errorMeg);
    }else{
         NSLog(@"success");
    }
    sqlite3_finalize(stmt);
    [self cloesDataBase];
}
/**
 * 更新数据
 */
+ (void)update:(Person *)person{
    if (![self openDataBase])return;
    NSString * sql = [NSString stringWithFormat:@"update t_person set age = %d where name = '%@'",person.age,person.name];
    char * errorMsg;
    if (sqlite3_exec(_db, sql.UTF8String, NULL, NULL, &errorMsg) == SQLITE_OK) {
        NSLog(@"success");
    }else{
        NSLog(@"fail");
    }
    [self cloesDataBase];
    
}
/**
 * 删除某一个
 */
+ (void)deletePerson:(Person *)person{
    if (![self openDataBase]) return;
    NSString * sql = [NSString stringWithFormat:@"delete from t_person where name = '%@'",person.name];
    char * errorMsg;
    if (sqlite3_exec(_db, sql.UTF8String, NULL, NULL, &errorMsg) == SQLITE_OK) {
        NSLog(@"success");
    }else{
        NSLog(@"fail");
    }
    [self cloesDataBase];
}
/**
 *  删除全部
 */
+ (void)deleteAll{
    if (![self openDataBase]) return;
    NSString * sql = [NSString stringWithFormat:@"delete from t_person"];
    char * errorMsg;
    if (sqlite3_exec(_db, sql.UTF8String, NULL, NULL, &errorMsg)) {
        NSLog(@"success");
    }else{
         NSLog(@"%s",errorMsg);
    }
    [self cloesDataBase];
}
/**
 *  获取所有数据
 */
+ (NSArray *)getAll{
    if (![self openDataBase]) {
        return nil;
    }
    NSMutableArray * array = [NSMutableArray array];
    
    //查询所有的数据                           select * from t_person
    //在这里可以设置分页查询数据                 select * from t_person limit 0, 3
    //在这里设置具体查询要求（具体）              select * from t_person where name = 'fuzongjian'
    //模糊查询                                select * from t_person where name like 'lisi%%'
    //将筛选的结果降序排列                      select * from t_person where age like '%%2%%' order by age DESC
    
    NSString * sql = [NSString stringWithFormat:@"select * from t_person where age like '%%2%%' order by age DESC"];
    sqlite3_stmt * stmt ;
    if (sqlite3_prepare_v2(_db, sql.UTF8String, -1, &stmt, nil) == SQLITE_OK) {
        //每调一次sqlite3_step函数，stmt就会指向下一条记录
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            //取数据
            //取出第0列字段的值（int类型的值）
            int ID = sqlite3_column_int(stmt, 0);
            //取出第1列字段的值（text类型的值）
            const unsigned char * name = sqlite3_column_text(stmt, 1);
            //取出第二列字段的值(int类型的值)
            int age = sqlite3_column_int(stmt, 2);
            //创建对象
            Person * person = [[Person alloc] init];
            person.ID = ID;
            person.name = [NSString stringWithUTF8String:(const char *)name];
            person.age = age;
            [array addObject:person];
        }
        sqlite3_finalize(stmt);
        NSLog(@"---success");
    }else{
        NSLog(@"fail");
    }
    [self cloesDataBase];
    return array;
}
+ (Person *)getSomeOneByName:(NSString *)name{
    Person * person = [[Person alloc] init];
    if (![self openDataBase]) {
        return nil;
    }
    NSString * sql = [NSString stringWithFormat:@"select * from t_person where name = 'lisis'"];
    sqlite3_stmt * stmt;
    if (sqlite3_prepare_v2(_db, sql.UTF8String, -1, &stmt, nil) == SQLITE_OK) {
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            //取数据
            //取出第0列字段的值（int类型的值）
            int ID = sqlite3_column_int(stmt, 0);
            //取出第1列字段的值（text类型的值）
            const unsigned char * name = sqlite3_column_text(stmt, 1);
            //取出第二列字段的值(int类型的值)
            int age = sqlite3_column_int(stmt, 2);
            person.name = [NSString stringWithUTF8String:(const char *)name];
            person.age = age;
        }
    }
    return person;
}
@end
