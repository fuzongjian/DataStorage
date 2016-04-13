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
+ (void)dataBase;
+ (void)save:(Person *)person;
@end
