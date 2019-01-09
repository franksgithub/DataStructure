//
//  Graph.h
//  DataStructure
//
//  Created by Qiang on 2018/12/3.
//  Copyright © 2018 Qiang. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SortGraph : NSObject

- (instancetype)initWithVertexCount:(NSInteger)count;

- (void)addEdgeWithVertexA:(NSInteger)vertextA vertexB:(NSInteger)vertexB;

- (void)topoSortByKahn;

- (void)topoSortByDFS;

@end

