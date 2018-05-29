//
//  Net.swift
//  Empty
//
//  Created by SeungChul Kang on 2018. 5. 16..
//  Copyright © 2018년 com.bsidesoft.ios. All rights reserved.
//

import Foundation

typealias NetWatcher = (NetResult) -> Void
/// Util
class Net {

    enum Status {
        case invalid
        case ok
        case fail
        case timeout
        case redirect
    }

    static private var apiJSON = [String: NetJSON]()
    static func addJSON(_ k: String, _ j: NetJSON) {
        Net.apiJSON[k] = j
    }
    static func json(_ k: String, body: [String: Any], complete: NetWatcher) {
        apiJSON[k]?.json(k, body: body, complete: complete)
    }
    static func http(r: NetResult, method: String, url: String, body: String, header: [String: String], complete: NetWatcher) {
        // HTTP통신 후 complete에게 NetResult를 넘겨준다.
        // r.response(status, body, header)
    }
}

func jsonVal(_ k: String, _ t: [String: Any]) -> Any {
    guard !k.contains(".") else { return t[k]! }

    var target = t
    let splited = k.split(separator: ".").map { String($0) }
    let key = splited.dropLast().joined()
    splited.forEach {
        if let a = target[$0] as? [String: Any] {
            target = a
        }
    }

    return target[key]!

}
class NetJSON {
    var header = [String: String]()
    var vali = [String: Vali]()
    let url: String
    init(_ u: String, prop: [String: Any]) {
        url = u
        header["Content-Type"] = "application/json"
        prop.forEach {
            let (k, v) = $0
            switch v {
            case let v as String: header[k] = v
            case let v as Vali:   vali[k] = v
            default: break
            }
        }
    }
    func json(_ k: String, body: [String: Any], complete: NetWatcher) {
        let r = NetResult.init()
        vali.forEach {
            let (k, v) = $0
            // k = "items.0.title"
            r.addVali(k, v, jsonVal(k, body))
        }
    }
}

class NetResult {
    var status = Net.Status.ok
    var valiResult = [String: String]()
    func addVali(_ k: String, _ v: Vali, _ val: Any) {
        if let msg = v.check(val) {
            valiResult[k] = msg
            status = .invalid
        }
    }
    func response(status: Int, body: Any?, header: Any?) {
    }
}
