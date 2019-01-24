//
//  SimpleStack.h
//  DataStructure
//
//  Created by Qiang on 2019/1/10.
//  Copyright © 2019 Qiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SimpleStack<__covariant ObjectType> : NSObject

+ (instancetype)stack;

+ (instancetype)stackWithCapacity:(NSInteger)capacity;

- (instancetype)initWithCapacity:(NSInteger)capacity;

- (void)push:(ObjectType)obj;

- (ObjectType)pop;

- (BOOL)isEmpty;

@end

