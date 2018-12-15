//
//  Graph.m
//  DataStructure
//
//  Created by Qiang on 2018/12/3.
//  Copyright © 2018 Qiang. All rights reserved.
//

#import "Graph.h"

@interface Graph() {
    BOOL found;
}

@property (nonatomic, assign) NSInteger vertexCount;
@property (nonatomic, strong) NSMutableArray<NSMutableArray *> *vertexs;

@end

@implementation Graph

- (instancetype)initWithVertexCount:(NSInteger)count {
    self = [super init];
    if (self) {
        _vertexCount = count;
        _vertexs = [NSMutableArray arrayWithCapacity:_vertexCount];
        for (int i = 0; i < _vertexCount; i++) {
            _vertexs[i] = [NSMutableArray array];
        }
    }
    return self;
}

- (void)addEdgeWithVertexA:(NSInteger)vertexA vertexB:(NSInteger)vertexB {
    [_vertexs[vertexA] addObject:@(vertexB)];
    [_vertexs[vertexB] addObject:@(vertexA)];
}

- (void)bfsWithStart:(NSInteger)start target:(NSInteger)target {
    if (start == target) {
        return;
    }
    NSMutableArray<NSNumber *> *visited = [NSMutableArray arrayWithCapacity:_vertexCount];
    for (int i = 0; i < _vertexCount; i++) {
        visited[i] = @(NO);
    }
    visited[start] = @(YES);
    NSMutableArray<NSNumber *> *queue = [NSMutableArray array];
    [queue addObject:@(start)];
    NSMutableArray<NSNumber *> *prev = [NSMutableArray arrayWithCapacity:_vertexCount];
    for (int i = 0; i < _vertexCount; i++) {
        prev[i] = @(-1);
    }
    while (queue.count > 0) {
        NSInteger vertex = [queue.firstObject integerValue];
        [queue removeObjectAtIndex:0];
        NSInteger linkSize = [_vertexs[vertex] count];
        for (int i = 0; i < linkSize; i++) {
            NSInteger linkVertex = [_vertexs[vertex][i] integerValue];
            if (![visited[linkVertex] boolValue]) {
                prev[linkVertex] = @(vertex);
                if (linkVertex == target) {
                    [self printVisitedPathInArray:prev start:start target:target];
                    return;
                }
                visited[linkVertex] = @(YES);
                [queue addObject:@(linkVertex)];
            }
        }
    }
}

- (void)printVisitedPathInArray:(NSArray *)prev start:(NSInteger)start target:(NSInteger)target {
    if ([prev[target] integerValue] != -1 && start != target) {
        [self printVisitedPathInArray:prev start:start target:[prev[target] integerValue]];
    }
    NSLog(@"%ld", (long)target);
}

- (void)dfsWithStart:(NSInteger)start target:(NSInteger)target {
    found = NO;
    NSMutableArray<NSNumber *> *visited = [NSMutableArray arrayWithCapacity:_vertexCount];
    for (int i = 0; i < _vertexCount; i++) {
        visited[i] = @(NO);
    }
    NSMutableArray<NSNumber *> *prev = [NSMutableArray arrayWithCapacity:_vertexCount];
    for (int i = 0; i < _vertexCount; i++) {
        prev[i] = @(-1);
    }
    [self recurDfsWithStart:start target:target visited:visited prev:prev];
    [self printVisitedPathInArray:prev start:start target:target];
}

- (void)recurDfsWithStart:(NSInteger)start target:(NSInteger)target visited:(NSMutableArray *)visited prev:(NSMutableArray *)prev {
    if (found) {
        return;
    }
    visited[start] = @(YES);
    if (start == target) {
        found = YES;
        return;
    }
    NSInteger linkSize = [_vertexs[start] count];
    for (int i = 0; i < linkSize; i++) {
        NSInteger linkVertex = [_vertexs[start][i] integerValue];
        if (![visited[linkVertex] boolValue]) {
            prev[linkVertex] = @(start);
            [self recurDfsWithStart:linkVertex target:target visited:visited prev:prev];
        }
    }
}

@end
