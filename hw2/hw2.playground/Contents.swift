//: IS 543 HW2
//: Tyler Mabey
//: 11 Sep 2017

import UIKit

// 1. Compute the ith Fibonacci number (1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, …)
func fibonacci(number i: Int) -> Int {
    return i <= 1 ? 1 : fibonacci(number: i - 1) + fibonacci(number: i - 2)
}

fibonacci(number: 6)

//2. Compute n! (factorial) for integer n ≥ 0
func factorial(number n: Int) -> Int {
    return n <= 1 ? 1 : n * factorial(number: n - 1)
}

factorial(number: 5)
//3. Compute the sum of all integers between two given integers (inclusive)
func twoSum(first x: Int, second y: Int) -> Int {
    var answer: Int = 0
    for a in x ... y {
        answer += a
    }
    return answer
}

twoSum(first: 1, second: 5)
// 4. Given a number of cents, print to the console the corresponding U.S. coins that total to the given number.  Print the solution that needs the fewest coins.  Only use pennies, nickels, dimes, and quarters.  Example: for 113, the answer is “4 quarters”, “1 dime”, “3 pennies”.  Do not print the case where the solution calls for 0 of the coin (e.g. don’t print “0 nickels”).  Use the singular word is the value is 1, or the plural if the coin count is greater than 1.
func change(cents: Int) {
    var amountLeft = cents
    var numQuarters: Int
    var numDimes: Int
    var numNickels: Int
    var numPennies: Int
    var answer: String = ""
    
    // return the whole number of coins for a specific value
    func coinCount(value: Int) -> Int {
        return amountLeft / value
    }
    
    // return the leftover amount
    func leftover(amount: Int, value: Int) -> Int {
        return amount % value
    }
    
    // create the answer string
    func answerString(count: Int, single: String, plural: String) {
        if count == 1 {
            answer = answer + "\(count) \(single)"
        }
        else if count > 1 {
            answer = answer + "\(count) \(plural)"
        }
    }
    
    // add commas to the answer
    func addComma(next: Int) {
        if next > 0 {
            answer = "\(answer), "
        }
    }
    
    // quarters
    numQuarters = coinCount(value: 25)
    amountLeft = leftover(amount: amountLeft, value: 25)
    
    // dimes
    numDimes = coinCount(value: 10)
    amountLeft = leftover(amount: amountLeft, value: 10)
    
    // nickels
    numNickels = coinCount(value: 5)
    amountLeft = leftover(amount: amountLeft, value: 5)
    
    // pennies
    numPennies = coinCount(value: 1)
    amountLeft = leftover(amount: amountLeft, value: 1)
    
    answerString(count: numQuarters, single: "quarter", plural: "quarters")
    addComma(next: numDimes)
    
    answerString(count: numDimes, single: "dime", plural: "dimes")
    addComma(next: numNickels)

    answerString(count: numNickels, single: "nickel", plural: "nickels")
    addComma(next: numPennies)

    answerString(count: numPennies, single: "penny", plural: "pennies")
    
    print(answer)
}

change(cents: 41)





