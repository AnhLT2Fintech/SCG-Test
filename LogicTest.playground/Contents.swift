import Foundation

func findIndexOfPivod(_ array: [Int]?) -> String {
    guard let validArray = array else { return "Invalid array" }
    if validArray.count < 3 { // A valid array will have at least 3 elements
        return "index not found"
    }
    
    //MARK: - Option 1
//    var leftIndex: Int = 0
//    var rightIndex: Int = validArray.count - 1
//    var leftSum: Int = validArray[leftIndex]
//    var rightSum: Int = validArray[rightIndex]
//// Sum the elements from left to right in turn until the sum is equal or iterate through the array
//    while leftIndex < rightIndex {
//        if leftSum == rightSum, leftIndex + 2 == rightIndex {
//            leftIndex += 1
//            return "middle index is \(leftIndex)"
//        }
//
//        if leftSum < rightSum {
//            leftIndex += 1
//            leftSum += validArray[leftIndex]
//        } else {
//            rightIndex -= 1
//            rightSum += validArray[rightIndex]
//        }
//    }
//
//    return "index not found";
   
    //MARK: - Option 2
    var leftSum: Int = 0
    var rightSum: Int = 0
    let lastIndex = validArray.count - 1

    // Check each element of the array in turn and sum the elements to the right and left of the element you are checking
    for i in 1..<lastIndex {
        leftSum = 0
        for j in 0..<i {
            leftSum += validArray[j]
        }
        
        rightSum = 0
        for j in (i + 1)...lastIndex {
            rightSum += validArray[j]
        }
        
        if leftSum == rightSum {
            return "middle index is \(i)"
        }
    }
    
    return "index not found";
}

func detectPalindromeString(_ string: String?) -> String {
    guard let validString = string else { return "Invalid string" }
    let lowerChars = Array(validString.lowercased())
    let lastIndex = lowerChars.count - 1
    let middleIndex = lastIndex / 2
    var isPalindrome: Bool = true
    
    // Just check half of the array to find the result
    for i in 0...middleIndex {
        if lowerChars[i] != lowerChars[lastIndex - i] {
            isPalindrome = false
            break
        }
    }
    
    return isPalindrome ? "\(validString) is a palindrome" : "\(validString) isn't a palindrome"
}

print("1. Find the index of pivod in array:")
print(findIndexOfPivod([1, 3, 5, 7, 9]))
print(findIndexOfPivod([3, 6, 8, 1, 5, 10, 1, 7]))
print(findIndexOfPivod([3, 5, 6]))
//print(findIndexOfPivod([20,-10,-15,6,5,-10]))
//print(findIndexOfPivod([0,0,10,-25,-5,20]))

print("2. Detect palindrome string:")
print(detectPalindromeString("aka"))
print(detectPalindromeString("Level"))
print(detectPalindromeString("Hello"))

