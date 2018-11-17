//
//  SingleLinkedList.h
//  DataStructure
//
//  Created by Qiang on 2018/10/11.
//  Copyright © 2018 Qiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ListNode : NSObject

@property (nonatomic, assign) NSInteger data;
@property (nonatomic, strong) ListNode *next;

+ (ListNode *)nodeWithData:(NSInteger)data;

- (instancetype)initWithData:(NSInteger)data;

@end

@interface SingleLinkedList : NSObject

@property (nonatomic, strong) ListNode *head;

- (ListNode *)findByValue:(NSInteger)value;

- (ListNode *)findByIndex:(NSInteger)index;

- (void)insertToHeadByValue:(NSInteger)value;

- (void)insertToHeadByNode:(ListNode *)node;

- (void)insertByValue:(NSInteger)value afterNode:(ListNode *)node;

- (void)insertByNode:(ListNode *)newNode afterNode:(ListNode *)node;

- (void)insertByValue:(NSInteger)value beforeNode:(ListNode *)node;

- (void)insertByNode:(ListNode *)newNode beforeNode:(ListNode *)node;

- (void)deleteByNode:(ListNode *)node;

- (void)deleteByValue:(NSInteger)value;

- (void)printList;

+ (ListNode *)reverse:(ListNode *)list;

+ (BOOL)checkCircle:(ListNode *)list;

+ (ListNode *)mergeSortedListWithListA:(ListNode *)listA listB:(ListNode *)listB;

+ (ListNode *)recursiveMergeSortedListWithListA:(ListNode *)listA listB:(ListNode *)listB;

+ (ListNode *)listByDeleteLastKth:(NSInteger)k inList:(ListNode *)list;

+ (ListNode *)findMiddleNodeInList:(ListNode *)list;

@end
