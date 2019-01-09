//
//  Common.h
//  DataStructure
//
//  Created by Qiang on 2018/12/5.
//  Copyright © 2018 Qiang. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Common : NSObject

+ (NSString *)transforMoneyWithValue:(float)value;

@end

void bag(int curIndex, int curWeight, int items[], int itemCount, int bagWeight);

void cal8Queens(int row);

int knapsack(int weight[], int n, int w);
int knapsack2(int weight[], int n, int w);
int bagDP(int weight[], int n, int w);
int bagDP2(int weight[], int n, int w);
int knapsack3(int weight[], int value[], int n, int w);

void swapTest();
