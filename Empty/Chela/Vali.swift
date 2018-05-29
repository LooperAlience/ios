//
//  Vali.swift
//  Empty
//
//  Created by SeungChul Kang on 2018. 5. 16..
//  Copyright © 2018년 com.bsidesoft.ios. All rights reserved.
//

import Foundation
class Rule: Hashable {
    static let FAIL = "239047uylka12631786bfjkel572384yerufdhsjckxz1%^$%&"
    var hashValue: Int = 0

    static func == (lhs: Rule, rhs: Rule) -> Bool {

        /// <#Description#>
        return true
    }

    init(_ arg: [Any]? = nil) {

    }
    /// - Returns: 문제 있으면 *특수한 문자열* FAIL을 반환, 없으면 문자열 또는 nil
    func check(_ v: Any) -> String? {
        return nil
    }
}

class Vali {
    static let OR = Rule.init()
    var rules = [Rule: String]()
    ///
    ///
    /// - Parameter v: <#v description#>
    /// - Returns: 문제 있으면 String, 없으면 nil
    func check(_ v: Any) -> String? {
        var val = v
        var msg = "", prev = ""
        var prevR: Rule?
        for (rule, msg) in rules {
            if rule == Vali.OR {

            } else {
//                if 
            }
//oneline|truncate[99]|min_length[1]
        }
        return nil
    }
    // 다수의 rule set을 받는다.
    init(_ r: [Rule: String]) {
        rules = r
    }
}

