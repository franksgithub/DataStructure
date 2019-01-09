//
//  TwoStackQueue.h
//  DataStructure
//
//  Created by Qiang on 2019/1/7.
//  Copyright © 2019 Qiang. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface TwoStackQueue : NSObject

- (instancetype)initWithCapacity:(int)capacity;

- (void)enqueue:(int)ele;

- (int)dequeue;

@end

