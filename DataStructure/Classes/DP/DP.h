//
//  DP.h
//  DataStructure
//
//  Created by Qiang on 2019/1/2.
//  Copyright © 2019 Qiang. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface DP : NSObject

@end

void lwstBT(int i, int j, int edist);

int lwstDP(char *strA, int aLen, char *strB, int bLen);

int lcsDP(char *strA, int aLen, char *strB, int bLen);

void minDistBT(int i, int j, int dist, int matrix[5][5], int n);

int minDistDP(int matrix[4][4], int len);

int minDistForMatrixDP(int i, int j);

int lwstDPTest(char *strA, int aLen, char *strB, int bLen);

int trianglePath();

NSInteger lcs_objc(NSString *strA, NSString *strB);
