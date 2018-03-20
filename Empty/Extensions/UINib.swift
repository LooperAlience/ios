//
//  UINib.swift
//  Empty
//
//  Created by SeungChul Kang on 2018. 3. 15..
//  Copyright © 2018년 com.bsidesoft.ios. All rights reserved.
//

import Foundation
import UIKit

extension UINib {

    /// 타입과 동일한 이름의 xib 파일로부터 view를 얻는다.
    /// ```
    /// let v: ExampleView! = UINib.view()
    /// ```
    ///
    /// - Parameter bundle: bundle
    /// - Returns: 얻고자 하는 view
    static func instantiate<T>(bundle: Bundle? = nil) -> T? {
        let view: T? = self.instantiate(nibName: "\(T.self)", bundle: bundle)
        return view
    }

    /// xib 파일로부터 view를 얻는다.
    /// ```
    /// let v: ExampleView! = UINib.view("Nib.Exmaple.View")
    /// ```
    ///
    /// - Parameter nibName:
    /// - Parameters:
    ///   - nibName: nib file name
    ///   - bundle: bundle
    /// - Returns: 얻고자 하는 view
    static func instantiate<T>(nibName: String, bundle: Bundle? = nil) -> T? {
        let view = self.init(nibName: nibName, bundle: nil)
                       .instantiate(withOwner: nil, options: nil)[0]
        return view as? T
    }

}
