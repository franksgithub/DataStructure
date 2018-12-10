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
