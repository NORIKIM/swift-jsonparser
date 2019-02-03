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
        print(ErrorMessage.reEntered.description)
        return
    }
    
    
    if CheckInput.hasCurlyBrace(input) {
        let makeJsonDic = RegularExpression.makeJsonDic(split: splitInput)
        OutputView.printData(in: makeJsonDic.value, from: splitInput)
    } else {
        let makeJsonArr = RegularExpression.makeJsonArr(split: splitInput)
        OutputView.printData(in: makeJsonArr.values, from: splitInput)
    }

}

while true {
    main()
} 

