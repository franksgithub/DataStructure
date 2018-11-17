//
//  CircleQueue.m
//  DataStructure
//
//  Created by Qiang on 2018/10/11.
//  Copyright © 2018 Qiang. All rights reserved.
//

#import "CircleQueue.h"

@interface CircleQueue() {
    int items[6];
    int n;
    int head;
    int tail;
}

@end

@implementation CircleQueue

- (instancetype)initWithCapacity:(int)capacity {
    self = [super init];
    if (self) {
        n = capacity;
    }
    return self;
}

- (BOOL)enqueue:(int)item {
    //full
    if ((tail + 1) % n == head) {
        return false;
    }
    items[tail] = item;
    tail = (tail + 1) % n;
    return YES;
}

- (int)dequeue {
    if (head == tail) {
        return -1;
    }
    int item = items[head];
    head = (head + 1) % n;
    return item;
}

- (void)showItems {
    if (tail < head) {
        for (int i = head; i < n; i++ ) {
            NSLog(@"item %d : %d", i, items[i]);
        }
        for (int i = 0; i < tail; i++ ) {
            NSLog(@"item %d : %d", i, items[i]);
        }
    } else {
        for (int i = head; i < tail; i++ ) {
            NSLog(@"item %d : %d", i, items[i]);
        }
    }
}

@end
