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
    private static let typeNumber = "\\s[0-9]+|[0-9]+"
    private static let typeAny = "(\\{(?:(?:\\s*\"[\\w]+\"\\s*:\\s*[\"\\w\\s]+\\s*),*)*\\}|\"[\\w]+\"|[0-9]+|false|true)"
    
    // 입력 문자열에서 정규식으로 문자를 추출해 배열로 리턴
     static func matches(in string: String, by pattern: String) -> [String] {
        guard let regex = try? NSRegularExpression(pattern: pattern, options: []) else { return [] }
        let range = NSRange(string.startIndex..., in: string)
        let matches = regex.matches(in: string, options: [], range: range)
        return matches.map { String(string[Range($0.range, in: string)!]) }
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
        let matchedRegex = matches(in: text, by: regex)
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
        let matchedRegex = RegularExpression.matches(in: text, by: regex)
        let bool = Bool(matchedRegex[0])
        return bool!
        
    }
    
    // split 배열에서 큰따옴표가 있는 문자를 찾아서 정상문자열로 만들어 반환
    private static func stringCasting(text: String, regex: String) -> String {
        let matchedRegex = RegularExpression.matches(in: text, by: regex)
        return matchedRegex[0].components(separatedBy: ["\""]).joined()
    }
    
    // 문자열을 정규식으로 검사하기
    static func inspectRegex(by text: String) -> [JsonValue] {
        var data: [JsonValue] = []
        
        if containsMatch(of: typeNumber, inString: text) && text.contains("\"") == false {
            data.append(intCasting(text: text, regex: typeNumber))
        } else if containsMatch(of: typeBoolean, inString: text) {
            data.append(boolCasting(text: text, regex: typeBoolean))
        } else if containsMatch(of: typeString, inString: text) {
            data.append(stringCasting(text: text, regex: typeString))
        }
        return data
    }
    
    // for문으로 split을 돌면서 각 값을 [JsonValue]에 넣어 리턴
    static func makeJsonArr(_ splitInput: [String]) -> [JsonValue] {
        var data = [JsonValue]()
        for text in splitInput {
            let jsonValue = inspectRegex(by: text)
            data.append(jsonValue[0])
        }
        return data
    }
 
    // 객체 혹은 객체포함 배열을 분석하여 [String: JsonValue]로 리턴
    static func makeJsonDic(_ input: String) -> [String: JsonValue] {
        var data = [String: JsonValue]()
        let splitByComma = input.components(separatedBy: ",")
        for inners in splitByComma {
            let splitByColon = inners.components(separatedBy: ":")
            let key = matches(in: splitByColon[0], by: typeString)[0].trimmingCharacters(in: ["\""])
            let value = inspectRegex(by: splitByColon[1])

            data.updateValue(value[0], forKey: key)
        }
        return data
    }
    
    // 입력에 따른 JsonData생성
    static func object(_ input: String, _ splitInput: [String]) -> JsonCollection? {
        if CheckInput.hasCurlyBrace(input) && CheckInput.hasSqaureBracket(input) == false {
            return JSONDic.init(makeJsonDic(input))
        } 
        else if CheckInput.isObjArr(input) {
            let objArr = matches(in: input, by: typeAny)
            let jsonArr = JSONArr()
            var jsonDic = [String: JsonValue]()
            
            for str in objArr {
                jsonDic = makeJsonDic(str)
                jsonArr.values.append(jsonDic)
            }
            return jsonArr
        }
        else if CheckInput.isObjArr(input) == false {
            let jsonValArr = makeJsonArr(splitInput)
            let jsonArr = JSONArr()
            for inner in jsonValArr {
                jsonArr.values.append(inner)
            }
            return jsonArr
        }
        return nil
    }
    
    
}

