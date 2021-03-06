//
//  Trie.h
//  DataStructure
//
//  Created by Qiang on 2018/12/12.
//  Copyright © 2018 Qiang. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ACNode : NSObject

@property (nonatomic, assign) char data;
@property (nonatomic, strong) NSMutableArray *children;
@property (nonatomic, assign) BOOL isEndingChar;
@property (nonatomic, assign) int length;
@property (nonatomic, strong) ACNode *fail;

@end

@interface ACMachine : NSObject

- (void)insert:(NSString *)text;

- (BOOL)find:(NSString *)pattern;

@end

