/**
 *  This playground is for First session assignment in IOS Bootcamp
 *  Assignment : Implement any sort algorithm , that is able to sort array of integers or strings
 *  Implementation of Quick Sort Algorithm
 *  By : Karim Ebrahem
 */

/* --------------------------------------------------- */

// Explaination of QuickSort Algorithm 
/*
 It works by devide the array into 3 parts, less, equal and greater. Then stay doing this devide the 3 arrays again and again tell we have 3 arrays each array with a single value, then the return statement handle them in sorted way.
 Example with 6 numbers array ( 1 to 6 ): 
    
                                    { 2, 3, 6, 1, 5, 4 }
                                        mid = 1
                    less = {}                           greater = {2, 3, 6, 5, 4}
                                                                       mid = 6
                                            less = {2, 3, 5, 4}                            greater = {}
                                                    mid = 5
                            less = {2, 3, 4}                        greater = {}
                                    mid = 3
                    less = {2}                  greater = {4}
 
 Problem with this QuickSort is the Partioning (devide the array), as i use swift built-in function Filter or my implemented function for filter it still create a new array each time it devide the arrays.
 To handle partioning problem ther is to in-place partioning like Lomuto's partioning and Hoaro's Parioning.
 another problem is the mid value, if we unlucky and choosed not good mid value the pereformance of Quicksort will low to be slower as InsertionSort : the solution is choosing med value by random.
 Example : [ 7, 6, 5, 1, 4, 3, 2 ]
*/

/* --------------------------------------------------- */

// My Implementation of filter array function as i understand it.
func getMatchElements<T: Comparable>(_ array: [T],_ mid: T,_ isOrdered: (T, T) -> Bool) -> [T]{
    var matchArray = [T]()
    for number: T in array {
        if isOrdered(number, mid) {
            matchArray.append(number)
        }
    }
    return matchArray
}

// My Implementation of QuickSort Algorithm using generic to sort any type of comparable array.
func quicksort<T: Comparable>(_ a: [T]) -> [T] {
    guard a.count > 1 else { return a }
    
    let mid = a[a.count/2]
    let less = getMatchElements(a, mid, <)
    let equal = a.filter { (value: T) -> Bool in return value == mid }
    let greater = a.filter { $0 > mid }
    
    return quicksort(less) + equal + quicksort(greater)
}

// Test QuickSort Function on Integers
var integerArray = [2, 3, 1, 5, 4, 6]
quicksort(integerArray)

// Test QuickSort Function on Characters
var characterArray = ["e", "d", "c", "b", "a"]
quicksort(characterArray)

// Test QuickSort Function on Strings
var stringArray = ["Karim", "Ahmed", "Ebrahem", "Ehab", "Mazen"]
quicksort(stringArray)

/* --------------------------------------------------- */

