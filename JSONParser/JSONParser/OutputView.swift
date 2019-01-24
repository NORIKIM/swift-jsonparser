////
////  OutputView.swift
////  JSONParser
////
////  Created by JINA on 07/01/2019.
////  Copyright © 2019 JK. All rights reserved.
////
//
import Foundation

struct OutputView {
    private static let totalDataStr = { (splitInput:[String]) -> String in return "총 \(splitInput.count)개의 데이터 중에" }
    private static let included = "가 포함되어 있습니다."
    
    // 데이터의 개수에 따라 내용 출력
    static func printData(in JSON: JSONArr, from splitInput: [String]) {
        let dataDic = CountData().countData(in: JSON, from: splitInput)
        let bool = dataDic["부울"]! > 0 && dataDic["문자열"]! == 0 && dataDic["숫자"]! == 0
        let string = dataDic["부울"]! == 0 && dataDic["문자열"]! > 0 && dataDic["숫자"]! == 0
        let int = dataDic["부울"]! == 0 && dataDic["문자열"]! == 0 && dataDic["숫자"]! > 0
        
        switch (bool,string,int) {
            case (true, _, _):
                print("\(totalDataStr(splitInput)) 부울 \(dataDic["부울"]!)개\(included)")
            case (_, true, _):
                print("\(totalDataStr(splitInput)) 문자열 \(dataDic["문자열"]!)개\(included)")
            case (_, _, true):
                print("\(totalDataStr(splitInput)) 숫자 \(dataDic["숫자"]!)개\(included)")
            default:
                printDatas(in: JSON, from: splitInput)
            }
            print("")
    }
    
    // 모든 데이터의 내용을 출력
    private static func printDatas(in JSON: JSONArr, from splitInput: [String]) {
        let dataDic = CountData().countData(in: JSON, from: splitInput)
        var datas = ""
        for (key,value) in dataDic {
            if value != 0 {
                datas.append("\(key) \(value)개, ")
            }
        }
        print("\(totalDataStr(splitInput)) \(datas.dropLast(2))\(included)")
    }
}

