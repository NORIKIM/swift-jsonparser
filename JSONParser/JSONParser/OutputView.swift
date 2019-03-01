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
    private static func dataStr(split: [String], method: ([String]) -> String) -> String {
        guard split[0].contains("{") else { return method(split) + " 데이터 중에" }
        return method(split) + " 객체 데이터 중에"
    }
    private static let totalDataStr = {(split: [String]) -> String in return "총 \(split.count)개의"}
    private static let included = "가 포함되어 있습니다."
    
    // 데이터의 개수에 따라 내용 출력
    static func printAData(_ json: JsonCollection, input: String) {
       
    }
    
    // 모든 데이터의 내용을 출력
    private static func printData(in JSON: [JsonValue], from splitInput: [String]) {
        
    }
}

