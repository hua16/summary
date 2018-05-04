//
//  SortTestTool.hpp
//  Algorithm
//
//  Created by xulihua on 2018/4/24.
//  Copyright © 2018年 huage. All rights reserved.
//

#ifndef SortTestTool_hpp
#define SortTestTool_hpp

#include <stdio.h>
#include <iostream>
#include <ctime>
#include <cassert>

using namespace std;

namespace SortTestTool {
    
    // 生成有n个元素的随机数组,每个元素的随机范围为[rangeL, rangeR]
    int *generataRandomArray(int n, int rangeL, int rangeR) {
        
        assert(rangeL <= rangeR);
        int *arr = new int[n];
        
        srand((unsigned)time(NULL));
        for (int i = 0; i < n; i++) {
            arr[i] = rand() % (rangeR - rangeL + 1) + rangeL;
        }
        return arr;
    }
    
    // 打印arr数组的所有内容
    template<typename T>
    void show(T arr[], int n) {
        for (int i = 0; i < n; i++)
            cout<<arr[i] << " ";
        cout<<endl; 
        return;
    }
    
    // 判断数组是否是升序排列
    template<typename T>
    bool isSorted(T arr[], int n) {
        for (int i = 1; i < n; i++) {
            if (arr[i] < arr[i-1]) {
                return false;
            }
        }
        return true;
    }
    
    // 测试sort排序算法排序arr数组所得到结果的正确性和算法运行时间
    template<typename T>
    void testSort(const string &sortName, void(*sort)(T arr[], int n), T arr[], int n) {
        clock_t startTime = clock();
        sort(arr, n);
        clock_t endTime = clock();
        assert(isSorted(arr, n));
        cout << sortName << " : " << double(endTime - startTime) / CLOCKS_PER_SEC << " s" << endl;
        
        return;
    }
    
    int *copyIntArray(int a[], int n) {
        int *arr = new int[n];
        for (int i = 0; i < n; i++) {
            arr[i] = a[i];
        }
        return arr;
    }
    
    // 生成一个近乎有序的数组
    // 首先生成一个含有[0...n-1]的完全有序数组, 之后随机交换swapTimes对数据
    // swapTimes定义了数组的无序程度:
    // swapTimes == 0 时, 数组完全有序
    // swapTimes 越大, 数组越趋向于无序
    int *generateNearlyOrderedArray(int n, int swapTimes){
        
        int *arr = new int[n];
        for(int i = 0 ; i < n ; i ++ )
            arr[i] = i;
        
        srand(time(NULL));
        for( int i = 0 ; i < swapTimes ; i ++ ){
            int posx = rand()%n;
            int posy = rand()%n;
            swap( arr[posx] , arr[posy] );
        }
        
        return arr;
    }
};


#endif /* SortTestTool_hpp */
