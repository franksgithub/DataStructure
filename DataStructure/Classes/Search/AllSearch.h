//
//  AllSearch.h
//  DataStructure
//
//  Created by Qiang on 2018/10/24.
//  Copyright © 2018 Qiang. All rights reserved.
//

#import <Foundation/Foundation.h>

int binary_search(int a[], int length, int searchValue);

int binary_search_first_bigger(int a[], int length, int searchValue);

int binary_search_last_smaller(int a[], int length, int searchValue);

@interface AllSearch : NSObject

@end

