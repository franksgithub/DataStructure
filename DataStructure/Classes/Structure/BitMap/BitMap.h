//
//  BitMap.h
//  DataStructure
//
//  Created by Qiang on 2019/1/9.
//  Copyright © 2019 Qiang. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface BitMap : NSObject

- (instancetype)initWithNumOfBits:(int)numOfBits;

- (void)setBitWithIndex:(int)index;

- (BOOL)getBitWithIndex:(int)index;

@end

