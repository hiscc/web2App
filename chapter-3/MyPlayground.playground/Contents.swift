import UIKit

//var emptyString:String?
//
//print(emptyString)
//
//if  var emptyString:Int? = "3232" {
//  print(emptyString)
//}

//for c in "Dog!🐶1" {
//    print(c)
//}
//func findStockCode(company: String) -> String? {
//    if (company == "Apple") {
//        return "AAPL"
//    } else if (company == "Google") {
//        return "GOOG"
//    }
//
//    return nil
//}
//
//if var stockCode: String = findStockCode(company: "Facebook"){
//
//  let text = "Stock Code - "
//  let message = text + stockCode  // compile-time error
//  print(message)
//}

var completionHandlers: [() -> Void] = []
func someFunctionWithEscapingClosure(completionHandler: @escaping () -> Void) {
    completionHandlers.append(completionHandler)
}

func someFunctionWithNonescapingClosure(closure: () -> Void) {
    closure()
}

class SomeClass {
    var x = 10
    func doSomething() {
        someFunctionWithEscapingClosure { self.x = 100 }
//        someFunctionWithNonescapingClosure { x = 200 }
    }
}

let instance = SomeClass()
instance.doSomething()
print(instance.x)
// Prints "200"

completionHandlers.first?()
print(instance.x)
// Prints "100"



