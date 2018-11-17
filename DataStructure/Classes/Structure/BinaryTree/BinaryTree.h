//
//  BinaryTree.h
//  DataStructure
//
//  Created by Qiang on 2018/11/12.
//  Copyright © 2018 Qiang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TreeNode : NSObject

@property (nonatomic, assign) NSInteger data;
@property (nonatomic, strong) TreeNode *left;
@property (nonatomic, strong) TreeNode *right;

+ (TreeNode *)treeNodeWithData:(NSInteger)data;

@end

@interface BinaryTree : NSObject

+ (void)preOrderVisit:(TreeNode *)tree;

+ (void)inOrderVisit:(TreeNode *)tree;

+ (void)postOrderVisit:(TreeNode *)tree;

@end

NS_ASSUME_NONNULL_END
