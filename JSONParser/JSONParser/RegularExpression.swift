//
//  RegularExpression.swift
//  JSONParser
//
//  Created by JINA on 03/01/2019.
//  Copyright © 2019 JK. All rights reserved.
//

import Foundation

struct RegularExpression {
    private static let typeBoolean = "(false|true)"
    private static let typeString = "\"{1}+[A-Z0-9a-z\\s]+\"{1}"
    private static let typeNumber = "\\s[0-9]+"
    
    // 입력 문자열에서 정규식으로 문자를 추출해 배열로 리턴
    private static func matches(for regex: String, in text: String) -> [String] {
        let regex = try! NSRegularExpression(pattern: regex)
        let results = regex.matches(in: text, range: NSRange(text.startIndex..., in: text))
        return results.map { String(text[Range($0.range, in: text)!]) }
    }
    
    // 정규식의 문자열 추출 결과 확인
    private static func containsMatch(of pattern: String, inString string: String) -> Bool {
        guard let regex = try? NSRegularExpression(pattern: pattern, options: []) else {
            return false
        }
        let range = NSRange(string.startIndex..., in: string)
        return regex.firstMatch(in: string, options: [], range: range) != nil
    }
    
    // split 배열에서 문자열 숫자를 숫자로 형변환
    private static func intCasting(text: String, regex: String) -> Int {
        let matchedRegex = matches(for: regex, in: text)
        var int = 0
        if matchedRegex[0].contains(" ") {
            int = Int(matchedRegex[0].dropFirst(1)) ?? 0
        } else {
            int = Int(matchedRegex[0]) ?? 0
        }
        return int
    }
    
    // split 배열에서 문자열 부울을 부울로 형변환
    private static func boolCasting(text: String, regex: String) -> Bool {
        let matchedRegex = RegularExpression.matches(for: regex, in: text)
        let bool = Bool(matchedRegex[0])
        return bool!
        
    }
    
    // split 배열에서 큰따옴표가 있는 문자를 찾아서 정상문자열로 만들어 반환
    private static func stringCasting(text: String, regex: String) -> String {
        let matchedRegex = RegularExpression.matches(for: regex, in: text)
        return matchedRegex[0].components(separatedBy: ["\""]).joined()
    }
    
    // 문자열을 정규식으로 검사하기
    static func inspectRegex(by text: String) -> [JsonValue] {
        var data: [JsonValue] = []
            if containsMatch(of: typeNumber, inString: text) {
                data.append(intCasting(text: text, regex: typeNumber))
            } else if containsMatch(of: typeBoolean, inString: text) {
                data.append(boolCasting(text: text, regex: typeBoolean))
            } else if containsMatch(of: typeString, inString: text) {
                data.append(stringCasting(text: text, regex: typeString))
            }
        return data
    }
    
    // for문으로 split을 돌면서 각 값을 JSONArr에 넣어 리턴
    static func makeJsonArr(split: [String]) -> JSONArr {
        let data = JSONArr()
        for text in split {
            let jsonValue = inspectRegex(by: text)
            data.values.append(jsonValue[0])
        }
        return data
    }
 
    // JSONDic에 값 넣어주기
    static func makeJsonDic(split: [String]) -> JSONDic {
        var dataKey = [String]()
        var dataValue = [JsonValue]()
        
        for indexs in split {
            // split의 원소에 접근하여 콜론 앞의 문자열을 JSONDic의 key에 넣는다
            let key = indexs[indexs.index(after: indexs.startIndex) ..< indexs.index(before: indexs.index(of: ":")!)]
            dataKey.append(String(key))
            
            // inspectRegex로 얻은 jsonValue를 JSONDic의 value에 넣는다
            let value = indexs[indexs.index(after: indexs.index(of: ":")!) ... indexs.index(before: indexs.endIndex)]
            let jsonValue = inspectRegex(by: String(value))
            dataValue.append(jsonValue[0])
        }
      return JSONDic(key: dataKey, value: dataValue)
    }
    
}

