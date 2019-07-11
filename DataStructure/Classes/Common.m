//
//  Common.m
//  DataStructure
//
//  Created by Qiang on 2018/12/5.
//  Copyright © 2018 Qiang. All rights reserved.
//

#import "Common.h"

static NSArray *numbers = nil;
static NSArray *numberUnits = nil;
static NSArray *floatUnits = nil;

@implementation Common

+ (void)load {
    numbers = @[@"零", @"一", @"二", @"三", @"四", @"五", @"六", @"七", @"八", @"九"];
    numberUnits = @[@"元", @"十", @"百", @"千", @"万", @"十万", @"百万", @"千万"];
    floatUnits = @[@"毛", @"分", @"厘"];
}

+ (NSString *)transforMoneyWithValue:(float)value {
    NSString *valueString = [NSString stringWithFormat:@"%.02f", value];
    NSArray *values = [valueString componentsSeparatedByString:@"."];
    NSString *numberStr = values[0];
    NSString *floatStr = values[1];
    NSInteger numberLength = numberStr.length;
    NSInteger floatLength = floatStr.length;
    NSMutableString *result = [NSMutableString string];
    NSRange numberRange = NSMakeRange(0, 1);
    for (int i = 0; i < numberLength; i++) {
        numberRange.location = i;
        NSInteger numberIndex = [[numberStr substringWithRange:numberRange] integerValue];
        NSInteger unitIndex = numberLength - i - 1;
        [result appendFormat:@"%@%@", numbers[numberIndex], numberUnits[unitIndex]];
    }
    if (floatLength > floatUnits.count) {
        floatLength = floatUnits.count;
    }
    for (int i = 0; i < floatLength; i++) {
        numberRange.location = i;
        NSInteger numberIndex = [[floatStr substringWithRange:numberRange] integerValue];
        [result appendFormat:@"%@%@", numbers[numberIndex], floatUnits[i]];
    }
    return [result copy];
}

@end

//0-1背包-回溯
int maxWeight = 0;
void bag(int curIndex, int curWeight, int items[], int itemCount, int bagWeight) {
    if (curIndex == itemCount - 1 || curWeight == bagWeight) {
        if (curWeight > maxWeight) {
            maxWeight = curWeight;
            NSLog(@"max weight : %d", maxWeight);
        }
        return;
    }
    //不放入背包
    bag(curIndex + 1, curWeight, items, itemCount, bagWeight);
    if (curWeight + items[curIndex] <= bagWeight) {
        //放入背包
        bag(curIndex + 1, curWeight + items[curIndex], items, itemCount, bagWeight);
    }
}

int result[] = {-1, -1, -1, -1, -1, -1, -1, -1};

BOOL isOK(int row, int column) {
    int leftUp = column - 1, rightUp = column + 1;
    for (int i = row - 1; i >= 0; i--) {
        if (result[i] == column) {
            return NO;
        }
        if (leftUp >= 0) {
            if (result[i] == leftUp) {
                return NO;
            }
        }
        if (rightUp < 8) {
            if (result[i] == rightUp) {
                return NO;
            }
        }
        --leftUp;
        ++rightUp;
    }
    return YES;
}

void printQueens(int result[]) {
    for (int row = 0; row < 8; ++row) {
        NSMutableString *line = [NSMutableString string];
        for (int column  = 0; column < 8; column++) {
            if (result[row] == column) {
                [line appendString:@"Q "];
            } else {
                [line appendString:@"* "];
            }
        }
        NSLog(line);
    }
}

void cal8Queens(int row) {
    if (row == 8) {
        printQueens(result);
        return;
    }
    for (int column = 0; column < 8; column++) {
        if (isOK(row, column)) {
            result[row] = column;
            cal8Queens(row + 1);
        }
    }
}



int knapsack(int weight[], int n, int w) {
    BOOL **states = malloc(sizeof(BOOL *) * n);
    for (int i = 0; i < n; i++) {
        states[i] = malloc(sizeof(BOOL) * (w + 1));
    }
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < w + 1; j++) {
            states[i][j] = NO;
        }
    }
    //第一行的数据要特殊处理
    states[0][0] = YES;
    states[0][weight[0]] = YES;
    for (int i = 1; i < n; i++) {
        for (int j = 0; j <= w; j++) {
            //判断上一行数据的放置情况
            if (states[i - 1][j] == YES) {
                //第i个不放
                states[i][j] = states[i - 1][j];
            }
        }
        int tempWeight = weight[i];
        for (int j = 0; j <= w - tempWeight; j++) {
            if (states[i - 1][j] == YES) {
                //第i个放入
                states[i][j + tempWeight] = YES;
            }
        }
    }
    for (int i = w; i >= 0; i--) {
        if (states[n - 1][i]) {
            return i;
        }
    }
    return 0;
}

int bagDP(int weight[], int n, int w) {
    BOOL states[n][w+1];
    states[0][0] = YES;
    states[0][weight[0]] = YES;
    for (int i = 1; i < n; ++i) {
        //本行不放
        for (int j = 0; j <= w; ++j) {
            if (states[i-1][j] == YES) {
                states[i][j] = states[i-1][j];
            }
        }
        int tempWeight = weight[i];
        for (int j = 0; j <= w - tempWeight; ++j) {
            if (states[i-1][j] == YES) {
                states[i][j + tempWeight] = YES;
            }
        }
    }
    for (int i = w; i >= 0; i--) {
        if (states[n-1][i] == YES) {
            return i;
        }
    }
    return 0;
}


int knapsack2(int weight[], int n, int w) {
    /*
    BOOL *states = malloc(sizeof(BOOL) * (w + 1));
    states[0] = YES;
    states[weight[0]] = YES;
    for (int i = 1; i < n; i++) {
        int tempWeight = weight[i];
        for (int j = w - tempWeight; j >= 0; j--) {
            if (states[j] == YES) {
                //根据上一层的放置情况，直接放置当层
                states[j + tempWeight] = YES;
            }
        }
    }
    for (int i = w; i >= 0; i--) {
        if (states[i]) {
            return i;
        }
    }
     */
    NSMutableArray<NSNumber *> *states = [NSMutableArray arrayWithCapacity:w + 1];
    for (int i = 0; i <= w; i++) {
        states[i] = @(NO);
    }
    states[0] = @(YES);
    states[weight[0]] = @(YES);
    for (int i = 1; i < n; i++) {
        int tempW = weight[i];
        for (int j = w - tempW; j >= 0; j--) {
            if ([states[j] boolValue]) {
                states[j + tempW] = @(YES);
            }
        }
    }
    for (int i = w; i >= 0; i--) {
        if ([states[i] boolValue]) {
            return i;
        }
    }
    return 0;
}

//2, 2, 4, 6, 3
int bagDP2(int weight[], int n, int w) {
    BOOL states[w+1];
    for (int i = 0; i <= w; i++) {
        states[i] = NO;
    }
    states[0] = YES;
    int tempWeight = weight[0];
    states[tempWeight] = YES;
    for (int i = 1; i < n; i++) {
        tempWeight = weight[i];
        for (int j = w - tempWeight; j >= 0; j--) {
            if (states[j] == YES) {
                states[j + tempWeight] = YES;
            }
        }
    }
    for (int i = w; i >= 0; i--) {
        if (states[i]) {
            return i;
        }
    }
    return 0;
}

//重量加价值
int knapsack3(int weight[], int value[], int n, int w) {
    /*
    int **states = malloc(sizeof(int *) * n);
    for (int i = 0; i < n; i++) {
        states[i] = malloc(sizeof(int) * (w + 1));
    }
    for (int i = 0; i < n; i++) {
        for (int j = 0; j <= w; j++) {
            states[i][j] = -1;
        }
    }
    states[0][0] = 0;
    states[0][weight[0]] = value[0];
    for (int i = 1; i < n; i++) {
        for (int j = 0; j <= w; j++) {
            if (states[i - 1][j] >= 0) {
                //第i个不放
                states[i][j] = states[i - 1][j];
            }
        }
        int tempWeight = weight[i];
        for (int j = 0; j <= w - tempWeight; j++) {
            if (states[i - 1][j] >= 0) {
                //第i个放入
                int v = states[i-1][j] + value[i];
                if (v > states[i][j + weight[i]]) {
                    states[i][j + weight[i]] = v;
                    NSLog(@"put in %d", weight[i]);
                }
            }
        }
    }
    int maxValue = -1;
    for (int i = 0; i <= w; i++) {
        if (states[n-1][i] > maxValue) {
            maxValue = states[n-1][i];
        }
    }
     */
    NSMutableArray *states = [NSMutableArray arrayWithCapacity:n];
    for (int i = 0; i < n; i++) {
        NSMutableArray *tempStates = [NSMutableArray arrayWithCapacity:w + 1];
        for (int j = 0; j <= w; j++) {
            tempStates[j] = @(-1);
        }
        states[i] = tempStates;
    }
    states[0][0] = @(0);
    states[0][weight[0]] = @(value[0]);
    for (int i = 1; i < n; i++) {
        for (int j = 0; j <= w; j++) {
            if ([states[i-1][j] intValue] >= 0) {
                states[i][j] = states[i-1][j];
            }
        }
        int tempW = weight[i];
        for (int j = 0; j <= w - tempW; j++) {
            if ([states[i - 1][j] intValue] >= 0) {
                int v = [states[i-1][j] intValue] + value[i];
                if (v > [states[i][j + weight[i]] intValue]) {
                    states[i][j + weight[i]] = @(v);
                    NSLog(@"put in %d", weight[i]);
                }
            }
        }
    }
    int maxValue = -1;
    for (int i = 0; i <= w; i++) {
        if ([states[n-1][i] intValue] > maxValue) {
            maxValue = [states[n-1][i] intValue];
        }
    }
    return maxValue;
}

int bagDPValue(int weight[], int value[], int n, int maxW) {
    int states[n][maxW+1];
    for (int i = 0; i < n; i++) {
        for (int j = 0; j <= maxW; j++) {
            states[i][j] = -1;
        }
    }
    //第一个物品单独处理
    states[0][0] = 0;
    states[0][weight[0]] = value[0];
    for (int i = 1; i < n; i++) {
        //第i个不放
        for (int j = 0; j <= maxW; j++) {
            if (states[i-1][j] > 0) {
                states[i][j] = states[i-1][j];
            }
        }
        //第i个放入
        int tempWeight = weight[i];
        for (int j = 0; j <= maxW - tempWeight; j++) {
            if (states[i-1][j] > 0) {
                int tempV = states[i-1][j] + value[i];
                //states[i][j + weight[i]表示什么？
                if (tempV > states[i][j + weight[i]]) {
                    states[i][j + weight[i]] = tempV;
                }
            }
        }
    }
    int maxValue = -1;
    for (int i = 0; i <= maxW; i++) {
        if (states[n-1][i] > maxValue) {
            maxValue = states[n-1][i];
        }
    }
    return maxValue;
}


void swapTest() {
    int x = 1;
    int y = 2;
    x = x ^ y;
    y = x ^ y;
    x = x ^ y;
    NSLog(@"x : %d, y : %d", x, y);
}
