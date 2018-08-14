//
//  ChelaModel.swift
//  Empty
//
//  Created by SeungChul Kang on 2018. 7. 17..
//  Copyright © 2018년 com.bsidesoft.ios. All rights reserved.
//

import Foundation

class ChelaModel {
    private class Container {
        private var model: ChelaModel?
        private var list: [Any]?
        private var map: [String: Any]?
        private var key: String?
        private func isInited(_ m: ChelaModel?, _ k: String) -> Bool {
            model = m
            key = k
            if k.contains(".") {
                let keys = k.split(separator: ".")
                for key in keys {
                    if !isChanged(String(key)) { return false }
                }
                if let lastKey = keys.last {
                    key = String(lastKey)
                }
            }
            return true
        }
        func isSet(_ m: ChelaModel?, _ k: String, _ v: Any) -> Bool {
            switch (m) {
            case _ where !isInited(m, k): return false
            case let model?: model.data[k] = v;
            case _ where list != nil: list!.insert(v, at: Int(k)!)
            case _ where map != nil: map![k] = v
            default: return false
            }
            return true
        }
        func val(_ m: ChelaModel?, _ k: String) -> Any? {
            return isInited(m, k) ? val(key) : nil
        }
        private func isChanged(_ key: String) -> Bool {
            guard let v = val(key) else { return false }
            switch true {
            case _ where v is ChelaModel: model = v as? ChelaModel
            case _ where v is [Any]: list = v as? [Any]
            case _ where v is [String: Any]: map = v as? [String: Any]
            default: return false
            }
            return true
        }
        private func val(_ k: String?) -> Any? {
            guard let k = k else { return nil }
            var v: Any? = nil
            switch true {
            case _ where model != nil:
                v = model?.data[k]
                model = nil
            case _ where list != nil:
                v = list?[Int(k)!]
                list = nil
            case _ where map != nil:
                v = map?[k]
                map = nil
            default: return nil
            }
            return v
        }
    }
    static private let con = Container()
    static func get() -> ChelaModel { return ChelaModel() }
    private var data = [String: Any]()
    private func val<T>(_ k: String) -> T? { return ChelaModel.con.val(self, k) as? T }
}
