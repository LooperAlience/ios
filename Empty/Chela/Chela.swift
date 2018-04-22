//
//  Chela.swift
//  Empty
//
//  Created by SeungChul Kang on 2018. 4. 17..
//  Copyright © 2018년 com.bsidesoft.ios. All rights reserved.
//

import Foundation
import UIKit


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

class Chela {
    func scan(_ view: UIView) {
        var stack = [view]

        while !stack.isEmpty {
            var v = stack.removeLast()
            var type = v.csType


            if type != "" {

                var target: UIView!

                // nib
                if type.hasSuffix(".xib") {
                    target = loadXib(type)
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

            if v.csEvent != "" {

            }

        }

    }

    func loadXib(_ n: String) -> UIView {
        return UIView.init()
    }
}
