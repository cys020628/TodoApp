import UIKit

// 삼항 연산자, Terary Operator

let isMember:Bool = true

// if문 사용
if isMember == true {
    print("회원입니다.")
}else {
print("회원이 아닙니다.")
}

print("-------------------")


// 삼항 연산자 사용
print(isMember == true ? "회원입니다." : "회원이 아닙니다.")

// 조건 ? true 일때 : false 일때

let fee = isMember == true ? 1000 : 2000

print("가격 : \(fee)")
