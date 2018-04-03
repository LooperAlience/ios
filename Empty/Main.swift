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

    class M {
        let title = "main button"
    }

    @objc
    override func initVM() {
        if !vm.load() {
            vm["title"] = "main button 3490583409"
            vm["btn1"] = {
                Router.get("main")?.route(self.parent!, Router.type.replace, nil).with("sub1")
            } as UIControl.listener
            vm["m"] = M()
            vm.save()
        }
    }

    override func viewDidLoad() {

        super.viewDidLoad()
        let m: M = vm.prop("m")!
		self.view.backgroundColor = UIColor.brown
		let btn = UIButton(type: UIButtonType.system)
		btn.frame = CGRect(x:50, y:100, width:150, height:30)
		btn.setTitle(m.title, for: UIControlState.normal)
		btn.center = CGPoint(x:self.view.frame.size.width / 2, y:100)
		btn.addTarget(.touchUpInside, vm.listener("btn1")!)
		view.addSubview(btn)
//        Router.get("main")?.route(self.parent!, .cover, nil).with("sub1")
    }
}
