//
//  Trie.h
//  DataStructure
//
//  Created by Qiang on 2018/12/12.
//  Copyright © 2018 Qiang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TrieNode : NSObject

@property (nonatomic, assign) char data;
@property (nonatomic, strong) NSMutableArray *children;
@property (nonatomic, assign) BOOL isEndingChar;

- (instancetype)initWithChar:(char)data;

@end

@interface Trie : NSObject

- (void)insert:(NSString *)text;

- (BOOL)find:(NSString *)pattern;

@end

NS_ASSUME_NONNULL_END
