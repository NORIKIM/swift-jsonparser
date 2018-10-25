//
//  JSONGenerator.swift
//  JSONParser
//
//  Created by 윤지영 on 18/10/2018.
//  Copyright © 2018 JK. All rights reserved.
//

import Foundation

struct JSONParser {
    private static func typeCast(from string: String) -> JSONValue? {
        if string.hasDoubleQuotation() { return JSONValue.string(string.trimDoubleQuotation()) }
        if let int = Int(string) { return JSONValue.int(int) }
        if let bool = Bool(string) { return JSONValue.bool(bool) }
        return nil
    }
    
    private static func extractKeyValue(from jsonValue: String) -> (key: String, value: JSONValue?)? {
        guard jsonValue.contains(":") else { return nil }
        let objectKeyValue = jsonValue.splitByColon().map({ $0.trimWhiteSpaces() })
        guard objectKeyValue.count > 1 else { return nil }
        guard objectKeyValue[0].hasDoubleQuotation() else { return nil }
        let key: String = objectKeyValue[0].trimDoubleQuotation()
        let value: JSONValue? = typeCast(from: objectKeyValue[1])
        return (key, value)
    }
    
    private static func makeJSONObject(from jsonString: String) -> [String: JSONValue]? {
        var jsonObject = [String: JSONValue]()
        let jsonStringTrimmedBrackets = jsonString.trimWhiteSpaces().trimCurlyBrackets()
        let jsonValues = jsonStringTrimmedBrackets.splitByComma()
        for jsonValue in jsonValues {
            guard let keyValue = extractKeyValue(from: jsonValue) else { return nil }
            guard let value: JSONValue = keyValue.value else { continue }
            jsonObject[keyValue.key] = value
        }
        return jsonObject
    }
    
    private static func makeJSONArray(from jsonString: String) -> [JSONValue]? {
        var jsonArray = [JSONValue]()
        let jsonStringTrimmedBrackes = jsonString.trimWhiteSpaces().trimSquareBrackets()
        let str = jsonStringTrimmedBrackes
        
        var iterateIndex = str.startIndex
        var sliceIndex = str.startIndex
        while(iterateIndex != str.endIndex) {
            if (str[iterateIndex]==",") {
                let a = String(str[sliceIndex..<iterateIndex])
                guard let b = typeCast(from: a.trimWhiteSpaces()) else { continue }
                jsonArray.append(b)
                sliceIndex = str.index(after: iterateIndex)
                iterateIndex = str.index(after: iterateIndex)
                continue
            } else if (str[iterateIndex]=="{") {
                let a = str[iterateIndex...]
                guard let b = a.firstIndex(of: "}") else { return nil }
                let c = String(str[sliceIndex...b])
                guard let d = makeJSONObject(from: c) else { return nil}
                jsonArray.append(JSONValue.object(d))
                iterateIndex = str.index(after: str[b...].firstIndex(of: ",") ?? b)
                sliceIndex = iterateIndex
                continue
            } else if (iterateIndex==str.index(before: str.endIndex)) {
                let a = String(str[sliceIndex...])
                guard let b = typeCast(from: a.trimWhiteSpaces()) else { continue }
                jsonArray.append(b)
                iterateIndex = str.index(after: iterateIndex)
                continue
            }
            iterateIndex = str.index(after: iterateIndex)
        }
        return jsonArray
    }
    
    static func parse(_ jsonString: String) -> JSONDataForm? {
        if jsonString.hasSideSquareBrackets() {
            guard let jsonArray = makeJSONArray(from: jsonString) else { return nil }
            return JSONArray.init(jsonArray: jsonArray)
        }
        if jsonString.hasSideCurlyBrackets() {
            guard let jsonObject = makeJSONObject(from: jsonString) else { return nil }
            return JSONObject.init(jsonObject: jsonObject)
        }
        return nil
    }
}
