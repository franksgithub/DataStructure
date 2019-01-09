//
//  Heap.m
//  DataStructure
//
//  Created by Qiang on 2019/1/7.
//  Copyright © 2019 Qiang. All rights reserved.
//

#import "Heap.h"
#import "DijkstraGraph.h"

void swapArray(NSMutableArray *array, int i, int j) {
    id temp = array[i];
    array[i] = array[j];
    array[j] = temp;
}

void heapifyArray(NSMutableArray *a, int length, int i) {
    while (YES) {
        int maxPos = i;
        Vertex *v1 = a[i];
        Vertex *v2 = a[i*2];
        Vertex *vMax = a[maxPos];
        Vertex *v3 = a[i*2+1];
        if (i*2 <= length && v1.dist > v2.dist) {
            maxPos = i * 2;
        }
        if (i*2+1 <= length && vMax.dist > v3.dist) {
            maxPos = i * 2 + 1;
        }
        if (maxPos == i) {
            break;
        }
        swapArray(a, i, maxPos);
        i = maxPos;
    }
}

@interface Heap() {
    NSMutableArray *array;
    int _capicity;
    int count;
}

@end

@implementation Heap

- (instancetype)initWithCapicity:(int)capicity {
    self = [super init];
    if (self) {
        array = [NSMutableArray arrayWithCapacity:capicity];
        for (int i = 0; i <= capicity; i++) {
            array[i] = [NSNull null];
        }
        _capicity = capicity;
        count = 0;
    }
    return self;
}

- (void)insertData:(id)data {
    if (count >= _capicity) {
        return;
    }
    ++count;
    array[count] = data;
    int i = count;
    Vertex *v1 = array[i];
    Vertex *v2 = array[i/2];
    if (!([v1 isKindOfClass:[Vertex class]] && [v2 isKindOfClass:[Vertex class]])) {
        return;
    }
    while (i/2 > 0 && v1.dist < v2.dist)  {
        swapArray(array, i, i/2);
        i = i/2;
    }
}

- (id)removeTop {
    if (count == 0) {
        return nil;
    }
    id removedData = array[1];
    array[1] = array[count];
    --count;
    heapifyArray(array, count, 1);
    return removedData;
}

- (BOOL)isEmpty {
    return count == 0;
}

@end