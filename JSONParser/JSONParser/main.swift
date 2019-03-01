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
    let splitInput = InputView.splitInput(input)
    let jsonCollection = RegularExpression.object(input, splitInput)?.countData()
}

while true {
    main()
} 

/*
 현재 결과에 대한 출력은 기존에 작성했던 코드를 다시 짜야 할거 같아서 삭제한 상태이고,
 입력이 객체로 들어왔을 때 객체의 개수 체크를 못 하고 있습니다.
 코드 자체도 지저분하고 일단 객체를 제외한 결과 정도만 나오도록만 완성한 상태입니다.

 출력 부분 설계도 아직 제대로 정리하지 못한 상태라 시간이 부족할 것으로 판단되어 중단하였습니다.
 3일에 기사 시험까지 있어서 미션에 시간을 전부 투자하지 못했습니다...
 
 저에 대한 문제점, 코드에 대한 문제점 모두 마구마구 피드백 부탁드립니다....
 */
