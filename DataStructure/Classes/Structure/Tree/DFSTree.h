//
//  DFSTree.h
//  DataStructure
//
//  Created by Qiang on 2019/1/9.
//  Copyright © 2019 Qiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DFSTreeNode.h"

@interface DFSTree : NSObject

- (void)dfsByStack;

- (void)buildTreeWithCString:(char *)cStr;

@end

