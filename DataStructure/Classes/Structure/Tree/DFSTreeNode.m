//
//  TreeNode.m
//  DataStructure
//
//  Created by Qiang on 2019/1/9.
//  Copyright © 2019 Qiang. All rights reserved.
//

#import "DFSTreeNode.h"

@implementation DFSTreeNode

- (instancetype)initWithLabel:(char)label prefix:(NSString *)prefix exp:(NSString *)exp {
    self = [super init];
    if (self) {
        _label = label;
        self.prefix = prefix;
        self.explanation = exp;
        _sons = [NSMutableDictionary dictionary];
    }
    return self;
}

@end
