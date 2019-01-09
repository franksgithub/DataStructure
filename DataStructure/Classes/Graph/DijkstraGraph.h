//
//  DijkstraGraph.h
//  DataStructure
//
//  Created by Qiang on 2019/1/7.
//  Copyright © 2019 Qiang. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface DijkstraGraph : NSObject

- (instancetype)initWithVertexCount:(NSInteger)count;

- (void)addEdgeWithVertexA:(NSInteger)vertextA vertexB:(NSInteger)vertexB weight:(NSInteger)weight;

- (void)dijkstraWithStart:(NSInteger)start target:(NSInteger)target;

@end

@interface Edge : NSObject

@property (nonatomic, assign) NSInteger start;
@property (nonatomic, assign) NSInteger target;
@property (nonatomic, assign) NSInteger weight;

- (instancetype)initWithStart:(NSInteger)start target:(NSInteger)target weight:(NSInteger)weight;

@end

@interface Vertex : NSObject

@property (nonatomic, assign) NSInteger vid;
@property (nonatomic, assign) NSInteger dist;

- (instancetype)initWithVId:(NSInteger)vid dist:(NSInteger)dist;

@end
