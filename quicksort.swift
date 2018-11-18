

//u can run this in a playground

func quicksort(_ arrayToSort: [Int]) -> [Int] {
    
    if arrayToSort.count == 1 {
        return arrayToSort
    }
    
    let pivot = arrayToSort[arrayToSort.count - 1]
    
    let leftArray = arrayToSort.filter{ $0 < pivot }
    let rightArray = arrayToSort.filter { $0 > pivot }

    let leftSortedArray: [Int]
    if leftArray.count > 1 {
        leftSortedArray = quicksort(leftArray)
    } else {
        leftSortedArray = leftArray
    }
    
    let rightSortedArray: [Int]
    if rightArray.count > 1 {
        rightSortedArray = quicksort(rightArray)
    } else {
        rightSortedArray = rightArray
    }
    
    
    let result = concatenate(leftSortedArray,  [pivot], rightSortedArray)
    
    return result
    
}

func concatenate(_ arrays: [Int]...) -> [Int]{
    let result = arrays.flatMap{$0}
    return result
}

//usage
let s = quicksort([4123,4,23123,3123134531,123123,123,124,12,312,312,3,123,72364823741,123,12,31298731,211028731923,123,123123,5,654,574,5,46,75,734,234234234])
print(s)
