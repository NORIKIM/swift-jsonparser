//
//  JSONData.swift
//  JSONParser
//
//  Created by JINA on 08/01/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

class JSONArr: JsonCollection {
    var values: [JsonValue] = []
    
    init(_ values: JsonValue...) {
        self.values = values
    }
    
    func countData() -> [String : Int] {
        return CoundData.calculate(values)
    }
}

class JSONDic: JsonCollection {
    var data = [String : JsonValue]()
    
    init(_ data: [String: JsonValue]) {
        self.data = data
    }
    
    var json: [JsonValue] {
        var value = [JsonValue]()
        for val in data.values {
            value.append(val)
        }
        return value
    }
    
    func countData() -> [String : Int] {
        return CoundData.calculate(json)
    }
}

class CoundData {
    static func calculate(_ json: [JsonValue]) -> [String: Int] {
        var data = ["문자열" : 0, "숫자" : 0, "부울" : 0, "객체" : 0, "배열": 0]
        
        for value in json {
            if value.isSame(val: Dictionary<String,JsonValue>.self){
                data["배열"] = data["배열"]! + json.count / 2
            } else if value.isSame(val: Int.self) {
                data["숫자"] = data["숫자"]! + 1
            } else if value.isSame(val: Bool.self) {
                data["부울"] = data["부울"]! + 1
            } else if value.isSame(val: String.self) {
                data["문자열"] = data["문자열"]! + 1
            }  else { // 객체로 인식하도록 처리를 어떻게 해야 할지 모르겠습니다.
                data["객체"] = data["객체"]! + 1
            }
        }
        print(data)
        return data
    }
}
