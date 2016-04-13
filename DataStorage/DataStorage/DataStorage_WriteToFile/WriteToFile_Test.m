//
//  WriteToFile_Test.m
//  DataStorage
//
//  Created by 陈舒澳 on 16/4/13.
//  Copyright © 2016年 xingbida. All rights reserved.
//
///Users/chenshuao/Desktop/student.txt
#import "WriteToFile_Test.h"

@implementation WriteToFile_Test
/**
 *  只能存储OC常用数据类型，NSString、NSDictionary、NSArray、NSData、NSNumber、NSDate、Boolean
 *  polist 只能识别字典和数组
 */
+ (void)writetofile_test{
    NSArray * array = [NSArray arrayWithObjects:@"fu",@"zong",@"jian", nil];
    [array writeToFile:@"Users/chenshuao/Desktop/write.polist" atomically:YES];
}
+ (void)readfromfile_test{
    NSArray * array =[NSArray arrayWithContentsOfFile:@"Users/chenshuao/Desktop/write.polist"];
     NSLog(@"%@",[array firstObject]);
}
@end
