//
//  SimpleStack.m
//  DataStructure
//
//  Created by Qiang on 2019/1/10.
//  Copyright © 2019 Qiang. All rights reserved.
//

#import "SimpleStack.h"

@interface SimpleStack<__covariant ObjectType>()

@property (nonatomic, strong) NSMutableArray *container;

@end

@implementation SimpleStack

+ (instancetype)stack {
    return [[self alloc] init];
}

+ (instancetype)stackWithCapacity:(NSInteger)capacity {
    return [[self alloc] initWithCapacity:capacity];
}

- (instancetype)initWithCapacity:(NSInteger)capacity {
    self = [super init];
    if (self) {
        _container = [NSMutableArray arrayWithCapacity:capacity];
    }
    return self;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _container = [NSMutableArray array];
    }
    return self;
}

- (void)push:(id)obj {
    [_container addObject:obj];
}

- (id)pop {
    id obj = _container.lastObject;
    [_container removeLastObject];
    return obj;
}

- (BOOL)isEmpty {
    return _container.count == 0;
}

@end
