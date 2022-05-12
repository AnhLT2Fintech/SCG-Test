import Foundation

func findIndexOfPivod(_ array: [Int]?) -> String {
    guard let validArray = array else { return "Invalid array" }
    if validArray.count < 3 { // A valid array will have at least 3 elements
        return "index not found"
    }
    
    let lastIndex = validArray.count - 1
    var leftSum: [Int] = validArray
    var rightSum: [Int] = validArray
    
    leftSum[0] = validArray[0]
    rightSum[lastIndex] = validArray[lastIndex]
    
//    Check each element of the array in turn and sum the elements to the right and left of the element you are checking
    var currentIndex = 1
    while currentIndex < lastIndex {
        let sum = leftSum[currentIndex - 1] + validArray[currentIndex]
        leftSum[currentIndex] = sum
        currentIndex += 1
    }
    
    currentIndex = lastIndex - 1
    while currentIndex > 0 {
        let sum = rightSum[currentIndex + 1] + validArray[currentIndex]
        rightSum[currentIndex] = sum
        currentIndex -= 1
    }
    
    for i in 1..<lastIndex {
        if leftSum[i] == rightSum[i] {
            return "middle index is \(i)"
        }
    }
    return "index not found"
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

