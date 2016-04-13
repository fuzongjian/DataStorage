//
//  Archiver_Test.m
//  DataStorage
//
//  Created by 陈舒澳 on 16/4/13.
//  Copyright © 2016年 xingbida. All rights reserved.
//

#import "Archiver_Test.h"
#import "Student.h"
@implementation Archiver_Test
/**
 *  可以存储自定义模型对象
 *  1.归档相对于polist存储而言，它可以直接存储自定义模型对象，而polist文件需要将模型转化为字典才可以存储自定义对象模型
 *  2.归档不能存储大批量数据（想比较Sqlite而言），存储数据到文件是将所有的数据一次性存储到文件中，从文件中读取数据也是一次性读取所有的数据
 *  弊端：增删改查的性能低
 */
+ (void)datastorage_archiver{
    NSMutableArray * array = [NSMutableArray array];
    NSArray * sexArray = [NSArray arrayWithObjects:@"男",@"女", nil];
    NSArray * hobbyArray = [NSArray arrayWithObjects:@"篮球",@"足球",@"乒乓球",@"橄榄球",@"棒球",@"羽毛球", nil];
    for (int i = 0; i < 100; i ++) {
        Student * student = [[Student alloc] init];
        if (i == 50) {
            student.age = 100;
            student.name = @"fuzongjian";
            student.hobby= @"健身";
            student.sex = @"男";
        }else{
            student.age = arc4random() % 20;
            student.name = [NSString stringWithFormat:@"我是%d号",i];
            student.sex = [sexArray objectAtIndex:arc4random() % 2];
            student.hobby = [hobbyArray objectAtIndex:arc4random() % 6];
        }
        [array addObject:student];
    }
    [NSKeyedArchiver archiveRootObject:array toFile:@"/Users/chenshuao/Desktop/student.txt"];
}
+ (void)datastorage_unarchiver{
    NSArray * array = [NSKeyedUnarchiver unarchiveObjectWithFile:@"/Users/chenshuao/Desktop/student.txt"];
    for (int i = 0 ; i < array.count; i ++ ) {
        Student * student = array[i];
         NSLog(@"%@ %d",student.hobby,i);
    }
}
@end
