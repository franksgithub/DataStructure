//
//  StringMatch.m
//  DataStructure
//
//  Created by Qiang on 2018/12/5.
//  Copyright © 2018 Qiang. All rights reserved.
//

#import "StringMatch.h"

@implementation StringMatch

@end

BOOL subStr_match(NSString *source, NSString *target, NSInteger length) {
    char sourceChar;
    char targetChar;
    for (int i = 0; i < length; i++) {
        sourceChar = [source characterAtIndex:i];
        targetChar = [target characterAtIndex:i];
        if (sourceChar != targetChar) {
            return NO;
        }
    }
    return YES;
}

BOOL str_match(NSString *source, NSString *target) {
    NSInteger sourceLength = source.length;
    NSInteger targetLength = target.length;
    NSInteger offsetLength = sourceLength - targetLength;
    for (int i = 0; i <= offsetLength; i++) {
        NSString *subStr = [source substringWithRange:NSMakeRange(i, targetLength)];
        BOOL subMatch = subStr_match(subStr, target, targetLength);
        if (subMatch) {
            return subMatch;
        }
    }
    return NO;
}

int decorator(int (*func)(int num), int orig, int plus) {
    return func(orig) + plus;
}

int sum5(int num) {
    return num + 5;
}

void testDecorator() {
    int result = decorator(sum5, 4, 10);
    NSLog(@"result : %d", result);
}

static int BC_Size = 256;

void generateBC(char pattern[], int p_len, int bc[]) {
    for (int i = 0; i < BC_Size; i++) {
        bc[i] = -1;
    }
    for (int j = 0; j < p_len; j++) {
        int asicc = (int)pattern[j];
        bc[asicc] = j;
    }
}

void generateSuffixAndPrefix(char pattern[], int p_len, int suffix[], BOOL prefix[]) {
    for (int i = 0; i < p_len; i++) {
        suffix[i] = -1;
        prefix[i] = NO;
    }
    //abcabc
    for (int i = 0; i < p_len - 1; i++) {
        int j = i;
        int k = 0;  //公共后缀子串长度
        while (j >= 0 && pattern[j] == pattern[p_len - k - 1]) {    //与pattern[0, p_len-1]求公共后缀子串
            --j;
            ++k;
            suffix[k] = j + 1;  //j+1：表示公共后缀子串在pattern[0,i]中的起始下标
        }
        //如果公共后缀子串也是模式串的前缀子串
        if (j == -1) {
            prefix[k] = YES;
        }
    }
}

int moveByGS(int j, int p_len, int suffix[], BOOL prefix[]) {
    int k = p_len - j - 1;
    if (suffix[k] != -1) {
        return j - suffix[k] + 1;
    }
    for (int r = j + 2; r <= p_len - 1; r++) {
        if (prefix[p_len - r]) {
            return r;
        }
    }
    return p_len;
}

int bm_match(char source[], int s_len, char pattern[], int p_len) {
    int *bc = malloc(sizeof(int) * BC_Size);
    generateBC(pattern, p_len, bc);
    int *suffix = malloc(sizeof(int) * p_len);
    BOOL *prefix = malloc(sizeof(BOOL) * p_len);
    generateSuffixAndPrefix(pattern, p_len, suffix, prefix);
    int i = 0;
    while (i <= s_len - p_len) {
        int j;
        for (j = p_len - 1; j >= 0; j--) {
            if (source[i + j] != pattern[j]) {
                break;
            }
        }
        if (j < 0) {
            return i;
        }
        //source[i + j]为坏字符
        int x = j - bc[(int)source[i + j]];
        int y = 0;
        if (j < p_len - 1) {
            y = moveByGS(j, p_len, suffix, prefix);
        }
        i = i + MAX(x, y);
    }
    return -1;
}




