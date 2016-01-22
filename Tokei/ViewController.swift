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
    @IBOutlet weak var digitalWatchLabel: UILabel!
    @IBOutlet weak var clockViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var clockViewHeightConstraint: NSLayoutConstraint!
    
    let timeInterval: NSTimeInterval = 0.001
    var timer: NSTimer!

    override func viewDidLoad() {
        super.viewDidLoad()
        start()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    func start() {
        timer = NSTimer.scheduledTimerWithTimeInterval(timeInterval, target: self, selector: "updateClock", userInfo: nil, repeats: true)
    }
    
    func stop() {
        timer.invalidate()
    }
    
    func updateClock() {
        /// Update clock UI
        let dateComponents: NSDateComponents = NSCalendar.currentCalendar().components([NSCalendarUnit.Hour, NSCalendarUnit.Minute, NSCalendarUnit.Second, NSCalendarUnit.Nanosecond], fromDate: NSDate())
        let milliSeconds = round(Double(dateComponents.nanosecond/10000000))// not accurate enough?
        let seconds: NSInteger = dateComponents.second
        let minutes: NSInteger = dateComponents.minute
        let hours: NSInteger = dateComponents.hour

        /// Update digital watch
        digitalWatchLabel.text = String(format: "%02d:%02d:%02d", hours, minutes, seconds)
        
        let s = Double(seconds) * 100 + milliSeconds// use as milllisec
        let m = Double(minutes) * 60 + Double(seconds)// use as sec
        let h = Double(hours) * 60 + Double(minutes)// use as min

        //reflect the rotations + 180 degres since CALayers coordinate system is inverted
        clockView.secHand.transform = CATransform3DMakeRotation (CGFloat(s*0.06*M_PI/180), 0, 0, 1);
        clockView.minHand.transform = CATransform3DMakeRotation (CGFloat(m*0.1*M_PI/180), 0, 0, 1);
        clockView.hourHand.transform = CATransform3DMakeRotation (CGFloat(h*0.5*M_PI/180), 0, 0, 1);
        //
    }
    
    // rotation API 
    // Use this for autolayout progmatically
//    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
//        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
//        coordinator.animateAlongsideTransition(nil, completion: { (ctxt) -> Void in
//        })
//    }
    

    
}

