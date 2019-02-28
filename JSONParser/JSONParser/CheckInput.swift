//
//  CheckInput.swift
//  JSONParser
//
//  Created by 김지나 on 20/01/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

enum ErrorMessage: Error {
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
    // 사용자의 입력 양 끝에 [] 확인
    static func hasSqaureBracket(_ input: String) -> Bool {
        return input.first == "[" && input.last == "]"
    }
    
    // 사용자의 입력에 { } 확인
    static func hasCurlyBrace(_ input: String) -> Bool {
        return input.contains("{") && input.contains("}")
    }
    
    //객체를 포함한 배열인지 확인
    static func isObjArr(_ input: String) -> Bool {
        if hasCurlyBrace(input) {
            return hasSqaureBracket(input)
        }
        return false
    }

}
