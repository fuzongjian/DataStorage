//
//  ViewController.m
//  DataStorage
//
//  Created by 陈舒澳 on 16/4/13.
//  Copyright © 2016年 xingbida. All rights reserved.
//

#import "ViewController.h"
#import "Archiver_Test.h"
#import "WriteToFile_Test.h"
#import "SQLite_Test.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [SQLite_Test sqlite_test];
    
//    [WriteToFile_Test writetofile_test];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [WriteToFile_Test readfromfile_test];
//    });
    
//    [Archiver_Test datastorage_archiver];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [Archiver_Test datastorage_unarchiver];
//    });
    // Do any additional setup after loading the view, typically from a nib.
}
#pragma mark --- NSUserDefaults 习惯将系统的偏好设置放在这里
/**
 *  数据保存在沙盒的  Library->Preferences文件夹下
 *  注意：NSUserDefaults设置数据是，不是立即写入，而是根据时间戳定时将缓存中的数据写入本地磁盘，so调用set方法之后数据有可能没有写入磁盘，应用就停止了，所以 通过synchronize强行写入
 */
- (void)datastorage_userdata{
    [[NSUserDefaults standardUserDefaults] setObject:@1 forKey:@"loginstate"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
