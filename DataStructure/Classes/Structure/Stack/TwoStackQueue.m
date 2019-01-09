//
//  TwoStackQueue.m
//  DataStructure
//
//  Created by Qiang on 2019/1/7.
//  Copyright © 2019 Qiang. All rights reserved.
//

#import "TwoStackQueue.h"
#import "Stack.h"

@interface TwoStackQueue() {
    Stack *inStack;
    Stack *outStack;
}



@end

@implementation TwoStackQueue

- (instancetype)initWithCapacity:(int)capacity {
    self = [super init];
    if (self) {
        inStack = [[Stack alloc] initWithCapacity:capacity];
        outStack = [[Stack alloc] initWithCapacity:capacity];
    }
    return self;
}

- (void)enqueue:(int)ele {
    [inStack push:ele];
}

- (int)dequeue {
    if ([outStack isEmpty]) {
        while (![inStack isEmpty]) {
            [outStack push:[inStack pop]];
        }
    }
    return [outStack pop];
}

@end
