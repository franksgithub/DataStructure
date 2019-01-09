//
//  HeapSort.h
//  DataStructure
//
//  Created by Qiang on 2018/11/26.
//  Copyright © 2018 Qiang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

void heap_sort(int a[], int length);

void buildHeap(int a[], int length);

@interface HeapSort : NSObject

- (instancetype)initWithCapicity:(int)capicity;

- (void)insertData:(int)data;

- (int)removeTop;

@end

NS_ASSUME_NONNULL_END
