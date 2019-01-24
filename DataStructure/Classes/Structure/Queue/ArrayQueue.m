//
//  ArrayQueue.m
//  DataStructure
//
//  Created by Qiang on 2018/10/11.
//  Copyright © 2018 Qiang. All rights reserved.
//

#import "ArrayQueue.h"

@interface ArrayQueue() {
    int items[5];
    int n;
    int head;
    int tail;
}

@end

@implementation ArrayQueue

- (instancetype)initWithCapacity:(int)capacity {
    self = [super init];
    if (self) {
        n = capacity;
    }
    return self;
}

- (BOOL)enqueue:(int)item {
    if (tail == n) {
        if (head == 0) {
            return NO;
        }
        for (int i = head; i < tail; i++) {
            items[i-head] = items[i];
        }
        tail -= head;
        head = 0;
    }
    items[tail] = item;
    tail++;
    return YES;
}

- (int)dequeue {
    if (head == tail) {
        return -1;
    }
    int item = items[head];
    head++;
    return item;
}

- (void)showItems {
    for (int i = head; i < tail; i++ ) {
        NSLog(@"item %d : %d", i, items[i]);
    }
}

@end
