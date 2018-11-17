//
//  AllSearch.m
//  DataStructure
//
//  Created by Qiang on 2018/10/24.
//  Copyright © 2018 Qiang. All rights reserved.
//

#import "AllSearch.h"

@implementation AllSearch

int binary_search(int a[], int length, int searchValue) {
    if (a == NULL || length <= 0 || a[0] > searchValue || a[length - 1] < searchValue) {
        return -1;
    }
    return binarySearch_c(a, 0, length - 1, searchValue);
//    return binarySearch_recursion(a, 0, length - 1, searchValue);
}

int binarySearch_c(int a[], int startIndex, int endIndex, int searchValue) {
    int low = startIndex;
    int high = endIndex;
    while (low <= high) {
        int middle = (high + low) / 2;
//        middle = low + (high - low) / 2;
//        middle = low + ((high - low) >> 1);
        if (a[middle] == searchValue) {
//            return binary_search_first_value(a, middle, searchValue);
            return binary_search_last_value(a, endIndex, middle, searchValue);
        }
        if (a[middle] > searchValue) {
            high = middle - 1;
        } else {
            low = middle + 1;
        }
    }
    return -1;
}

//递归实现
int binarySearch_recursion(int a[], int low, int high, int searchValue) {
    if (low > high) {
        return -1;
    }
    int middle = low + (high - low) / 2;
    int middleValue = a[middle];
    if (middleValue == searchValue) {
        return middle;
    } else if (middleValue > searchValue) {
        return binarySearch_recursion(a, low, middle - 1, searchValue);
    } else {
        return binarySearch_recursion(a, middle + 1, high, searchValue);
    }
}

int binary_search_first_value(int a[], int currentIndex, int searchValue) {
    int tempIndex = currentIndex;
    while (tempIndex > 0) {
        tempIndex--;
        if (a[tempIndex] < searchValue) {
            return tempIndex + 1;
        }
    }
    return currentIndex;
}

int binary_search_last_value(int a[], int length, int currentIndex, int searchValue) {
    int tempIndex = currentIndex;
    while (tempIndex < length) {
        tempIndex++;
        if (a[tempIndex] > searchValue) {
            return tempIndex - 1;
        }
    }
    return currentIndex;
}

int binary_search_first_bigger(int a[], int length, int searchValue) {
    int low = 0, high = length - 1;
    while (low <= high) {
        int middle = low + ((high - low) >> 1);
        if (a[middle] >= searchValue) {
            if (middle == 0 || a[middle - 1] < searchValue) {
                return middle;
            } else {
                high = middle - 1;
            }
        } else {
            low = middle + 1;
        }
    }
    return -1;
}

int binary_search_last_smaller(int a[], int length, int searchValue) {
    int low = 0, high = length - 1;
    while (low <= high) {
        int middle = low + ((high - low) >> 1);
        if (a[middle] > searchValue) {
            high = middle - 1;
        } else {
            if (middle == length - 1 || a[middle + 1] > searchValue) {
                return middle;
            } else {
                low = middle + 1;
            }
        }
    }
    return -1;
}

@end
