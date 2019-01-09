//
//  Graph.m
//  DataStructure
//
//  Created by Qiang on 2018/12/3.
//  Copyright © 2018 Qiang. All rights reserved.
//

#import "SortGraph.h"

void dfsVisit(NSInteger vertex, NSArray *inverseItems, BOOL visited[]) {
    for (int i = 0; i < [inverseItems[vertex] count]; i++) {
        NSInteger tempV = [inverseItems[vertex][i] integerValue];
        if (visited[tempV]) {
            continue;
        }
        visited[tempV] = YES;
        dfsVisit(tempV, inverseItems, visited);
    }
    NSLog(@"-> %ld", vertex);
}


@interface SortGraph() {
    BOOL found;
}

@property (nonatomic, assign) NSInteger vertexCount;
@property (nonatomic, strong) NSMutableArray<NSMutableArray *> *vertexs;

@end

@implementation SortGraph

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
}

- (void)topoSortByKahn {
    int inDegree[_vertexCount];
    //初始化inDegree, inDegree的初始值需要注意一下
    for (int i = 0; i < _vertexCount; i++) {
        if (_vertexs[i].count > 0) {
            inDegree[i] = 0;
        } else {
            inDegree[i] = -1;
        }
    }
    for (int i = 0; i < _vertexCount; i++) {
        NSInteger linkSize = [_vertexs[i] count];
        for (int j = 0; j < linkSize; j++) {
            NSInteger linkVertex = [_vertexs[i][j] integerValue];
            //不加此判断会出问题
            if (inDegree[linkVertex] < 0) {
                inDegree[linkVertex] = 0;
            }
            inDegree[linkVertex]++;
        }
    }
    NSMutableArray<NSNumber *> *queue = [NSMutableArray array];
    for (int i = 0; i < _vertexCount; i++) {
        if (inDegree[i] == 0) {
            [queue addObject:@(i)];
        }
    }
    while (queue.count > 0) {
        NSInteger vertex = [queue.firstObject integerValue];
        [queue removeObjectAtIndex:0];
        NSLog(@"-> %ld ", (long)vertex);
        for (int j = 0; j < _vertexs[vertex].count; j++) {
            NSInteger linkVertex = [_vertexs[vertex][j] integerValue];
            inDegree[linkVertex]--;
            if (inDegree[linkVertex] == 0) {
                [queue addObject:@(linkVertex)];
            }
        }
    }
}

- (void)topoSortByDFS {
    NSMutableArray *inverseItems = [NSMutableArray arrayWithCapacity:_vertexCount];
    for (int i = 0; i < _vertexCount; i++) {
        inverseItems[i] = [NSMutableArray array];
    }
    for (int i = 0; i < _vertexCount; i++) {
        for (int j = 0; j < _vertexs[i].count; j++) {
            NSInteger vertex = [_vertexs[i][j] integerValue];
            [inverseItems[vertex] addObject:@(i)];
        }
    }
    BOOL visited[_vertexCount];
    for (int i = 0; i < _vertexCount; i++) {
        visited[i] = NO;
    }
    for (int i = 0; i < _vertexCount; i++) {
        if (visited[i] == NO) {
            visited[i] = YES;
            dfsVisit(i, inverseItems, visited);
        }
    }
}


@end

