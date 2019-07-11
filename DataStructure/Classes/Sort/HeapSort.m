//
//  HeapSort.m
//  DataStructure
//
//  Created by Qiang on 2018/11/26.
//  Copyright © 2018 Qiang. All rights reserved.
//

#import "HeapSort.h"
#import "AllSort.h"

//自上往下堆化
void heapify1(int a[], int length, int i) {
    while (YES) {
        int maxPos = i;
        if (i*2 <= length && a[i] < a[i*2]) {
            maxPos = i * 2;
        }
        if (i*2+1 <= length && a[maxPos] < a[i*2+1]) {
            maxPos = i * 2 + 1;
        }
        if (maxPos == i) {
            break;
        }
        swap(a, i, maxPos);
        i = maxPos;
    }
}

@interface HeapSort() {
    int *array;
    int _capicity;
    int count;
}

@end

@implementation HeapSort

- (instancetype)initWithCapicity:(int)capicity {
    self = [super init];
    if (self) {
        array = malloc(sizeof(int) * (capicity + 1));
        _capicity = capicity;
        count = 0;
    }
    return self;
}

- (void)insertData:(int)data {
    if (count >= _capicity) {
        return;
    }
    ++count;
    array[count] = data;
    int i = count;
    while (i/2 > 0 && array[i] > array[i/2])  {
        swap(array, i, i/2);
        i = i/2;
    }
}

- (int)removeTop {
    if (count == 0) {
        return -1;
    }
    int removedData = array[1];
    array[1] = array[count];
    --count;
    heapify1(array, count, 1);
    return removedData;
}

@end

void buildHeap(int a[], int length) {
    for (int i = length / 2; i >= 1; --i) {
        heapify1(a, length, i);
    }
}

void heap_sort(int a[], int length) {
    buildHeap(a, length);
    int k = length;
    while (k > 1) {
        swap(a, 1, k);
        --k;
        heapify1(a, k, 1);
    }
}

























