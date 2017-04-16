
var numbers = [-1, 3, -4, 5, 1, -6, 2, 1]

func getSumOfArray (_ array: [Int]) -> Int {
    var sumOfArray = 0
    for number in array {
        sumOfArray += number
    }
    return sumOfArray
}

func getSumBeforeIndex (_ array: [Int],_ index: Int) -> Int {
    var sumBeforeIndex = 0
    for counter in 0..<array.count where counter < index {
        sumBeforeIndex += array[counter]
    }
    return sumBeforeIndex
}

func getSumAfterIndex (_ array: [Int],_ index: Int) -> Int {
    var sumAfterIndex = 0
    for counter in 0..<array.count where counter > index {
        sumAfterIndex += array[counter]
    }
    return sumAfterIndex
}

//var sumOfArray = getSumOfArray(numbers)
//var sumBeforeIndex = getSumBeforeIndex(numbers, 1)
//var sumAfterIndex = getSumAfterIndex(numbers, 1)

func check (_ array: [Int]) -> (Bool, Int) {
    var sumBeforeIndex = 0
    var sumAfterIndex = getSumOfArray(array)
    for index in 0..<array.count {
        sumAfterIndex -= array[index]
        if sumBeforeIndex == sumAfterIndex {
            return (true, index)
        }
        sumBeforeIndex += array[index]
    }
    return (false, -1)
}

var isIt = check(numbers)




