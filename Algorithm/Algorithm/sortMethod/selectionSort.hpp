//
//  selectionSort.hpp
//  Algorithm
//
//  Created by xulihua on 2018/4/29.
//  Copyright © 2018年 huage. All rights reserved.
//

#ifndef selectionSort_hpp
#define selectionSort_hpp

#include <stdio.h>
#include <algorithm>

using namespace std;

//选择排序，算法复杂度O(n*n)
template<typename T>
void selectionSort(T arr[], int n){
    
    for(int i = 0 ; i < n ; i ++){
        
        // 寻找[i, n)区间里的最小值所在的位置
        int minIndex = i;
        for(int j = i + 1 ; j < n ; j ++) {
            if(arr[j] < arr[minIndex]) {
                minIndex = j;
            }
        }
        std::swap(arr[i], arr[minIndex]);
    }
}

#endif /* selectionSort_hpp */
