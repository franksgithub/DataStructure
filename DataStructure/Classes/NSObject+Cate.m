//
//  NSObject+Cate.m
//  DataStructure
//
//  Created by Qiang on 2019/5/29.
//  Copyright © 2019 Qiang. All rights reserved.
//

#import "NSObject+Cate.h"

@implementation NSObject (Cate)

- (void)say {
    NSLog(@"*********** %@ -- %s ***********", self, __PRETTY_FUNCTION__);
}

@end
