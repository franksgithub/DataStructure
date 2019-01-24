//
//  DijkstraGraph.m
//  DataStructure
//
//  Created by Qiang on 2019/1/7.
//  Copyright © 2019 Qiang. All rights reserved.
//

#import "DijkstraGraph.h"
#import "Heap.h"

@interface DijkstraGraph()

@property (nonatomic, assign) NSInteger vertexCount;
@property (nonatomic, strong) NSMutableArray<NSMutableArray *> *vertexs;

@end

@implementation DijkstraGraph

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

- (void)addEdgeWithVertexA:(NSInteger)vertextA vertexB:(NSInteger)vertexB weight:(NSInteger)weight {
    Edge *edge = [[Edge alloc] initWithStart:vertextA target:vertexB weight:weight];
    [_vertexs[vertextA] addObject:edge];
}

void printPath(NSInteger start, NSInteger target, int predecessor[]) {
    if (start == target) {
        return;
    }
    printPath(start, predecessor[target], predecessor);
    NSLog(@"-> %ld", target);
}

- (void)dijkstraWithStart:(NSInteger)start target:(NSInteger)target {
    // 用来还原最短路径
    NSInteger predecessor[_vertexCount];
    for (int i = 0; i < _vertexCount; i++) {
        predecessor[i] = 0;
    }
    // 记录起始顶点到这个顶点的距离
    NSMutableArray *vertexes = [NSMutableArray arrayWithCapacity:_vertexCount];
    // 初始化 dist 为无穷大
    for (int i = 0; i < _vertexCount; i++) {
        vertexes[i] = [[Vertex alloc] initWithVId:i dist:INT_MAX];
    }
    // 小顶堆
    Heap<Vertex *> *queue = [[Heap alloc] initWithCapicity:_vertexCount];
    BOOL inQueue[_vertexCount];
    for (int i = 0; i < _vertexCount; i++) {
        inQueue[i] = NO;
    }
    [queue insertData:vertexes[start]];
    ((Vertex *)vertexes[start]).dist = 0;
    inQueue[start] = YES;
    while (![queue isEmpty]) {
        Vertex *minVertex = [queue removeTop];
        if (minVertex.vid == target) {
            break;
        }
        for (int i = 0; i < _vertexs[minVertex.vid].count; i++) {
            Edge *e = _vertexs[minVertex.vid][i];
            Vertex *nextVertex = vertexes[e.target];
            if (minVertex.dist + e.weight < nextVertex.dist) {
                nextVertex.dist = minVertex.dist + e.weight;
                predecessor[nextVertex.vid] = minVertex.vid;
                if (inQueue[nextVertex.vid] == NO) {
                    [queue insertData:nextVertex];
                    inQueue[nextVertex.vid] = YES;
                }
            }
        }
    }
    NSLog(@"-> %ld", start);
    printPath(start, target, predecessor);
}

@end

@implementation Edge

- (instancetype)initWithStart:(NSInteger)start target:(NSInteger)target weight:(NSInteger)weight {
    self = [super init];
    if (self) {
        _start = start;
        _target = target;
        _weight = weight;
    }
    return self;
}

@end

@implementation Vertex

- (instancetype)initWithVId:(NSInteger)vid dist:(NSInteger)dist {
    self = [super init];
    if (self) {
        _vid = vid;
        _dist = dist;
    }
    return self;
}

@end
