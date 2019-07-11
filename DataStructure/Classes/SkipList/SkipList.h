//
//  SkipList.h
//  DataStructure
//
//  Created by Qiang on 2019/1/31.
//  Copyright © 2019 Qiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SNode : NSObject

@property (nonatomic, assign) NSInteger data;
@property (nonatomic, strong) NSMutableArray<SNode *> *forwards;
@property (nonatomic, assign) NSInteger maxLevel;

@end

@interface SkipList : NSObject

- (void)insert:(NSInteger)data;

- (SNode *)find:(NSInteger)data;

- (void)delete:(NSInteger)data;

@end

