//
//  StringTests.m
//  DataStructureTests
//
//  Created by Qiang on 2018/12/5.
//  Copyright © 2018 Qiang. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "StringMatch.h"
#import "Trie.h"

@interface StringTests : XCTestCase

@end

@implementation StringTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testStrMatch {
    BOOL match = str_match(@"like a bird", @"a bi");
    NSLog(@"match : %@", match ? @"YES" : @"NO");
}

- (void)testBMMatch {
    char *source = "what is your name, name is not good abccbaabccbaafc";
    char *pattern = "ccba";
    int match_index = bm_match(source, (int)strlen(source), pattern, (int)strlen(pattern));
    NSLog(@"match index : %d", match_index);
}

- (void)testTrie {
    NSString *text = @"what";
    Trie *trie = [[Trie alloc] init];
    [trie insert:text];
    text = @"why";
    [trie insert:text];
    text = @"when";
    [trie insert:text];
    text = @"wheather";
    [trie insert:text];
    text = @"wheh";
    [trie insert:text];
    text = @"whatisyourname";
    [trie insert:text];
    NSString *pattern = @"what";
    BOOL match = [trie find:pattern];
    NSLog(@"match : %d", match);
}

@end
