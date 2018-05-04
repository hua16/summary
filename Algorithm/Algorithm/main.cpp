//
//  main.cpp
//  Algorithm
//
//  Created by xulihua on 2018/4/24.
//  Copyright © 2018年 huage. All rights reserved.
//

#include <iostream>
#include <algorithm>
#include "SortTestTool.hpp"
#include "selectionSort.hpp"
#include "insertionSort.hpp"
#include "mergeSort.hpp"

using namespace std;

int main(int argc, const char * argv[]) {
    // 测试排序算法辅助函数
    int N = 20000;
    // 测试1 一般测试
    cout<<"Test for random array, size = "<<N<<", random range [0, "<<N<<"]"<<endl;
    
    int *selectionArr = SortTestTool::generataRandomArray(N,0,N);
    int *insertionArr = SortTestTool::copyIntArray(selectionArr, N);
    int *mergeArr = SortTestTool::copyIntArray(selectionArr, N);
    
    SortTestTool::testSort("Selection Sort", selectionSort, selectionArr, N);
    SortTestTool::testSort("Insertion Sort", insertionSort, insertionArr, N);
    SortTestTool::testSort("Merge Sort", mergeSort, mergeArr, N);
    
    delete[] selectionArr;
    delete[] insertionArr;
    delete[] mergeArr;
    
//    输出结果：
//    Selection Sort : 0.475496 s
//    Insertion Sort : 0.312144 s
    
    // 测试2 有序性更强的测试
    cout<<"Test for more ordered random array, size = "<<N<<", random range [0, 3]"<<endl;
    selectionArr = SortTestTool::generataRandomArray(N,0,3);
    insertionArr = SortTestTool::copyIntArray(selectionArr, 3);
    mergeArr = SortTestTool::copyIntArray(selectionArr, 3);
    
    SortTestTool::testSort("Selection Sort", selectionSort, selectionArr, N);
    SortTestTool::testSort("Insertion Sort", insertionSort, insertionArr, N);
    SortTestTool::testSort("Merge Sort", mergeSort, mergeArr, N);
    
    delete[] selectionArr;
    delete[] insertionArr;
    delete[] mergeArr;
    
//    输出结果：
//    Selection Sort : 0.469005 s
//    Insertion Sort : 0.021836 s
    
    // 测试3 测试近乎有序的数组
    int swapTimes = 100;
    cout<<"Test for nearly ordered array, size = "<<N<<", swap time = "<<swapTimes<<endl;
    selectionArr = SortTestTool::generateNearlyOrderedArray(N,swapTimes);
    insertionArr = SortTestTool::copyIntArray(selectionArr, 3);
    mergeArr = SortTestTool::copyIntArray(selectionArr, 3);
    
    SortTestTool::testSort("Selection Sort", selectionSort, selectionArr, N);
    SortTestTool::testSort("Insertion Sort", insertionSort, insertionArr, N);
    SortTestTool::testSort("Merge Sort", mergeSort, mergeArr, N);
    
    delete[] selectionArr;
    delete[] mergeArr;
    delete[] insertionArr;
    
//    输出结果： 
//    Selection Sort : 0.460393 s
//    Insertion Sort : 0.000381 s
    
    return 0;
}

