//
//  Graph.h
//  DataStructure
//
//  Created by Qiang on 2018/12/3.
//  Copyright © 2018 Qiang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Graph : NSObject

- (instancetype)initWithVertexCount:(NSInteger)count;

- (void)addEdgeWithVertexA:(NSInteger)vertextA vertexB:(NSInteger)vertexB;

- (void)bfsWithStart:(NSInteger)start target:(NSInteger)target;

- (void)dfsWithStart:(NSInteger)start target:(NSInteger)target;

@end

NS_ASSUME_NONNULL_END
