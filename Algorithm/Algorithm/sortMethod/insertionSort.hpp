//
//  insertionSort.hpp
//  Algorithm
//
//  Created by xulihua on 2018/4/29.
//  Copyright © 2018年 huage. All rights reserved.
//

#ifndef insertionSort_hpp
#define insertionSort_hpp

#include <stdio.h>
#include <algorithm>

using namespace std;

template <typename T>

// 插入排序
void insertionSort(T arr[], int n){
    
    // 对20000条数据进行排序，耗时0.638723 s
//    for (int i = 1; i < n; i++) {
//        for (int j = i; j > 0 && arr[j] < arr[j-1]; j--) {
//            swap(arr[j], arr[j-1]);
//        }
//    }
    
    // 对20000条数据进行排序，耗时0.317491 s
    for (int i = 1; i < n; i++) {
        //将要插入的值暂存起来
        T insertValue = arr[i];
        int j;
        for (j = i; j > 0 && insertValue < arr[j-1]; j--) {
            arr[j] = arr[j-1];
        }
        arr[j] = insertValue;
    }
};

#endif /* insertionSort_hpp */
