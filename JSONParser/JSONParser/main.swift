//
//  main.swift
//  JSONParser
//
//  Created by JK on 10/10/2017.
//  Copyright © 2017 JK. All rights reserved.
//

import Foundation

func main() {
    let input = InputView.readInput()
    let splitInput = InputView.splitInput(input) // ["{ \"name\" : \"KIM JUNG\"", " \"alias\" : \"JK\"", " \"level\" : 5", " \"married\" : true }"]
    
    guard CheckInput.hasWhiteSpace(input) else {
        print(ErrorMessage.whiteSpace.description)
        return
    }
    
    if CheckInput.hasCurlyBrace(input) {
        _ = RegularExpression.makeJsonDic(split: splitInput)
    } else {
        _ = RegularExpression.makeJsonArr(split: splitInput)
    }

    let regex = RegularExpression.makeJsonArr(split: splitInput)
        
    OutputView.printData(in: regex, from: splitInput) // 총 4개의 데이터 중에 숫자 1개, 부울 1개, 문자열 2개가 포함되어 있습니다.
}

while true {
    main()
} 

