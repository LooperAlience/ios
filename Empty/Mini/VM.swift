//
//  VM.swift
//  Empty
//
//  Created by SeungChul Kang on 2018. 4. 3..
//  Copyright © 2018년 com.bsidesoft.ios. All rights reserved.
//

import Foundation
import UIKit

class VM: NSObject {
    static let KEY = "&^$%#@&$*(&^%$#@%"
    private var dic = NSMutableDictionary()
    private let vc: UIViewController
    let navStack = NSMutableArray()
    var parent: UINavigationController?
    var container: UIViewController? {
        return vc.parent ?? parent
    }
    init(_ c: UIViewController) {
        vc = c
    }

    subscript(k: String) -> Any? {
        get           { return dic[k] }
        set(newValue) { dic[k] = newValue }
    }

    func prop<T>(_ k: String) -> T? { return dic[k] as? T }

    func str(_ k: String) -> String?  { return prop(k) }
    func int(_ k: String) -> Int?     { return prop(k) }
    func float(_ k: String) -> Float? { return prop(k) }
    func bool(_ k: String) -> Bool?   { return prop(k) }
    func listener(_ k: String) -> UIControl.listener? { return prop(k) }

    func save() {
        UserDefaults.setValue(
            NSKeyedArchiver.archivedData(withRootObject: dic),
            forKey: VM.KEY
        )
    }
    func load() -> Bool {
        guard let data = UserDefaults.value(forKey: VM.KEY) as? Data else { return false }
        dic = NSKeyedUnarchiver.unarchiveObject(with: data) as! NSMutableDictionary
        return true
    }


}
