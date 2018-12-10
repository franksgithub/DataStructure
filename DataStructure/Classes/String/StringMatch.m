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
