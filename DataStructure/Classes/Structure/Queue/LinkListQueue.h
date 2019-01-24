//
//  LinkListQueue.h
//  DataStructure
//
//  Created by Qiang on 2018/10/11.
//  Copyright © 2018 Qiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LinkListQueue : NSObject

- (instancetype)initWithCapacity:(int)capacity;

- (BOOL)enqueue:(int)item;

- (int)dequeue;

- (void)showItems;

@end
