//
//  Stack.m
//  DataStructure
//
//  Created by Qiang on 2019/1/7.
//  Copyright © 2019 Qiang. All rights reserved.
//

#import "Stack.h"

@interface Stack() {
    int *items;
    int _capacity;
    int numOfEle;
}

@end

@implementation Stack

- (instancetype)initWithCapacity:(int)capacity {
    self = [super init];
    if (self) {
        //calloc会把新申请的空间清0
        items = calloc(capacity, sizeof(int));
        numOfEle = 0;
        _capacity = capacity;
    }
    return self;
}

- (void)dealloc {
    free(items);
}

- (void)push:(int)ele {
    if (numOfEle == _capacity) {
        NSLog(@"stack is full");
        return;
    }
    items[numOfEle++] = ele;
}

- (int)pop {
    if ([self isEmpty]) {
        NSLog(@"stack is empty");
        return -1;
    }
    return items[--numOfEle];
}

- (BOOL)isEmpty {
    return numOfEle == 0;
}

@end
