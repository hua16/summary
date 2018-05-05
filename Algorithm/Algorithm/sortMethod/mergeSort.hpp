//
//  mergeSort.hpp
//  Algorithm
//  归并算法
//  Created by xulihua on 2018/5/1.
//  Copyright © 2018年 huage. All rights reserved.
//

#ifndef mergeSort_hpp
#define mergeSort_hpp

#include <stdio.h>
#include <algorithm>
#include "insertionSort.hpp"
using namespace std;

template <typename T>

// 将数组arr[l, mid]和arr[mid+1, r]两部分归并
void ltmerge(T arr[], int l, int mid, int r) {
    T *aux = new T[r-l+1];
    // 将数组arr中[l,r]区间内的元素复制出来
    for (int i = l; i <= r; i++) {
        aux[i-l] = arr[i];
    }
    // 初始化，i指向左半部分的起始索引位置l；j指向右半部分起始索引位置mid+1
    int i = l, j = mid + 1;
    for (int k = l; k <= r; k++) {
        if (i > mid) { // 左半部分元素已经全部排序完成
            arr[k] = aux[j-l];
            j++;
        } else if (j > r) { // 右半部分元素已经全部排序完成
            arr[k] = aux[i-l];
            i++;
        } else if (aux[i-l] < aux[j-l]) { //取arr[i-l]和arr[j-l]中的最小值
            arr[k] = aux[i-l];
            i++;
        } else {
            arr[k] = aux[j-l];
            j++;
        }
    }
    delete [] aux;
}

// 递归使用归并排序,对arr[l...r]的范围进行排序
template <typename T>
void ltmergeSort(T arr[], int l, int r) {
    if (r - l < 15) {
        insertionSort(arr, l, r);
        return;
    }
//    if (l >= r) {
//        return;
//    }
    // 将数据均分为两部分
    int midIndex = (l + r)/2;
    ltmergeSort(arr, l, midIndex);
    ltmergeSort(arr, midIndex+1, r);
    if (arr[midIndex] > arr[midIndex+1]) {
        ltmerge(arr, l, midIndex, r);
    }
}

template <typename T>
void mergeSort(T arr[], int n) {
    ltmergeSort(arr, 0, n-1);
}



#endif /* mergeSort_hpp */
