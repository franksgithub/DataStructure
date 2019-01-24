//
//  SimpleQueue.h
//  DataStructure
//
//  Created by Qiang on 2019/1/11.
//  Copyright © 2019 Qiang. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SimpleQueue<__covariant ObjectType> : NSObject

+ (instancetype)queue;

- (void)enqueue:(ObjectType)ele;

- (ObjectType)dequeue;

- (BOOL)isEmpty;

@end

