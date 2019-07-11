//
//  SkipList.m
//  DataStructure
//
//  Created by Qiang on 2019/1/31.
//  Copyright © 2019 Qiang. All rights reserved.
//

#import "SkipList.h"

static const NSInteger kMaxLevel = 16;

NSInteger randomLevel() {
    NSInteger level = 1;
    for (int i = 0; i < kMaxLevel; i++) {
        if (random() % 2 == 1) {
            level++;
        }
    }
    return level;
}

BOOL obj_is_null(id obj) {
    return [obj isKindOfClass:[NSNull class]];
}

@implementation SNode

- (instancetype)init {
    self = [super init];
    if (self) {
        _data = -1;
        _maxLevel = 0;
        _forwards = [NSMutableArray arrayWithCapacity:kMaxLevel];
        for (int i = 0; i < kMaxLevel; i++) {
            _forwards[i] = [NSNull null];
        }
    }
    return self;
}

@end

@implementation SkipList {
    SNode *_head;
    NSInteger _levelCount;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _head = [SNode new];
        _levelCount = 1;
    }
    return self;
}

- (void)insert:(NSInteger)data {
    NSInteger level = randomLevel();
    SNode *aNode = [SNode new];
    aNode.data = data;
    aNode.maxLevel = level;
    NSMutableArray<SNode *> *updates = [NSMutableArray arrayWithCapacity:level];
    for (int i = 0; i < level; i++) {
        updates[i] = [NSNull null];
    }
    for (int i = 0; i < level; i++) {
        updates[i] = _head;
    }
    
    SNode *p = _head;
    for (int i = (int)level - 1; i >= 0; i--) {
        while (!obj_is_null(p.forwards[i]) && p.forwards[i].data < data) {
            p = p.forwards[i];
        }
        updates[i] = p;
    }
    
    for (int i = 0; i < level; i++) {
        aNode.forwards[i] = updates[i].forwards[i];
        updates[i].forwards[i] = aNode;
    }
    
    if (_levelCount < level) {
        _levelCount = level;
    }
}

- (SNode *)find:(NSInteger)data {
    SNode *p = _head;
    for (int i = (int)_levelCount - 1; i >= 0; i--) {
        while (!obj_is_null(p.forwards[i]) && p.forwards[i].data < data) {
            p = p.forwards[i];
        }
    }
    
    if (!obj_is_null(p.forwards[0]) && p.forwards[0].data == data) {
        return p.forwards[0];
    } else {
        return nil;
    }
}

- (void)delete:(NSInteger)data {
    NSMutableArray<SNode *> *updates = [NSMutableArray arrayWithCapacity:_levelCount];
    for (int i = 0; i < _levelCount; i++) {
        updates[i] = [NSNull null];
    }
    SNode *p = _head;
    for (int i = (int)_levelCount - 1; i >= 0; i--) {
        while (!obj_is_null(p.forwards[i]) && p.forwards[i].data < data) {
            p = p.forwards[i];
        }
        updates[i] = p;
    }
    
    if (!obj_is_null(p.forwards[0]) && p.forwards[0].data == data) {
        for (int i = (int)_levelCount - 1; i >= 0; i--) {
            if (!obj_is_null(updates[i].forwards[i]) && updates[i].forwards[i].data == data) {
                updates[i].forwards[i] = updates[i].forwards[i].forwards[i];
            }
        }
    }
}

@end
