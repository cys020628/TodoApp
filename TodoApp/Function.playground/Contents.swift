import UIKit

// 함수(Fuction), 메서드(Method)

func sayHello() {
    print("안녕하세요.")
    print("반갑습니다.")
    print("\n")
}

sayHello()
sayHello()
sayHello()
sayHello()


struct Cat {
    let name :String // property
    let age:Int // property
    
    init(name: String) {
        self.name = name
        self.age = 1
    }
    
    func cry() { // method
        print("야옹야옹")
    }
}

Cat(name: "야옹").cry()

// 파라미터, 리턴값

// 매개변수, 파라미터
func add(number1:Int, number2:Int) -> Int {
    // print(number1 + number2)
    return number1 + number2
}

add(number1: 2, number2: 3)

print(add(number1: 10, number2: 20) + 5)

print(add(number1: add(number1: 20, number2 : 30), number2: 50))

//

