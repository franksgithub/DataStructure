//
//  StringMatch.h
//  DataStructure
//
//  Created by Qiang on 2018/12/5.
//  Copyright © 2018 Qiang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface StringMatch : NSObject

@end

BOOL str_match(NSString *source, NSString *target);

void testDecorator(void);

int bm_match(char source[], int s_len, char pattern[], int p_len);

NS_ASSUME_NONNULL_END
