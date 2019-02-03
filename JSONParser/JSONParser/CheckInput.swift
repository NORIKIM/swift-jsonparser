//
//  CheckInput.swift
//  JSONParser
//
//  Created by 김지나 on 20/01/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

enum ErrorMessage: Error {
    case whiteSpace
    case reEntered
    var description: String {
        switch(self) {
        case .reEntered: return """
                                1. 숫자, 문자, 부울만 가능합니다.
                                2. 입력값 사이사이 공백을 입력합니다.
                                3. 콤마로 구문하여 입력합니다.
                                """
        }
    }
}

struct CheckInput {
    // 사용자의 입력에 공백이 있는지 확인
    static func hasWhiteSpace(_ input: String) -> Bool {
        var comma = 0
        var colon = 0
        var whiteSpace = 0
        
        for index in input {
            switch index {
            case ",":
                comma += 1
            case ":":
                colon += 1
            case " ":
                whiteSpace += 1
            default:
                break
            }
        }
        return whiteSpace == comma + 2 || whiteSpace == (3 * colon) + 2
    }
    
    // 사용자의 입력 양 끝에 [] 확인
    static func hasSqaureBracket(_ input: String) -> Bool {
        return input.contains("[") && input.contains("]")
    }
    
    // 사용자의 입력에 { } 확인
    static func hasCurlyBrace(_ input: String) -> Bool {
        return input.contains("{") && input.contains("}")
    }

}
