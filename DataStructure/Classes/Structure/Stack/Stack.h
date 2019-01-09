//
//  Stack.h
//  DataStructure
//
//  Created by Qiang on 2019/1/7.
//  Copyright © 2019 Qiang. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Stack : NSObject

- (instancetype)initWithCapacity:(int)capacity;

- (void)push:(int)ele;

- (int)pop;

- (BOOL)isEmpty;

@end

