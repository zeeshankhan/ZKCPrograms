//
//  main.m
//  ZKAlgorithms
//
//  Created by Zeeshan Khan on 19/04/15.
//  Copyright (c) 2015 Zeeshan Khan. All rights reserved.
//

#import <Foundation/Foundation.h>

// Below size code will not work with malloc(), so read below thread and continue...
// http://stackoverflow.com/questions/37538/how-do-i-determine-the-size-of-my-array-in-c
#define SizeOfArray(x)  (sizeof(x) / sizeof(x[0]))

#pragma mark - Numbers

int factorial(int x) {
    
    int c, n, fact = 1;
    
    printf("Enter a number to calculate it's factorial\n");
    scanf("%d", &n);
    for (c = 1; c <= n; c++)
        fact = fact * c;
    printf("Factorial of %d = %d\n", n, fact);
    
    // Other way round
    fact = x;
    for (int i=1; i<x; i++)
        fact = fact * (x - i);
    printf("\n Factorial of %d: %d", x, fact);
    
    return fact;
}

void fibonacci(int x) {
    static int first = 0, second = 1, sum;
    if (x>0) {
        sum = first + second;
        first = second;
        second = sum;
        printf("%d ", sum);
        fibonacci(x-1);
    }
}

void door100Problem() {
    /*
        100 doors
        opened init
        toggle() =>
        close -> open
        open -> close
     */

    int doors[101] = {0}; // All closed
    for (int i=1; i<=101; i++) {
        for (int j=1; j<=101; j++) {
            if (i*j > 100) break;
            doors[i*j] = !doors[i*j];
        }
    }

    int a = 0;
    for (int x=1; x<101; x++) {
        if (doors[x]==1) {
            printf("Opened: %d\n", x);
            a++;
        }
    }
    
}

#pragma mark - Sorts

void bubbleSort() {
    int a[6] = {9, 3, 2, 6, 8, 4};
    for (int i=0; i<6; i++) {

        int flag = 0;
        for (int j=0; j<6-i-1; j++) {
        
            int temp;
            if (a[j] > a[j+1]) {
                temp = a[j];
                a[j] = a[j+1];
                a[j+1] = temp;
            }
            flag = 1;
        }
        if (flag == 0) break;
    }
}

void insertionSort() {
    int a[6] = {5, 1, 6, 2, 4, 3};
    for (int i=1; i<6; i++) {
        int key = a[i];
        int j = i-1;
        while (j>=0 && key < a[j]) {
            a[j+1] = a[j];
            j--;
        }
        a[j+1] = key;
    }
}

void selectionSort() {
    int a[6] = {5, 1, 6, 2, 4, 3};
    int size = 6;
    int min, temp;
    for (int i=0; i<size-1; i++) {
        min = i; //setting min as i
        for (int j=i+1; j<size; j++) {
            if (a[j] < a[min]) { // if element at j is less than element at min position
                min = j; //then set min as j
            }
        }
        temp = a[i];
        a[i] = a[min];
        a[min] = temp;
    }
}

#pragma mark quick sort

int partition(int a[], int p, int r) {
    int i, j, pivot, temp;
    pivot = a[p];
    i = p;
    j = r;
    
    while (1) {
        while (a[i] < pivot && a[i] != pivot) {
            i++;
        }
        
        while (a[j] > pivot && a[j] != pivot) {
            j--;
        }
        
        if (i < j) {
            temp = a[i];
            a[i] = a[j];
            a[j] = temp;
        }
        else {
            return j;
        }
    }
}

// a[] is the array to sort, p is starting point (that is 0), and r is the last index of array
void quickSort(int a[], int p, int r) {
    if (p < r) { // If no,
        int q = partition(a, p, r);
        quickSort(a, p, q);
        quickSort(a, q+1, r);
    }
}

void performQuickSort() {
    int a[] = {6, 8, 17, 14, 25, 63, 37, 52}; //{5, 1, 6, 2, 4, 3}
    int size = SizeOfArray(a);
    quickSort(a, 0, size-1);
    for (int x=0; x<size; x++) {
        printf("%d ", a[x]);
    }
}

#pragma mark Heap Sort

void satisfyheap(int a[], int i, int heapsize)
{
    int l, r, largest, temp;
    l = 2*i;
    r = 2*i + 1;
    if(l <= heapsize && a[l] > a[i])
    {
        largest = l;
    }
    else
    {
        largest = i;
    }
    if( r <= heapsize && a[r] > a[largest])
    {
        largest = r;
    }
    if(largest != i)
    {
        temp = a[i];
        a[i] = a[largest];
        a[largest] = temp;
        satisfyheap(a, largest, heapsize);
    }
}

void buildheap(int a[], int length)
{
    int i, heapsize;
    heapsize = length - 1;
    for( i=(length/2); i >= 0; i--)
    {
        satisfyheap(a, i, heapsize);
    }
}

void heapSort(int a[], int length)
{
    buildheap(a, length);
    int heapsize, i, temp;
    heapsize = length - 1;
    for( i=heapsize; i >= 0; i--)
    {
        temp = a[0];
        a[0] = a[heapsize];
        a[heapsize] = temp;
        heapsize--;
        satisfyheap(a, 0, heapsize);
    }
    for( i=0; i < length; i++)
    {
        printf("%d ", a[i]);
    }
}

void performHeapSort() {
    int a[] = {6, 8, 17, 14, 25, 63, 37, 52}; //{5, 1, 6, 2, 4, 3}
    int size = SizeOfArray(a);
    heapSort(a, size);
    for (int x=0; x<size; x++) {
        printf("%d ", a[x]);
    }
}

#pragma mark Merge Sort

/*  a[] is the array, p is starting index, that is 0,
 and r is the last index of array.  */

// Lets take a[5] = {32, 45, 67, 2, 7} as the array to be sorted.

void merge(int a[], int p, int q, int r)
{
    int b[5];     //same size of a[]
    int i, j, k;
    k = 0;
    i = p;
    j = q+1;
    while(i <= q && j <= r)
    {
        if(a[i] < a[j])
        {
            b[k++] = a[i++];       // same as b[k]=a[i]; k++; i++;
        }
        else
        {
            b[k++] = a[j++];
        }
    }
    
    while(i <= q)
    {
        b[k++] = a[i++];
    }
    
    while(j <= r)
    {
        b[k++] = a[j++];
    }
    
    for(i=r; i >= p; i--)
    {
        a[i] = b[--k];        // copying back the sorted list to a[]
    }
    
}

void mergeSort(int a[], int p, int r)
{
    int q;
    if(p < r)
    {
        q = floor( (p+r) / 2);
        mergeSort(a, p, q);
        mergeSort(a, q+1, r);
        merge(a, p, q, r);
    }
}


#pragma mark - Strings

int find_anagram(char array1[], char array2[]) {
    int num1[26] = {0}, num2[26] = {0}, i = 0;
    
    while (array1[i] != '\0')
    {
        num1[array1[i] - 'a']++;
        i++;
    }
    i = 0;
    while (array2[i] != '\0')
    {
        num2[array2[i] -'a']++;
        i++;
    }
    for (i = 0; i < 26; i++)
    {
        if (num1[i] != num2[i])
            return 0;
    }
    return 1;
}

#pragma mark - main

int main(int argc, const char * argv[]) {
    performQuickSort();
    return 0;
}
