//
//  ViewController.swift
//  Tokei
//
//  Created by Jumpei Katayama on 2/10/15.
//  Copyright (c) 2015 Jumpei Katayama. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
        
    @IBOutlet weak var clockView: ClockView!
//    var clockView2: ClockView
    
//    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
//
////        clockView = ClockView(frame: CGRectMake(-15, 0, 350, 350))
////        clockView2 = ClockView(frame: CGRectMake(0, 400, 100, 100))
//        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
//    }

//    required init?(coder aDecoder: NSCoder) {
//        print("init coder")
////        clockView = ClockView(frame: CGRectMake(-15, 0, 350, 350))
////        clockView2 = ClockView(frame: CGRectMake(0, 400, 100, 100))
////        fatalError("init(coder:) has not been implemented")
//        super.init(coder: aDecoder)
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewdidloaded?")

    }

    override func viewWillAppear(animated: Bool) {
        clockView.start()
        print("called")
    }

    
    

}

