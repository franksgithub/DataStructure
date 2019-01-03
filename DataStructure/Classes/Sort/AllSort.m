//
//  AllSort.m
//  DesignPattern
//
//  Created by Qiang on 2018/10/15.
//  Copyright © 2018 Qiang. All rights reserved.
//

#import "AllSort.h"

@implementation AllSort

void swap(int a[], int i, int j) {
    int temp = a[i];
    a[i] = a[j];
    a[j] = temp;
}

void bubbleSort(int a[], int n) {
    if (n <= 1) {
        return;
    }
    for (int i = 0; i < n - 1; i++) {
        //哨兵,如果内部循环的过程中没有任何交换，则说明已有序
        BOOL sortedFlag = YES;
        for (int j = 0; j < n - i - 1; j++) {
            if (a[j] > a[j + 1]) {
                swap(a, j, j + 1);
                sortedFlag = NO;
            }
        }
        if (sortedFlag) {
            break;
        }
    }
}

void insertionSort(int a[], int n) {
    if (n <= 1) {
        return;
    }
    
    for (int i = 1; i < n; i++) {
        //外层循环中i前面的元素为有序的
        int value = a[i];
        int j = i - 1;
        BOOL showChange = NO;
        for (; j >= 0; j--) {
            if (a[j] > value) {
                a[j + 1] = a[j];
                showChange = YES;
            } else {
                //当条件不符合时，必须break，否则最后内层循环结束时，j值总是-1
                break;
            }
        }
        if (showChange) {
            a[j + 1] = value;
        }
    }
}

void selectionSort(int a[], int n) {
    if (n <= 1) {
        return;
    }
    
    for (int i = 0; i < n - 1; i++) {
        int min = a[i];
        int minIndex = i;
        for (int j = i + 1; j < n; j++) {
            if (a[j] < min) {
                minIndex = j;
                min = a[j];
            }
        }
        if (minIndex != i) {
            swap(a, i, minIndex);
        }
    }
}

//归并
void merge_sort(int a[], int n) {
    merge_sort_c(a, 0, n-1);
}

void merge_sort_c(int a[], int start, int end) {
    if (a == NULL || start >= end) {
        return;
    }
    int mid = (start + end) / 2;
    merge_sort_c(a, start, mid);
    merge_sort_c(a, mid + 1, end);
    merge(a, start, mid, end);
}

void merge(int a[], int start, int mid, int end) {
    int i = start, j = mid + 1, k = 0;
    int tmp[end - start + 1];
    //当两个区间都有数据时
    while (i <= mid && j <= end) {
        if (a[i] <= a[j]) {
            tmp[k++] = a[i++];
        } else {
            tmp[k++] = a[j++];
        }
    }
    //只剩一个区间有数据时
    int begin = i, stop = mid;
    if (j <= end) {
        begin = j;
        stop = end;
    }
    while (begin <= stop) {
        tmp[k++] = a[begin++];
    }
    //合并后拷贝回原数组
    for (int i = 0; i <= (end - start); i++) {
        a[start + i] = tmp[i];
    }
}

void mergeSortMain(int array[], int start, int end) {
    if (array == NULL || start >= end) {
        return;
    }
    int mid = (start + end) / 2;
    mergeSortMain(array, start, mid);
    mergeSortMain(array, mid + 1, end);
    realMerge(array, start, mid, end);
    
}

void realMerge(int array[], int start, int mid, int end) {
    int leftStart = start, rightStart = mid + 1, tempStart = 0;
    int temp[end - start + 1];
    while (leftStart <= mid && rightStart <= end) {
        if (array[leftStart] <= array[rightStart]) {
            temp[tempStart++] = array[leftStart++];
        } else {
            temp[tempStart++] = array[rightStart++];
        }
    }
    
    int begin = leftStart, stop = mid;
    if (rightStart <= end) {
        begin = rightStart;
        stop = end;
    }
    while (start <= end) {
        temp[tempStart++] = array[start++];
    }
    
    for (int i = 0; i <= (end - start); i++) {
        array[start + i] = temp[i];
    }
}

//快排
void quick_sort(int a[], int length) {
    quick_sort_c(a, 0, length - 1);
}

void quick_sort_c(int a[], int start, int end) {
    if (a == NULL || start >= end) {
        return;
    }
    int part_index = quick_partition(a, start, end);
    quick_sort_c(a, start, part_index - 1);
    quick_sort_c(a, part_index + 1, end);
}

int quick_partition(int a[], int start, int end) {
    int povit = a[end];
    int i = start;
    for (int j = start; j <= end - 1; j++) {
        if (a[j] < povit) {
            if (i != j) {
                swap(a, i, j);
            }
            i++;
        }
    }
    if (i != end) {
        swap(a, i, end);
    }
    return i;
}

int quickPertition(int array[], int start, int end) {
    int lastEle = array[end];
    int partIndex = start;
    for (int j = start; j < end - 1; j++) {
        if (array[j] < lastEle) {
            if (j != partIndex) {
                swap(array, j, partIndex);
            }
            partIndex++;
        }
    }
    if (partIndex != end) {
        swap(array, partIndex, end);
    }
    return partIndex;
}

//计数排序
void countingSort(int a[], int length) {
    if (a == NULL || length <= 1) {
        return;
    }
    //查找数组中数据的范围
    int max = a[0];
    for (int i = 1; i < length; i++) {
        if (max < a[i]) {
            max = a[i];
        }
    }
    
    int counter[max + 1];
    for (int i = 0; i <= max; i++) {
        counter[i] = 0;
    }
    
    // 计算每个元素的个数，放入counter中
    for (int i = 0; i < length; i++) {
        counter[a[i]]++;
    }
    
    //依次累加
    for (int i = 1; i < length; i++) {
        counter[i] = counter[i] + counter[i - 1];
    }
    
    int temp[length];
    // 计算排序的关键步骤
    for (int i = 0; i < length; i++) {
        int index = counter[a[i]] - 1;
        temp[index] = a[i];
        counter[a[i]]--;
    }
    
    for (int i = 0; i < length; i++) {
        a[i] = temp[i];
    }
}

void printArray(int a[], int n) {
    for(int i = 0; i < n; i++) {
        NSLog(@"index : %d, value : %d", i, a[i]);
    }
}

@end
