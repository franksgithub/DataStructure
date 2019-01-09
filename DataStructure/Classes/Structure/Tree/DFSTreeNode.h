//
//  TreeNode.h
//  DataStructure
//
//  Created by Qiang on 2019/1/9.
//  Copyright © 2019 Qiang. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * @Description: 前缀树的结点
 *
 */
/*
public class TreeNode {
    
    public char label;  // 结点的名称，在前缀树里是单个字母
    public HashMap<Character, TreeNode> sons = null; // 使用哈希映射存放子结点。哈希便于确认是否已经添加过某个字母对应的结点。
    public String prefix = null;   // 从树的根到当前结点这条通路上，全部字母所组成的前缀。例如通路 b->o->y，对于字母 o 结点而言，前缀是 b；对于字母 y 结点而言，前缀是 bo
    public String explanation = null;  // 词条的解释
    
    // 初始化结点
    public TreeNode(char l, String pre, String exp) {
        label = l;
        prefix = pre;
        explanation = exp;
        sons = new HashMap<>();
        
    }
}
 */


@interface DFSTreeNode : NSObject

@property (nonatomic, assign) char label;
@property (nonatomic, strong) NSMutableDictionary<NSString *, DFSTreeNode *> *sons;
@property (nonatomic, copy) NSString *prefix;
@property (nonatomic, copy) NSString *explanation;

- (instancetype)initWithLabel:(char)label prefix:(NSString *)prefix exp:(NSString *)exp;

@end

