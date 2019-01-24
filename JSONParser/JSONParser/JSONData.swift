//
//  JSONData.swift
//  JSONParser
//
//  Created by JINA on 08/01/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

class JSONArr {
    var values: [JsonValue] = []
    
    init(_ values: JsonValue...) {
        self.values = values
    } 
}

class JSONDic {
    var key = [String]()
    var value = JSONArr().values
    var data = [String : JsonValue]()
    
    init() {
        for i in 0 ..< min(key.count,value.count) {
            data[key[i]] = value[i]
        }
    }

//    init(key:String, value:JsonValue) {
//        self.dic = [key : value]
//    }

}

// 입력된 데이터의 개수를를 딕셔너리에 저장하여 리턴
class CountData {
    var data = [String : Int]()
    init() {
        self.data = ["문자열" : 0, "숫자" : 0, "부울" : 0]
    }
    
    func countData(in JSON: JSONArr, from splitInput: [String]) -> [String : Int] {
        for value in JSON.values {
            if value.isSame(val: String.self) {
                data["문자열"] = data["문자열"]! + 1
            } else if value.isSame(val: Int.self) {
                data["숫자"] = data["숫자"]! + 1
            } else if value.isSame(val: Bool.self) {
                data["부울"] = data["부울"]! + 1
            }
        }
        return data
    }
    
}
