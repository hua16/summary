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
#include "heap.hpp"

using namespace std;


// heapSort1, 将所有的元素依次添加到堆中, 在将所有元素从堆中依次取出来, 即完成了排序
// 无论是创建堆的过程, 还是从堆中依次取出元素的过程, 时间复杂度均为O(nlogn)
// 整个堆排序的整体时间复杂度为O(nlogn)
template<typename T>
void heapSort1(T arr[], int n){
    
    MaxHeap<T> maxheap = MaxHeap<T>(n);
    for( int i = 0 ; i < n ; i ++ )
        maxheap.insert(arr[i]);
    
    for( int i = n-1 ; i >= 0 ; i-- )
        arr[i] = maxheap.extractMax();
    
}


// heapSort2, 借助我们的heapify过程创建堆
// 此时, 创建堆的过程时间复杂度为O(n), 将所有元素依次从堆中取出来, 实践复杂度为O(nlogn)
// 堆排序的总体时间复杂度依然是O(nlogn), 但是比上述heapSort1性能更优, 因为创建堆的性能更优
template<typename T>
void heapSort2(T arr[], int n){
    
    MaxHeap<T> maxheap = MaxHeap<T>(arr,n);
    for( int i = n-1 ; i >= 0 ; i-- )
        arr[i] = maxheap.extractMax();
    
}


int main(int argc, const char * argv[]) {
    // 测试排序算法辅助函数
    int N = 20000;
    // 测试1 一般测试
    cout<<"Test for random array, size = "<<N<<", random range [0, "<<N<<"]"<<endl;
    
    int *selectionArr = SortTestTool::generataRandomArray(N,0,N);
    int *insertionArr = SortTestTool::copyIntArray(selectionArr, N);
    int *mergeArr = SortTestTool::copyIntArray(selectionArr, N);
    int *heapArr1 = SortTestTool::copyIntArray(selectionArr, N);
    int *heapArr2 = SortTestTool::copyIntArray(selectionArr, N);
    
    SortTestTool::testSort("Selection Sort", selectionSort, selectionArr, N);
    SortTestTool::testSort("Insertion Sort", insertionSort, insertionArr, N);
    SortTestTool::testSort("Merge Sort", mergeSort, mergeArr, N);
    SortTestTool::testSort("Heap Sort 1", heapSort1, mergeArr, N);
    SortTestTool::testSort("Heap Sort 2", heapSort2, mergeArr, N);
    
    delete[] selectionArr;
    delete[] insertionArr;
    delete[] mergeArr;
    delete[] heapArr1;
    delete[] heapArr2;
    cout<<endl;
    
//    输出结果：
//    Selection Sort : 0.483302 s
//    Insertion Sort : 0.314122 s
//    Merge Sort : 0.022482 s
    
    // 测试2 有序性更强的测试
    cout<<"Test for more ordered random array, size = "<<N<<", random range [0, 3]"<<endl;
    selectionArr = SortTestTool::generataRandomArray(N,0,3);
    insertionArr = SortTestTool::copyIntArray(selectionArr, N);
    mergeArr = SortTestTool::copyIntArray(selectionArr, N);
    heapArr1 = SortTestTool::copyIntArray(selectionArr, N);
    heapArr2 = SortTestTool::copyIntArray(selectionArr, N);
    
    SortTestTool::testSort("Selection Sort", selectionSort, selectionArr, N);
    SortTestTool::testSort("Insertion Sort", insertionSort, insertionArr, N);
    SortTestTool::testSort("Merge Sort", mergeSort, mergeArr, N);
    SortTestTool::testSort("Heap Sort 1", heapSort1, mergeArr, N);
    SortTestTool::testSort("Heap Sort 2", heapSort2, mergeArr, N);
    
    delete[] selectionArr;
    delete[] insertionArr;
    delete[] mergeArr;
    delete[] heapArr1;
    delete[] heapArr2;
    cout<<endl;
    
//    输出结果：
//    Selection Sort : 0.475358 s
//    Insertion Sort : 0.239687 s
//    Merge Sort : 0.028358 s
    
    // 测试3 测试近乎有序的数组
    int swapTimes = 0;
    cout<<"Test for nearly ordered array, size = "<<N<<", swap time = "<<swapTimes<<endl;
    selectionArr = SortTestTool::generateNearlyOrderedArray(N,swapTimes);
    insertionArr = SortTestTool::copyIntArray(selectionArr, N);
    mergeArr = SortTestTool::copyIntArray(selectionArr, N);
    heapArr1 = SortTestTool::copyIntArray(selectionArr, N);
    heapArr2 = SortTestTool::copyIntArray(selectionArr, N);
    
    SortTestTool::testSort("Selection Sort", selectionSort, selectionArr, N);
    SortTestTool::testSort("Insertion Sort", insertionSort, insertionArr, N);
    SortTestTool::testSort("Merge Sort", mergeSort, mergeArr, N);
    SortTestTool::testSort("Heap Sort 1", heapSort1, mergeArr, N);
    SortTestTool::testSort("Heap Sort 2", heapSort2, mergeArr, N);
    
    delete[] selectionArr;
    delete[] mergeArr;
    delete[] insertionArr;
    delete[] heapArr1;
    delete[] heapArr2;
    cout<<endl;
    
//    输出结果：
//    Selection Sort : 0.474748 s
//    Insertion Sort : 9.7e-05 s
//    Merge Sort : 0.000306 s
    
    return 0;
}

