//
//  Chela.swift
//  Empty
//
//  Created by SeungChul Kang on 2018. 4. 17..
//  Copyright © 2018년 com.bsidesoft.ios. All rights reserved.
//

import Foundation
import UIKit

class BindVal {
    private let v: String
    init(_ k: String) {
        v = k
    }
    func val(_ kv: [String: Any]) -> Any? {

        if v.contains(".") {
            let t = v.split(separator: ".")
            let field = String(t.last!)
            let target = kv[String(t.first!)]
            // TODO: 미러 완성해보자.
            for child in Mirror.init(reflecting: target!).children {
                if child.label == field {
                    return child.value
                }
            }
        } else {
            return kv[v]
        }

        return v
    }
}

class ChelaBind {

    func parser(_ src: String) -> [String: String] {
        // src ->  click:k0,drag:k1,
        return src
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .split(separator: ",")
            .reduce([String: String]()) { (accu, curr) in
                var accu = accu
                let v = curr.trimmingCharacters(in: .whitespacesAndNewlines).split(separator: ":")
                accu[String(v[0])] = String(v[1])
                return accu
            }
    }
}

extension String  {
    var isInt: Bool {
        return !isEmpty && rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
    }
    var isFloat: Bool {
        // TODO: 살려줘...
        return false
    }
    var trim: String { return self.trimmingCharacters(in: .whitespaces) }
}

class DataBinding {

    let view: UIView
    init(_ v: UIView) {
        view = v
    }

    private var kv = [String: Any]()
    private var keys = Set<String>.init()
    private var events = [UIView: [String: String]]()
    private var props  = [UIView: [String: String]]()
    func addKey(_ k: String) {
        keys.insert(k)
    }
    func addEvent(_ v: UIView, _ e: [String: String]) {
        events[v] = e
    }
    func addProp(_ v: UIView, _ p: [String: String]) {
        props[v] = p
    }

    subscript(k: String) -> Any? {
        get{ return kv[k] }
        set{
            guard keys.contains(k) else { return }
            kv[k] = newValue
        }
    }

    private func parseVal(_ v: String) -> Any? {
//        ["정말 들어가나?", "normal"]
//        { "key1": "val1", "key2": 54345 }
//        "string", true, false, 1234

        switch v {
        case "true":  return true
        case "false": return false
        case let s where s.first == "\"":
            return String(s.dropFirst().dropLast())
        case let s where s.isInt:
            return Int(s)!
        case let s where s.isFloat:
            return Float(s)!
        case let s where s.first == "[":
            return String(s.dropFirst().dropLast())
                .split(separator: ",")
                .map { parseVal($0.trimmingCharacters(in: .whitespaces)) }
        case let s where s.first == "{":
            return String(s.dropFirst().dropLast())
                .split(separator: ",")
                .map { $0.trimmingCharacters(in: .whitespaces).split(separator: ":") }
                .reduce(NSMutableDictionary()) { (accu, curr) in
                    accu[String(curr[0]).trim] = parseVal(String(curr[1]).trim)
                    return accu
                }

        default:
            if v.contains(".") {
                let t = v.split(separator: ".")
                let field = String(t.last!)
                let target = kv[String(t.first!)]
                // TODO: 미러 완성해보자.
                for child in Mirror.init(reflecting: target!).children {
                    if child.label == field {
                        return child.value
                    }
                }
            } else {
                return kv[v]
            }

            return v
        }

    }

    func execute() {
        for k in keys {
            if kv[k] == nil {
                return
            }
        }
        let ev = events, pr = props, _kv = kv
        DispatchQueue.main.async {

//            title:["정말 들어가나?", "normal"]

            print("345354")

            for p in pr {
                let (view, dic) = p
                for d in dic {
                    let (k, v) = d

                    if let f = DataBinding.baseProp[k] ?? _kv[k] as? PropSetter,
                        let arg = self.parseVal(v) as? [Any?] {
                        f(view, arg.compactMap { $0 })
                    }
                }
            }

            for e in ev {
                let (view, dic) = e
                for d in dic {
                    let (k, v) = d
                    // k에는 event type이 들어있을 것이다.
                    // v값에는 click or a.click
                    if let listener = self.parseVal(v) as? UIControl.listener,
                        let ctrl = view as? UIControl {
                        ctrl.addTarget(DataBinding.evType[k]!, listener)
                    }
                }
            }

        }
    }

    private static let evType = [ "touchUpInside": UIControlEvents.touchUpInside ]

    enum `Type` {
        case prop
        case event
    }

    private static let ctrlState = [ "normal": UIControlState.normal ]

    typealias PropSetter = (UIView, [Any]) -> Void
    private static let baseProp: [String: PropSetter] = [
        "title": {
            guard
                let btn   = $0 as? UIButton,
                $1.count == 2,
                let title = $1[0] as? String,
                let key   = $1[1] as? String,
                let type  = DataBinding.ctrlState[key]
            else { return }

            btn.setTitle(title, for: type)
        }
    ]

    private static func _parse(_ v: String) -> Any? {

        switch v {
        case "true":  return true
        case "false": return false
        case let s where s.first == "\"":
            return String(s.dropFirst().dropLast())
        case let s where s.isInt:
            return Int(s)!
        case let s where s.isFloat:
            return Float(s)!
        case let s where s.first == "[":
            return String(s.dropFirst().dropLast())
                .split(separator: ",")
                .map { _parse($0.trimmingCharacters(in: .whitespaces)) }
        case let s where s.first == "{":
            return String(s.dropFirst().dropLast())
                .split(separator: ",")
                .map { $0.trimmingCharacters(in: .whitespaces).split(separator: ":") }
                .reduce(NSMutableDictionary()) { (accu, curr) in
                    accu[String(curr[0]).trim] = _parse(String(curr[1]).trim)
                    return accu
            }

        default:
            return BindVal.init(v)
        }

    }
    // 이 녀석이 완전체 JSON parser여야 한다.
    private static func parse(_ v: UIView, _ t: Type, _ s: String, _ binding: inout DataBinding) {

//        switch v {
//        case "true":  return true
//        case "false": return false
//        case let s where s.first == "\"":
//            return String(s.dropFirst().dropLast())
//        case let s where s.isInt:
//            return Int(s)!
//        case let s where s.isFloat:
//            return Float(s)!
//        case let s where s.first == "[":
//            return String(s.dropFirst().dropLast())
//                .split(separator: ",")
//                .map { parseVal($0.trimmingCharacters(in: .whitespaces)) }
//        case let s where s.first == "{":
//            return String(s.dropFirst().dropLast())
//                .split(separator: ",")
//                .map { $0.trimmingCharacters(in: .whitespaces).split(separator: ":") }
//                .reduce(NSMutableDictionary()) { (accu, curr) in
//                    accu[String(curr[0]).trim] = parseVal(String(curr[1]).trim)
//                    return accu
//            }
//
//        default:
//            if v.contains(".") {
//                let t = v.split(separator: ".")
//                let field = String(t.last!)
//                let target = kv[String(t.first!)]
//                // TODO: 미러 완성해보자.
//                for child in Mirror.init(reflecting: target!).children {
//                    if child.label == field {
//                        return child.value
//                    }
//                }
//            } else {
//                return kv[v]
//            }
//
//            return v
//        }

        var dic = [String: String]()
        for v in s.split(separator: ",").map ({ (s) -> (String, String) in

            let seq = s.trimmingCharacters(in: .whitespaces).split(separator: ":")
            let key = seq.first!.trimmingCharacters(in: .whitespaces)
            let val = seq.last!.trimmingCharacters(in: .whitespaces)

            var valKey = val
            if val.contains(".") {
                valKey = val.split(separator: ".").first! + ""
            }

            binding.addKey(valKey)

            return (key, val)

        }) {
            dic[v.0] = v.1
        }

        switch t {
        case .event: binding.addEvent(v, dic)
        case .prop:  binding.addProp(v, dic)
        }

    }

    static func of(_ view: UIView, _ isXibCache: Bool = true) -> DataBinding {

        var stack = [view]
        var binding = DataBinding(view)

        while !stack.isEmpty {
            var v = stack.removeLast()
            let type = v.csType

            if type != "" {

                var target: UIView!

                // nib
                if type.hasSuffix(".xib") {
                    target = loadXib(type, isXibCache)
                } else if let cls = NSClassFromString(type) as? UIView.Type {
                    target = cls.init()
                } else {
                    continue
                }

                target.copyProp(v)
                v.superview?.insertSubview(target, aboveSubview: v)
                v.removeFromSuperview()
                v = target

            }

            // "click:a.click, drag:b.drag"
            if v.csEvent != "" {
                parse(v, .event, v.csEvent, &binding)
            }

            if v.csProp != "" {
                parse(v, .prop, v.csProp, &binding)
            }

            if v.subviews.count > 0 {
                stack += v.subviews
            }

        }

        print(binding)

        return binding

    }

    private static var xibs = [String: UINib]()
    static func loadXib(_ n: String, _ isCache: Bool = false) -> UIView {
        var nib: UINib
        if isCache, let n = xibs[n] {
            nib = n
        } else {
            nib = UINib.init(nibName: n, bundle: nil)
            if isCache {
                xibs[n] = nib
            }
        }
        return nib.instantiate(withOwner: nil, options: nil).first as! UIView
    }
}
