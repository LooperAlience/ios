//
//  Main.swift
//  Empty
//
//  Created by bsidesoft on 2018. 3. 5..
//  Copyright © 2018년 com.bsidesoft.ios. All rights reserved.
//

import UIKit

class Test:NSObject{
	override init(){}
}
class Main: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
		self.view.backgroundColor = UIColor.brown
		let btn = UIButton(type: UIButtonType.system)
		btn.frame = CGRect(x:50, y:100, width:150, height:30)
		btn.setTitle("main button", for: UIControlState.normal)
		btn.center = CGPoint(x:self.view.frame.size.width / 2, y:100)
		btn.addTarget(.touchUpInside){
			Router.get("main")?.route(self.parent!, "sub1", Router.type.replace)
		}
		view.addSubview(btn)
    }
}
