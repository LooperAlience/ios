//
//  view.swift
//  chapter2
//
//  Created by bsidesoft on 2018. 3. 4..
//  Copyright © 2018년 com.bsidesoft.ios. All rights reserved.
//

import Foundation
import UIKit
extension UIControl{
	typealias hnd = ()->Void
	class H{
		let a:hnd
		init(_ v:@escaping hnd){a = v}
		@objc func h(){a()}
	}
	func addTarget(_ f:UIControlEvents, _ a:@escaping hnd){
		let h = H(a)
		self.addTarget(h, action: #selector(h.h), for: f)
		objc_setAssociatedObject(self, "\(arc4random())", h, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
	}
}
