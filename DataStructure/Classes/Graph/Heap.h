//
//  Heap.h
//  DataStructure
//
//  Created by Qiang on 2019/1/7.
//  Copyright © 2019 Qiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Heap<__covariant ObjectType> : NSObject

- (instancetype)initWithCapicity:(NSInteger)capicity;

- (void)insertData:(ObjectType)data;

- (ObjectType)removeTop;

- (BOOL)isEmpty;

@end
