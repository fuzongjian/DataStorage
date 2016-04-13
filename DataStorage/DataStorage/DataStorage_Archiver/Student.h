//
//  Student.h
//  DataStorage
//
//  Created by 陈舒澳 on 16/4/13.
//  Copyright © 2016年 xingbida. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Student : NSObject <NSCoding>
@property (nonatomic,strong) NSString * name;
@property (nonatomic,strong) NSString * sex;
@property (nonatomic,assign) NSInteger  age;
@property (nonatomic,strong) NSString * hobby;
@end
