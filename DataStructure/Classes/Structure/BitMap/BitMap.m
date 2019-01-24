//
//  BitMap.m
//  DataStructure
//
//  Created by Qiang on 2019/1/9.
//  Copyright © 2019 Qiang. All rights reserved.
//

#import "BitMap.h"

@interface BitMap() {
    int nbits;
    char *bytes;
}

@end

@implementation BitMap

- (instancetype)initWithNumOfBits:(int)numOfBits {
    self = [super init];
    if (self) {
        nbits = numOfBits;
        bytes = calloc((nbits / 8) + 1, sizeof(char));
    }
    return self;
}

//9
- (void)setBitWithIndex:(int)index {
    if (index > nbits) {
        return;
    }
    int byteIndex = index / 8;
    int bitIndex = index % 8;
    bytes[byteIndex] |= (1 << bitIndex);
}

//9
- (BOOL)getBitWithIndex:(int)index {
    if (index > nbits) {
        return NO;
    }
    int byteIndex = index / 8;
    int bitIndex = index % 8;
    return (bytes[byteIndex] & (1 << bitIndex)) != 0;
}

@end
