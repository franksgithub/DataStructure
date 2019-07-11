//
//  Producer.h
//  DataStructure
//
//  Created by Qiang on 2019/1/30.
//  Copyright © 2019 Qiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Queue : NSObject

- (instancetype)initWithCapicity:(NSInteger)capicity;

- (BOOL)addData:(NSInteger)data;

- (NSInteger)poll;

@end

@interface Producer : NSObject

- (instancetype)initWithQueue:(Queue *)queue;

- (void)produce:(NSInteger)data;

@end

@interface Consumer : NSObject

- (instancetype)initWithQueue:(Queue *)queue;
- (void)consume;

@end


