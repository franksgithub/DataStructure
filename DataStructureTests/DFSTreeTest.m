//
//  DFSTreeTest.m
//  DataStructureTests
//
//  Created by Qiang on 2019/1/9.
//  Copyright © 2019 Qiang. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "DFSTree.h"
#import "DFSTreeNode.h"

@interface DFSTreeTest : XCTestCase

@end

@implementation DFSTreeTest

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testDFSTree {
    DFSTree *tree = [[DFSTree alloc] init];
    [tree buildTreeWithCString:"boyce"];
    [tree buildTreeWithCString:"boyish"];
    [tree buildTreeWithCString:"book"];
    [tree buildTreeWithCString:"happy"];
    [tree buildTreeWithCString:"beyond"];
    [tree buildTreeWithCString:"append"];
    [tree buildTreeWithCString:"behind"];
    [tree dfsByStack];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:@"1" forKey:@"1"];
    [dic setValue:@"2" forKey:@"2"];
    [dic setValue:@"3" forKey:@"3"];
    [dic setValue:@"4" forKey:@"4"];
    [dic enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        NSLog(@"key : %@, obj : %@", key, obj);
    }];
    [dic setValue:@"22" forKey:@"2"];
    NSLog(@"--------------------");
    [dic enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        NSLog(@"key : %@, obj : %@", key, obj);
    }];
    [dic.allKeys enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"key : %@", obj);
    }];
    /*
     散列表虽然支持非常高效的插入、删除、查找操作，但散列表中的数据都经过散列函数打乱之后无序存储的，无法按照某种顺序快速的遍历数据
     散列表是动态数据结构，不停的有数据插入、删除，所以每次需要顺序遍历其中的数据的时候，都需要先排序，效率很低，为了解决这个问题，我们将散列表和链表(跳表)结合在一起使用
     如何存储这
     */
}

@end
