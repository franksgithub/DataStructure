//
//  DataStructureTests.m
//  DataStructureTests
//
//  Created by Qiang on 2018/10/11.
//  Copyright © 2018 Qiang. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ArrayQueue.h"
#import "LinkListQueue.h"
#import "CircleQueue.h"
#import "SingleLinkedList.h"
#import "TwoStackQueue.h"
#import "Student.h"
#import "NSObject+Cate.h"

@interface DataStructureTests : XCTestCase

@end

@implementation DataStructureTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    ArrayQueue *queue = [[ArrayQueue alloc] initWithCapacity:5];
    [queue enqueue:10];
    [queue enqueue:9];
    [queue enqueue:8];
    [queue enqueue:7];
    [queue enqueue:6];
    [queue showItems];
    NSLog(@"------------------");
    [queue dequeue];
    [queue dequeue];
    [queue showItems];
    NSLog(@"------------------");
    [queue enqueue:5];
    [queue enqueue:4];
    [queue enqueue:3];
    [queue showItems];
}

- (void)testLinkListQueue {
    LinkListQueue *queue = [[LinkListQueue alloc] initWithCapacity:5];
    [queue enqueue:10];
    [queue enqueue:9];
    [queue enqueue:8];
    [queue enqueue:7];
    [queue enqueue:6];
    [queue showItems];
    NSLog(@"------------------");
    [queue dequeue];
    [queue dequeue];
    [queue showItems];
    NSLog(@"------------------");
    [queue enqueue:5];
    [queue enqueue:4];
    [queue enqueue:3];
    [queue showItems];
}

- (void)testCircleQueue {
    CircleQueue *queue = [[CircleQueue alloc] initWithCapacity:6];
    [queue enqueue:10];
    [queue enqueue:9];
    [queue enqueue:8];
    [queue enqueue:7];
    [queue enqueue:6];
    [queue showItems];
    NSLog(@"------------------");
    [queue dequeue];
    [queue dequeue];
    [queue showItems];
    NSLog(@"------------------");
    [queue enqueue:5];
    [queue enqueue:4];
    [queue enqueue:3];
    [queue showItems];
}

- (void)testSingleLinkedList {
    SingleLinkedList *linkedList = [[SingleLinkedList alloc] init];
    [linkedList insertToHeadByValue:100];
    [linkedList insertToHeadByValue:101];
    [linkedList insertToHeadByValue:102];
    [linkedList insertToHeadByValue:103];
    [linkedList insertToHeadByValue:104];
    [linkedList insertToHeadByValue:1025];
    NSLog(@"------------------");
    [linkedList printList];
    [linkedList deleteByValue:103];
    [linkedList deleteByValue:101];
    NSLog(@"------------------");
    [linkedList printList];
}

- (void)testReverseSingleLinkedList {
    SingleLinkedList *linkedList = [[SingleLinkedList alloc] init];
    [linkedList insertToHeadByValue:100];
    [linkedList insertToHeadByValue:101];
    [linkedList insertToHeadByValue:102];
    [linkedList insertToHeadByValue:103];
    [linkedList insertToHeadByValue:104];
    [linkedList insertToHeadByValue:1025];
    [linkedList printList];
    NSLog(@"------------------");
    ListNode *reversedHeadNode = [SingleLinkedList reverse:linkedList.head];
    SingleLinkedList *reversedLinkedList = [[SingleLinkedList alloc] init];
    reversedLinkedList.head = reversedHeadNode;
    [reversedLinkedList printList];
}

- (void)testMerge {
    SingleLinkedList *linkedListA = [[SingleLinkedList alloc] init];
    [linkedListA insertToHeadByValue:103];
    [linkedListA insertToHeadByValue:102];
    [linkedListA insertToHeadByValue:101];
    
    SingleLinkedList *linkedListB = [[SingleLinkedList alloc] init];
    [linkedListB insertToHeadByValue:110];
    [linkedListB insertToHeadByValue:109];
    [linkedListB insertToHeadByValue:108];
    [linkedListB insertToHeadByValue:108];
    [linkedListB insertToHeadByValue:107];
    [linkedListB insertToHeadByValue:106];
    
    ListNode *mergedHead = [SingleLinkedList mergeSortedListWithListA:linkedListA.head listB:linkedListB.head];
    SingleLinkedList *mergedList = [[SingleLinkedList alloc] init];
    mergedList.head = mergedHead;
    [mergedList printList];
}

- (void)testRecursiveMerge {
    SingleLinkedList *linkedListA = [[SingleLinkedList alloc] init];
    [linkedListA insertToHeadByValue:103];
    [linkedListA insertToHeadByValue:102];
    [linkedListA insertToHeadByValue:101];
    
    SingleLinkedList *linkedListB = [[SingleLinkedList alloc] init];
    [linkedListB insertToHeadByValue:110];
    [linkedListB insertToHeadByValue:109];
    [linkedListB insertToHeadByValue:108];
    [linkedListB insertToHeadByValue:108];
    [linkedListB insertToHeadByValue:107];
    [linkedListB insertToHeadByValue:106];
    
    ListNode *mergedHead = [SingleLinkedList recursiveMergeSortedListWithListA:linkedListA.head listB:linkedListB.head];
    SingleLinkedList *mergedList = [[SingleLinkedList alloc] init];
    mergedList.head = mergedHead;
    [mergedList printList];
}

- (void)testDeleteNodeByIndex {
    SingleLinkedList *linkedListA = [[SingleLinkedList alloc] init];
    [linkedListA insertToHeadByValue:103];
    [linkedListA insertToHeadByValue:102];
    [linkedListA insertToHeadByValue:101];
    [linkedListA insertToHeadByValue:110];
    [linkedListA insertToHeadByValue:109];
    [linkedListA insertToHeadByValue:108];
    [linkedListA insertToHeadByValue:107];
    [linkedListA insertToHeadByValue:106];
    
    [linkedListA printList];
    NSLog(@"---------华丽的分割---------");
    
    ListNode *deletedHead = [SingleLinkedList listByDeleteLastKth:3 inList:linkedListA.head];
    SingleLinkedList *deletedList = [[SingleLinkedList alloc] init];
    deletedList.head = deletedHead;
    [deletedList printList];
    
}

- (void)testFindMiddleNode {
    SingleLinkedList *linkedListA = [[SingleLinkedList alloc] init];
    [linkedListA insertToHeadByValue:103];
    [linkedListA insertToHeadByValue:102];
    [linkedListA insertToHeadByValue:101];
    [linkedListA insertToHeadByValue:110];
    [linkedListA insertToHeadByValue:109];
    [linkedListA insertToHeadByValue:108];
    [linkedListA insertToHeadByValue:107];
    
    ListNode *middleNode = [SingleLinkedList findMiddleNodeInList:linkedListA.head];
    NSLog(@"middle node : %ld", middleNode.data);
    
}

- (void)testTwoStackQueue {
    TwoStackQueue *queue = [[TwoStackQueue alloc] initWithCapacity:10];
    [queue enqueue:1];
    [queue enqueue:2];
    [queue enqueue:3];
    [queue enqueue:4];
    [queue enqueue:5];
    [queue enqueue:6];
    int ele = [queue dequeue];
    ele = [queue dequeue];
    ele = [queue dequeue];
    ele = [queue dequeue];
    ele = [queue dequeue];
    ele = [queue dequeue];
    NSLog(@" ele : %d", ele);
}

- (void)testMalloc {
    void *p1 = malloc(sizeof(int) * 4);
    free(p1);
    void *p2 = malloc(sizeof(int) * 2);
    ((int *)p2)[0] = 20;
    int t1 = 10;
    int a[] = {10,20};
    NSLog(@"p1-%p, p2-%p, t1-%p, a3 - %d", p1, p2, &t1, a[1]);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

- (void)testStu {
//    [Student lala];
    [Student say];
}

@end


















