//
//  Student.m
//  DataStorage
//
//  Created by 陈舒澳 on 16/4/13.
//  Copyright © 2016年 xingbida. All rights reserved.
//

#import "Student.h"
#import <objc/runtime.h>
@implementation Student
//利用runtime机制进行归档反归档

/**
 * 当一个对象要归档的时候就会调用这个方法接档
 * 当前那些属性需要解档
 */
-(id)initWithCoder:(NSCoder *)aDecoder{//解档
    if (self = [super init]) {
        unsigned int outCount;
        Ivar * ivars = class_copyIvarList([self class], &outCount);
        for (int i = 0; i < outCount; i ++) {
            Ivar ivar = ivars[i];
            NSString * key = [NSString stringWithUTF8String:ivar_getName(ivar)];
            [self setValue:[aDecoder decodeObjectForKey:key] forKey:key];
        }
    }
    return self;
}
/**
 * 当一个对象要归档的时候就会调用这个方法归档
 * 当前那些属性需要归档
 */
-(void)encodeWithCoder:(NSCoder *)aCoder{//归档
    
    unsigned int outCount;
    Ivar * ivars = class_copyIvarList([self class], &outCount);
    for (int i = 0; i < outCount; i ++) {
        Ivar ivar = ivars[i];
        NSString * key = [NSString stringWithUTF8String:ivar_getName(ivar)];
        [aCoder encodeObject:[self valueForKey:key] forKey:key];
    }
}
@end
