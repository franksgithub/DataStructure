//
//  Producer.m
//  DataStructure
//
//  Created by Qiang on 2019/1/30.
//  Copyright © 2019 Qiang. All rights reserved.
//

#import "Producer.h"

static const NSInteger kNULLData = -1;

@implementation Producer {
    Queue *_queue;
}

- (instancetype)initWithQueue:(Queue *)queue {
    self = [super init];
    if (self) {
        _queue = queue;
    }
    return self;
}

- (void)produce:(NSInteger)data {
    while (![_queue addData:data++]) {
        sleep(1);
    }
}

@end

@implementation Consumer {
    Queue *_queue;
}

- (instancetype)initWithQueue:(Queue *)queue {
    self = [super init];
    if (self) {
        _queue = queue;
    }
    return self;
}

- (void)consume {
    while (YES) {
        NSInteger data = [_queue poll];
        if (data == kNULLData) {
            sleep(1);
        } else {
            NSLog(@"the real data : %ld", data);
        }
    }
}

@end

@implementation Queue {
    NSMutableArray<NSNumber *> *_datas;
    NSInteger _size, _head, _tail;
}

- (instancetype)initWithCapicity:(NSInteger)capicity {
    self = [super init];
    if (self) {
        _datas = [NSMutableArray arrayWithCapacity:capicity];
        _size = _head = _tail = 0;
    }
    return self;
}

- (BOOL)addData:(NSInteger)data {
    if ((_tail + 1) % _size == _head) {
        return NO;
    }
    _datas[_tail] = @(data);
    _tail = (_tail + 1) % _size;
    return YES;
}

- (NSInteger)poll {
    if (_head == _tail) {
        return -1;
    }
    NSInteger data = [_datas[_head] integerValue];
    _head = (_head + 1) % _size;
    return data;
}

@end
