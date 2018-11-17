//
//  LinkListQueue.m
//  DataStructure
//
//  Created by Qiang on 2018/10/11.
//  Copyright © 2018 Qiang. All rights reserved.
//

#import "LinkListQueue.h"

@interface Node : NSObject

@property (nonatomic, assign) int item;
@property (nonatomic, strong) Node *next;

@end

@implementation Node

@end

@interface LinkListQueue() {
    int _capacity;
    int _count;
    Node *head;
    Node *tail;
}

@end

@implementation LinkListQueue

- (instancetype)initWithCapacity:(int)capacity {
    self = [super init];
    if (self) {
        _capacity = capacity;
    }
    return self;
}

- (BOOL)enqueue:(int)item {
    if (_capacity == _count) {
        return NO;
    }
    Node *node = [Node new];
    node.item = item;
    if (head == nil && tail == nil) {
        head = tail = node;
    } else {
        tail.next = node;
        tail = tail.next;
    }
    _count++;
    return YES;
}

- (int)dequeue {
    if (head != nil && head == tail) {
        return -1;
    }
    int item = head.item;
    head = head.next;
    _count--;
    return item;
}

- (void)showItems {
    Node *node = head;
    while (node) {
        NSLog(@"item : %d", node.item);
        node = node.next;
    }
}

@end
