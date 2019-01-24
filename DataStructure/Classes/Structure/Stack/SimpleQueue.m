//
//  SimpleQueue.m
//  DataStructure
//
//  Created by Qiang on 2019/1/11.
//  Copyright © 2019 Qiang. All rights reserved.
//

#import "SimpleQueue.h"

@interface SimpleQueue()

@property (nonatomic, strong) NSMutableArray *queue;

@end

@implementation SimpleQueue

+ (instancetype)queue {
    return [[self alloc] init];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _queue = [NSMutableArray array];
    }
    return self;
}

- (void)enqueue:(id)ele {
    [_queue addObject:ele];
}

- (id)dequeue {
    id ele = [_queue lastObject];
    [_queue removeLastObject];
    return ele;
}

- (BOOL)isEmpty {
    return _queue.count == 0;
}

@end
