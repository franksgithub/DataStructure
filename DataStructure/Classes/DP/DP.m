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


int max(int x, int y, int z) {
    int max = INT_MIN;
    if (x > max) max = x;
    if (y > max) max = y;
    if (z > max) max = z;
    return max;
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
int minDistDP(int matrix[4][4], int len) {
    int states[len][len];
    NSLog(@" 1,1 : %d", states[1][1]);
    int sum = 0;
    for (int j = 0; j < len; ++j) {
        sum += matrix[0][j];
    }
    sum = 0;
    for (int i = 0; i < len; ++i) {
        sum += matrix[i][0];
        states[i][0] = sum;
    }
    for (int i = 1; i < len; i++) {
        for (int j = 1; j < len; j++) {
            states[i][j] = matrix[i][j] + MIN(states[i][j-1], states[i-1][j]);
        }
    }
    int tempDist = states[len-1][len-1];
    NSLog(@"min dist : %d", tempDist);
    return tempDist;
}

int length = 4;
int matrix[4][4] = {{1,2,3,4}, {1,2,3,4}, {1,2,3,4}, {1,2,3,4}};
int mem[4][4];

int minDistForMatrixDP(int i, int j) {
    if (i == 0 && j == 0) {
        return matrix[0][0];
    }
    if (mem[i][j] > 0) {
        return mem[i][j];
    }
    int minLeft = INT_MAX;
    if (j - 1 >= 0) {
        minLeft = minDistForMatrixDP(i, j-1);
    }
    int minUp = INT_MAX;
    if (i - 1 >= 0) {
        minUp = minDistForMatrixDP(i-1, j);
    }
    int curMinDist = matrix[i][j] + MIN(minLeft, minUp);
    mem[i][j] = curMinDist;
    NSLog(@"min dist : %d", curMinDist);
    return curMinDist;
}










