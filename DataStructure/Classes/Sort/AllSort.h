//
//  AllSort.h
//  DesignPattern
//
//  Created by Qiang on 2018/10/15.
//  Copyright © 2018 Qiang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

void swap(int a[], int i, int j);

void bubbleSort(int a[], int n);

void insertionSort(int a[], int n);

void selectionSort(int a[], int n);

void merge_sort(int a[], int n);

void quick_sort(int a[], int length);

void countingSort(int a[], int length);

void printArray(int a[], int n);

@interface AllSort : NSObject

@end

NS_ASSUME_NONNULL_END
