//
//  SingleLinkedList.m
//  DataStructure
//
//  Created by Qiang on 2018/10/11.
//  Copyright © 2018 Qiang. All rights reserved.
//

#import "SingleLinkedList.h"

@implementation ListNode

- (instancetype)initWithData:(NSInteger)data {
    self = [super init];
    if (self) {
        _data = data;
    }
    return self;
}

+ (ListNode *)nodeWithData:(NSInteger)data {
    return [[ListNode alloc] initWithData:data];
}

@end

@interface SingleLinkedList()

//@property (nonatomic, strong) ListNode *head;

@end

@implementation SingleLinkedList

- (ListNode *)findByValue:(NSInteger)value {
    ListNode *node = _head;
    while (node && node.data != value) {
        node = node.next;
    }
    return node;
}

- (ListNode *)findByIndex:(NSInteger)index {
    ListNode *node = _head;
    int pos = 0;
    while (node && pos != index) {
        node = node.next;
        pos++;
    }
    return node;
}

- (void)insertToHeadByValue:(NSInteger)value {
    ListNode *newNode = [ListNode nodeWithData:value];
    [self insertToHeadByNode:newNode];
}

- (void)insertToHeadByNode:(ListNode *)node {
    if (!_head) {
        _head = node;
    } else {
        node.next = _head;
        _head = node;
    }
}

- (void)insertByValue:(NSInteger)value afterNode:(ListNode *)node {
    ListNode *newNode = [ListNode nodeWithData:value];
    [self insertByNode:newNode afterNode:node];
}

- (void)insertByNode:(ListNode *)newNode afterNode:(ListNode *)node {
    if (!node) {
        return;
    }
    newNode.next = node.next;
    node.next = newNode;
}

- (void)insertByValue:(NSInteger)value beforeNode:(ListNode *)node {
    ListNode *newNode = [ListNode nodeWithData:value];
    [self insertByNode:newNode beforeNode:node];
}

- (void)insertByNode:(ListNode *)newNode beforeNode:(ListNode *)node {
    if (!node) {
        return;
    }
    if (_head == node) {
        [self insertToHeadByNode:newNode];
        return;
    }
    
    ListNode *preNode = _head;
    while (preNode && preNode.next != node) {
        preNode = preNode.next;
    }
    if (!preNode) {
        return;
    }
    newNode.next = node;
    preNode.next = newNode;
}

- (void)deleteByNode:(ListNode *)node {
    if (!node || !_head) {
        return;
    }
    if (node == _head) {
        _head = _head.next;
        return;
    }
    ListNode *n = _head;
    while (n && n.next != node) {
        n = n.next;
    }
    if (!n) {
        return;
    }
    n.next = node.next;
}

- (void)deleteByValue:(NSInteger)value {
    if (_head == nil) {
        return;
    }
    ListNode *currentNode = _head;
    ListNode *preNode = nil;
    while (currentNode && currentNode.data != value) {
        preNode = currentNode;
        currentNode = currentNode.next;
    }
    if (currentNode == nil) {
        return;
    }
    if (preNode == nil) {
        _head = _head.next;
    } else {
        preNode.next = preNode.next.next;
    }
}

- (void)printList {
    ListNode *node = _head;
    while (node) {
        NSLog(@"node : %ld", (long)node.data);
        node = node.next;
    }
}

/**
 * 1) 单链表反转
 * 2) 链表中环的检测
 * 3) 两个有序的链表合并
 * 4) 删除链表倒数第n个结点
 * 5) 求链表的中间结点
 *
 * Author: Zheng
 */

//1)
+ (ListNode *)reverse:(ListNode *)list {
    ListNode *headNode = nil;
    ListNode *preNode = nil;
    ListNode *currentNode = list;
    while (currentNode) {
        //先要记录下nextNode，否则链会断
        ListNode *nextNode = currentNode.next;
        if (nextNode == nil) {
            headNode = currentNode;
        }
        currentNode.next = preNode;
        preNode = currentNode;
        currentNode = nextNode;
    }
    return headNode;
}

//2)
+ (BOOL)checkCircle:(ListNode *)list {
    if (list == nil) {
        return false;
    }
    //1,2,3,4,5
    ListNode *fast = list.next;
    ListNode *slow = list;
    while (fast && fast.next) {
        //what is this?
        fast = fast.next.next;
        slow = slow.next;
        if (slow == fast) {
            return true;
        }
    }
    return false;
}

//3)
+ (ListNode *)mergeSortedListWithListA:(ListNode *)listA listB:(ListNode *)listB {
    if (listA == nil) return listB;
    if (listB == nil) return listA;
    ListNode *aNode = listA;
    ListNode *bNode = listB;
    //记录合并后链表的头结点
    ListNode *mergedListHead;
    if (aNode.data < bNode.data) {
        mergedListHead = aNode;
        aNode = aNode.next;
    } else {
        mergedListHead = bNode;
        bNode = bNode.next;
    }
    //逐个合并两个链表的结点
    ListNode *mergedList = mergedListHead;
    while (aNode && bNode) {
        if (aNode.data < bNode.data) {
            mergedList.next = aNode;
            aNode = aNode.next;
        } else {
            mergedList.next = bNode;
            bNode = bNode.next;
        }
        mergedList = mergedList.next;
    }
    //检测哪个链表还有剩余结点
    if (aNode) {
        mergedList.next = aNode;
    } else {
        mergedList.next = bNode;
    }
    return mergedListHead;
}

+ (ListNode *)recursiveMergeSortedListWithListA:(ListNode *)listA listB:(ListNode *)listB {
    if (!listA) {
        return listB;
    }
    if (!listB) {
        return listA;
    }
    ListNode *mergedHead;
    if (listA.data < listB.data) {
        mergedHead = listA;
        mergedHead.next = [self recursiveMergeSortedListWithListA:listA.next listB:listB];
    } else {
        mergedHead = listB;
        mergedHead.next = [self recursiveMergeSortedListWithListA:listA listB:listB.next];
    }
    
    ListNode *mergeHead = nil;
    if (listA.data < listB.data) {
        mergeHead = listA;
        mergeHead.next = [self recursiveMergeSortedListWithListA:listA.next listB:listB];
    } else {
        mergeHead = listB;
        mergeHead.next = [self recursiveMergeSortedListWithListA:listA listB:listB.next];
    }
    
    return mergedHead;
}

+ (ListNode *)listByDeleteLastKth:(NSInteger)k inList:(ListNode *)list {
    ListNode *fast = list;
    int i = 1;
    while (fast && i < k) {
        fast = fast.next;
        i++;
    }
    
    if (fast == nil) return list;
    
    ListNode *slow = list;
    ListNode *preNode = nil;
    while (fast.next) {
        fast = fast.next;
        preNode = slow;
        slow= slow.next;
    }
    
    if (preNode == nil) {
        list = list.next;
    } else {
        preNode.next = preNode.next.next;
    }
    
    return list;
}

//5)
+ (ListNode *)findMiddleNodeInList:(ListNode *)list {
    if (!list) {
        return nil;
    }
    ListNode *fast  = list;
    ListNode *slow = list;
    while (fast.next && fast.next.next) {
        fast = fast.next.next;
        slow = slow.next;
    }
    return slow;
}

@end












