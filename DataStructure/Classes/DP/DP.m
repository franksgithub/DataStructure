//
//  DP.m
//  DataStructure
//
//  Created by Qiang on 2019/1/2.
//  Copyright © 2019 Qiang. All rights reserved.
//

#import "DP.h"

@implementation DP

@end

char strA[] = "hellow";
char strB[] = "helloo";
int aLen = 6;
int bLen = 6;
int minDist = 100000;

#pragma mark - 编辑距离

//回溯
void lwstBT(int i, int j, int edist) {
    if (i == aLen || j == bLen) {
        if (i < aLen) {
            edist += (aLen - i);
        }
        if (j < bLen) {
            edist += (bLen - j);
        }
        if (edist < minDist) {
            minDist = edist;
        }
        NSLog(@"minDist : %d", minDist);
        return;
    }
    if (strA[i] == strB[j]) {
        //两个字符匹配
        lwstBT(i + 1, j + 1, edist);
    } else {
        //两个字符不匹配
        //删除a[i]或b[j]前添加一个字符
        lwstBT(i + 1, j, edist + 1);
        //删除b[j]或a[i]前添加一个字符
        lwstBT(i, j + 1, edist + 1);
        //将a[i]和b[j]替换为相同字符
        lwstBT(i + 1, j + 1, edist + 1);
    }
}

int min(int x, int y, int z) {
    int min = INT_MAX;
    if (x < min) min = x;
    if (y < min) min = y;
    if (z < min) min = z;
    return min;
}

//DP
int lwstDP(char *strA, int aLen, char *strB, int bLen) {
    int **minDist = malloc(sizeof(int *) * aLen);
    for (int i = 0; i < aLen; ++i) {
        minDist[i] = malloc(sizeof(int) * bLen);
    }
    //初始化第0行
    for (int j = 0; j < bLen; ++j) {
        if (strA[0] == strB[j]) {
            minDist[0][j] = j;
        } else if (j != 0) {
            minDist[0][j] = minDist[0][j-1] + 1;
        } else {
            minDist[0][j] = 1;
        }
    }
    //初始化第0列
    for (int i = 0; i < aLen; ++i) {
        if (strA[i] == strB[0]) {
            minDist[i][0] = i;
        } else if (i != 0) {
            minDist[i][0] = minDist[i-1][0] + 1;
        } else {
            minDist[i][0] = 1;
        }
    }
    for (int i = 1; i < aLen; ++i) {
        for (int j = 1; j < bLen; ++j) {
            if (strA[i] == strB[j]) {
                minDist[i][j] = min(minDist[i-1][j] + 1, minDist[i][j-1] + 1, minDist[i-1][j-1]);
            } else {
                minDist[i][j] = min(minDist[i-1][j] + 1, minDist[i][j-1] + 1, minDist[i-1][j-1] + 1);
            }
        }
    }
    int tempMin = minDist[aLen-1][bLen-1];
    NSLog(@"******* minDist : %d *******", tempMin);
    return tempMin;
}

//程序员的数学基础课上的思路
int lwstDPTest(char *strA, int aLen, char *strB, int bLen) {
    int minDist[aLen+1][bLen+1];
    for (int j = 0; j <= bLen; j++) {
        minDist[0][j] = j;
    }
    for (int i = 0; i <= aLen; i++) {
         minDist[i][0] = i;
    }
    for (int i = 0; i < aLen; i++) {
        for (int j = 0; j < bLen; j++) {
            int r = 0;
            if (strA[i] != strB[j]) {
                r = 1;
            }
            int firstAppend = minDist[i][j+1] + 1;
            int secondAppend = minDist[i+1][j] + 1;
            int replace = minDist[i][j] + r;
            minDist[i+1][j+1] = min(firstAppend, secondAppend, replace);
        }
    }
    int tempMin = minDist[aLen][bLen];
    NSLog(@"******* minDist : %d *******", tempMin);
    return tempMin;
}

#pragma mark - 最长公共子串

int max(int x, int y, int z) {
    int max = INT_MIN;
    if (x > max) max = x;
    if (y > max) max = y;
    if (z > max) max = z;
    return max;
}

NSNumber * max_self(NSNumber *x, NSNumber *y, NSNumber *z) {
    NSInteger max = x.integerValue > y.integerValue ? x.integerValue : y.integerValue;
    if (z.integerValue > max) {
        max = z.integerValue;
    }
    return @(max);
}

//最长公共子串
int lcsDP(char *strA, int aLen, char *strB, int bLen) {
    int **maxLcs = malloc(sizeof(int *) * aLen);
    for (int i = 0; i < aLen; ++i) {
        maxLcs[i] = malloc(sizeof(int) * bLen);
    }
    //初始化第0行
    for (int j = 0; j < bLen; ++j) {
        if (strA[0] == strB[j]) {
            maxLcs[0][j] = 1;
        } else if (j != 0) {
            maxLcs[0][j] = maxLcs[0][j-1];
        } else {
            maxLcs[0][j] = 0;
        }
    }
    //初始化第0列
    for (int i = 0; i < aLen; ++i) {
        if (strA[i] == strB[0]) {
            maxLcs[i][0] = 1;
        } else if (i != 0) {
            maxLcs[i][0] = maxLcs[i-1][0];
        } else {
            maxLcs[i][0] = 0;
        }
    }
    for (int i = 1; i < aLen; ++i) {
        for (int j = 1; j < bLen; ++j) {
            if (strA[i] == strB[j]) {
                maxLcs[i][j] = max(maxLcs[i-1][j], maxLcs[i][j-1], maxLcs[i-1][j-1]+1);
            } else {
                maxLcs[i][j] = max(maxLcs[i-1][j], maxLcs[i][j-1], maxLcs[i-1][j-1]);
            }
        }
    }
    int tempMax = maxLcs[aLen-1][bLen-1];
    NSLog(@"******* maxLcs : %d *******", tempMax);
    return tempMax;
}

NSInteger lcs_objc(NSString *strA, NSString *strB) {
    NSInteger aLen = strA.length;
    NSInteger bLen = strB.length;
    NSMutableArray<NSMutableArray *> *max_lcs = [NSMutableArray arrayWithCapacity:strA.length];
    NSMutableArray<NSNumber *> *tempArr;
    for (int i = 0; i < aLen; i++) {
        tempArr = [NSMutableArray arrayWithCapacity:bLen];
        for (int j = 0; j < bLen; j++) {
            tempArr[j] = @(0);
        }
        max_lcs[i] = tempArr;
    }
    unichar ca, cb;
    ca = [strA characterAtIndex:0];
    for (int j = 0; j < bLen; j++) {
        cb = [strB characterAtIndex:j];
        if (ca == cb) {
            max_lcs[0][j] = @(1);
        } else if (j != 0) {
            max_lcs[0][j] = max_lcs[0][j-1];
        } else {
            max_lcs[0][j] = @(0);
        }
    }
    cb = [strB characterAtIndex:0];
    for (int i = 0; i < aLen; ++i) {
        ca = [strA characterAtIndex:i];
        if (ca == cb) {
            max_lcs[i][0] = @(1);
        } else if (i != 0) {
            max_lcs[i][0] = max_lcs[i-1][0];
        } else {
            max_lcs[i][i] = @(0);
        }
    }
    for (int i = 1; i < aLen; i++) {
        for (int j = 1; j < bLen; j++) {
            if ([strA characterAtIndex:i] == [strB characterAtIndex:j]) {
                max_lcs[i][j] = max_self(max_lcs[i-1][j], max_lcs[i][j-1], @([max_lcs[i-1][j-1] integerValue] + 1));
            } else {
                max_lcs[i][j] = max_self(max_lcs[i-1][j], max_lcs[i][j-1], max_lcs[i-1][j-1]);
            }
        }
    }
    NSInteger tempMax = [max_lcs[aLen-1][bLen-1] integerValue];
    NSLog(@"******* maxLcs : %ld *******", tempMax);
    return tempMax;
}

#pragma mark - 矩阵最短路径

//矩阵最短路径，回溯
int matrix_min_dist = 10000;
void minDistBT(int i, int j, int dist, int w[5][5], int n) {
    if (i == n && j == n) {
        if (dist < matrix_min_dist) {
            matrix_min_dist = dist;
        }
        NSLog(@"******** min dist : %d ********", matrix_min_dist);
        return;
    }
    if (i < n) {
        minDistBT(i + 1, j, dist + w[i][j], w, n);
    }
    if (j < n) {
        minDistBT(i, j + 1, dist + w[i][j], w, n);
    }
}

//矩阵最短路径 DP
//状态转移表法
int minDistDP(int matrix[4][4], int len) {
    int states[len][len];
    int sum = 0;
    //第一行
    for (int j = 0; j < len; j++) {
        sum += matrix[0][j];
        states[0][j] = sum;
    }
    sum = 0;
    //第一列
    for (int i = 0; i < len; i++) {
        sum += matrix[i][0];
        states[i][0] = sum;
    }
    int leftState = 0, topState = 0;
    for (int i = 1; i < len; i++) {
        for (int j = 1; j < len; j++) {
            leftState = states[i][j-1];
            topState = states[i-1][j];
            states[i][j] = matrix[i][j] + MIN(leftState, topState);
        }
    }
    int tempDist = states[len-1][len-1];
    NSLog(@"min dist : %d", tempDist);
    return tempDist;
}

//状态转移方程
int length = 4;
int matrix[4][4] = {{1,2,3,4}, {1,2,3,4}, {1,2,3,4}, {1,2,3,4}};
int mem[4][4]; /**< 备忘录 */

int minDistForMatrixDP(int i, int j) {
    if (i == 0 && j == 0) {
        return matrix[0][0];
    }
    if (mem[i][j] > 0) {
        return mem[i][j];
    }
    int minLeft = INT_MAX;
    if (j - 1 >= 0) {
        minLeft = minDistForMatrixDP(i, j - 1);
    }
    int minUp = INT_MAX;
    if (i - 1 >= 0) {
        minUp = minDistForMatrixDP(i - 1, j);
    }
    int curMinDist = matrix[i][j] + MIN(minLeft, minUp);
    mem[i][j] = curMinDist;
    NSLog(@"min dist : %d", curMinDist);
    return curMinDist;
}


int level = 5;
int triangle[5][5] = {{5}, {7,8}, {2,3,4}, {4,9,6,1}, {2,7,9,4,5}};
int path[5][5];

int trianglePath() {
    //第一个特殊处理
    path[0][0] = triangle[0][0];
    //第一列
    for (int i = 1; i < level; i++) {
        path[i][0] = path[i-1][0] + triangle[i][0];
    }
    //最后一列
    for (int j = 1; j < level; j++) {
        path[j][j] = path[j-1][j-1] + triangle[j][j];
    }
    //中间元素的处理
    for (int i = 2; i < level; i++) {
        for (int j = 1; j < i; j++) {
            path[i][j] = MIN(path[i-1][j-1], path[i-1][j]) + triangle[i][j];
        }
    }
    int minPath = INT_MAX;
    for (int i = 0; i < level; i++) {
        if (minPath > path[level-1][i]) {
            minPath = path[level-1][i];
        }
    }
    NSLog(@"min path : %d", minPath);
    return minPath;
}

int triangle_path() {
    path[0][0] = triangle[0][0];
    for (int i = 1; i < level; i++) {
        path[i][0] = path[i-1][0] + triangle[i][0];
    }
    for (int j = 1; j < level; j++) {
        path[0][j] = path[0][j-1] + triangle[0][j];
    }
    for (int i = 2; i < level; i++) {
        for (int j = 2; j < i; j++) {
            path[i][j] = MIN(path[i-1][j-1], path[i-1][j] + triangle[i][j]);
        }
    }
    int minPath = INT_MAX;
    for (int i = 0; i < level; i++) {
        if (minPath > path[level-1][i]) {
            minPath = path[level-1][i];
        }
    }
    return minPath;
}










