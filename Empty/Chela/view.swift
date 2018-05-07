//
//  view.swift
//  Empty
//
//  Created by SeungChul Kang on 2018. 4. 17..
//  Copyright © 2018년 com.bsidesoft.ios. All rights reserved.
//

import Foundation
import UIKit

class Props {
    var event = ""
    var prop = ""
    var type = ""
}

extension UIView {

    private static let csProps = NSMutableDictionary()
    private static func getProps(_ v: UIView) -> Props {
        let hash = v.hash
        if csProps[hash] == nil {
            csProps[hash] = Props()
        }
        return csProps[hash] as! Props
    }
    @IBInspectable var csEvent: String {
        get { return UIView.getProps(self).event }
        set { UIView.getProps(self).event = newValue }
    }
    @IBInspectable var csProp: String {
        get { return UIView.getProps(self).prop }
        set { UIView.getProps(self).prop = newValue }
    }
    @IBInspectable var csType: String {
        get { return UIView.getProps(self).type }
        set { UIView.getProps(self).type = newValue }
    }

    func copyProp(_ src: UIView) {
        csType = src.csType
        csProp = src.csProp
        csEvent = src.csEvent
        frame = src.frame
        src.subviews.forEach { self.addSubview($0) }

        if src.constraints.isEmpty {
            autoresizingMask = src.autoresizingMask
        } else {
            autoresizingMask = .flexibleWidth
            translatesAutoresizingMaskIntoConstraints = src.translatesAutoresizingMaskIntoConstraints

            addConstraints(
                src.constraints.compactMap { c in
                    var f = c.firstItem as? UIView
                    var s = c.secondItem as? UIView

                    if f == src { f = self }
                    if s == src { s = self }

                    guard let _f = f else { return nil }

                    return NSLayoutConstraint.init(
                        item: _f, attribute: c.firstAttribute, relatedBy: c.relation,
                        toItem: s, attribute: c.secondAttribute, multiplier: c.multiplier, constant: c.constant
                    )
                }
            )

        }
    }
}
