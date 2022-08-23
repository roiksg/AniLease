//
//  StringParser.swift
//  AniLease
//
//  Created by VironIT on 23.08.22.
//

import Foundation

class StringParser {
    
    func getERAndSPEpisods(_ text: String) -> String {
        
        var boolStringFirst: Bool = false
        var boolStringSecond: Bool = false
        var boolStringHevc: Bool = false
        var boolstringSecondV2: Bool = false
        var endSet: Bool = false
        
        var valueString: String = ""
        
        let stringFirst: [Character] = [" ", "-", " "]
        let stringSecond: [Character] = ["[","1","0","8","0","p","]"]
        let stringHEVC: [Character] = ["(","H","E","V","C",")"]
        let stringSecondV2: [Character] = ["(","1","0","8","0","p",")"]
        
        var episods: String = ""
        var i: Int = 0
        var x: Int = 0
        
        text.forEach {
            if episods == "" {
                if ($0 == stringFirst[i] && boolStringFirst == false) {
                    i += 1
                    if i == 3 {
                        boolStringFirst = true
                        boolStringSecond = true
                        boolstringSecondV2 = true
                        boolStringHevc = true
                        i = 2
                    }
                }
                else if boolStringFirst == true && $0 != "[" && $0 != "(" && endSet == false {
                    if $0 == "-" {
                        i = 2
                        boolStringFirst = false
                        boolStringSecond = false
                        boolStringHevc = false
                        boolstringSecondV2 = false
                        valueString = ""
                    }
                    else {
                        valueString += String($0)
                    }
                }
                else if $0 == stringSecond[x] && boolStringSecond == true {
                    endSet = true
                    if x < stringSecond.count {
                        x += 1
                    }
                    if x == 7 {
                        episods = valueString
                    }
                }
                else if $0 == stringSecondV2[x] && boolstringSecondV2 == true {
                    boolStringSecond = false
                    endSet = true
                    if x < stringSecondV2.count {
                        x += 1
                    }
                    if x == 7 {
                        episods = valueString
                    }
                }
                else if $0 == stringHEVC[x] && boolStringHevc == true{
                    boolStringSecond = false
                    boolstringSecondV2 = false
                    endSet = true
                    if x < stringHEVC.count {
                        x += 1
                    }
                    if x == 6 {
                        episods = valueString
                    }
                }
                else {
                    boolStringFirst = false
                    boolStringSecond = false
                    boolstringSecondV2 = false
                    boolStringHevc = false
                    endSet = false
                    i = 0
                    valueString = ""
                }
            }
        }
        return episods
    }
    
    func getLiveChartEpisods (_ text: String) -> String {
        var startWrite: Bool = false
        var textValue: String = ""
        
        text.forEach {
            if $0 == "#" {
                startWrite = true
                textValue = ""
            }
            if startWrite == true {
                textValue += String($0)
            }
        }
        textValue.removeFirst()
        return textValue
    }
}
