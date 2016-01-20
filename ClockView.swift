//
//  ClockView.swift
//  Tokei
//
//  Created by Jumpei Katayama on 2/10/15.
//  Copyright (c) 2015 Jumpei Katayama. All rights reserved.
//

import UIKit
//import 
//pragma mark - Private Methods
//Default sizes of hands:
//in percentage (0.0 - 1.0)
//let hoursHandLength: CGFloat = 0.65
let minHandLength: CGFloat = 0.75
let secHandsLength: CGFloat = 0.8
//in pixels
let minHandWidth: CGFloat = 8
let secHandWidth: CGFloat = 4

@IBDesignable class ClockView: UIView {
    
    @IBInspectable var clockViewBorderWidth: CGFloat = 2.0
    @IBInspectable var hoursHandWidth: CGFloat = 8
    @IBInspectable var hoursHandHeight: CGFloat = 50
    @IBInspectable var minHandWidth: CGFloat = 6
    @IBInspectable var minHandHeight: CGFloat = 100
    @IBInspectable var secHandWidth: CGFloat = 4
    @IBInspectable var secHandHeight: CGFloat = 110
    @IBInspectable var centerCircleRadius: CGFloat = 20

    var containerLayer: CALayer!
    var hourHand: CAShapeLayer!
    var minHand: CAShapeLayer!
    var secHand: CAShapeLayer!
    var clockFace: CAShapeLayer!
    var centerPointCircle: CAShapeLayer!
    var timeBoard: CALayer!
    var timer: NSTimer = NSTimer()
    var timeInterval: NSTimeInterval = 0.001
    
    var clockCenter: CGPoint {
        return self.center
    }
    
    private var side: CGFloat {
        return bounds.width// width and height are same
    }
    
    
    override func drawRect(rect: CGRect) {

        setupCenterCircle()
        setupHourHand()
        setupMinHand()
        setupSecHand()
        updateCurrentTime()
        clockFaceSetup()

    }
    
    func clockFaceSetup() {
        layer.cornerRadius = bounds.width/2
        layer.borderColor = UIColor.blackColor().CGColor
        layer.borderWidth = 2.0
        
//        let label = CATextLayer()
//        label.font = UIFont(name: "Helvetica", size: 10)
//        label.frame = CGRectMake(0, 0, 50, 50)
//        label.string = "10"
//        label.foregroundColor = UIColor.blackColor().CGColor
//        layer.addSublayer(label)
        
    }
    
    func updateCurrentTime() {
        
    }
    
    func setupHourHand() {
        hourHand = CAShapeLayer()
        hourHand.path = UIBezierPath(rect: CGRectMake(-(hoursHandWidth/2), -hoursHandHeight, hoursHandWidth, hoursHandHeight)).CGPath
        hourHand.fillColor = UIColor.blackColor().CGColor
        hourHand.position = CGPointMake(bounds.width/2, bounds.height/2)
        layer.addSublayer(hourHand)
    }
    
    func setupMinHand() {
        minHand = CAShapeLayer()
        minHand.path = UIBezierPath(rect: CGRectMake(-(minHandWidth/2), -minHandHeight, minHandWidth, minHandHeight)).CGPath
        minHand.fillColor = UIColor.blueColor().CGColor
        minHand.position = CGPointMake(bounds.width/2, bounds.height/2)
        layer.addSublayer(minHand)
    }
    
    func setupSecHand() {
        secHand = CAShapeLayer()
        secHand.path = UIBezierPath(rect: CGRectMake(-(secHandWidth/2), -secHandHeight, secHandWidth, secHandHeight)).CGPath
        secHand.fillColor = UIColor.redColor().CGColor
        secHand.position = CGPointMake(bounds.width/2, bounds.height/2)
        layer.addSublayer(secHand)
    }
    
    private func setupTimeboard(center: CGPoint, radius: CGFloat) {
        
    }
    
    func setupCenterCircle() {
        centerPointCircle = CAShapeLayer()
        centerPointCircle.path = UIBezierPath(roundedRect: CGRectMake(-(centerCircleRadius/2), -(centerCircleRadius/2), centerCircleRadius, centerCircleRadius), cornerRadius: centerCircleRadius/2).CGPath
        centerPointCircle.position = CGPointMake(bounds.width/2, bounds.height/2)
        centerPointCircle.lineWidth = 3
        centerPointCircle.strokeColor = UIColor.blackColor().CGColor
        centerPointCircle.fillColor = UIColor.whiteColor().CGColor
        layer.addSublayer(centerPointCircle)
    }
    
    /// Container is a round shaped layer on which all hands are set
    private func setupContainer() {
        // set frame
        containerLayer.frame = CGRectMake(bounds.origin.x, bounds.origin.y, bounds.size.width, bounds.size.height)
        containerLayer.borderWidth = 0.8
        containerLayer.borderColor = UIColor.yellowColor().CGColor
        // the radius should be the same as a half of clockView's side length
        containerLayer.cornerRadius = side/2
        // set content color, for now it will be white
        containerLayer.backgroundColor = UIColor.whiteColor().CGColor

    }
    
    private func positionCenter() {
        hourHand.position = CGPointMake(bounds.width/2, bounds.height/2)
        print("\(center) == \(hourHand.position)")
        print(hourHand.position)
        minHand.position = CGPointMake(bounds.width/2, bounds.height/2)
        secHand.position = CGPointMake(bounds.width/2, bounds.height/2)
    }
    
    func start() {
        timer = NSTimer.scheduledTimerWithTimeInterval(timeInterval, target: self, selector: "updateClock", userInfo: nil, repeats: true)
        
    }
    
    func stop() {
        timer.invalidate()
    }
    
    /// Called every miiilisecond
    func updateClock() {
        /// Update clock UI

        print(NSDate())
        let dateComponents: NSDateComponents = NSCalendar.currentCalendar().components([NSCalendarUnit.Hour, NSCalendarUnit.Minute, NSCalendarUnit.Second, NSCalendarUnit.Nanosecond], fromDate: NSDate())
//        let nanoSeconds = dateComponents.nanosecond
        print(dateComponents.timeZone)
        print(dateComponents.hour)
        let milliSeconds = round(Double(dateComponents.nanosecond/10000000))
        let seconds: NSInteger = dateComponents.second
        let minutes: NSInteger = dateComponents.minute
        var hours: NSInteger = dateComponents.hour
//        print(dateComponents.date!)
        //NSLog(@"raw: hours:%d min:%d secs:%d", hours, minutes, seconds);
        if (hours > 12) {
            hours -= 12
        } //PM

        let s = Double(seconds) + milliSeconds / 100
        print(s)
        let m = Double(minutes) * 60 + Double(seconds)
        let h = Double(hours) * 60 + Double(minutes)
        print(hours)
//        round(nanoseconds/1000000)
        //set degree per time
        let secAngle: Double = Degrees2Radians(Double(s)/60.0*360);
        let minAngle: Double = Degrees2Radians(Double(m)/60*60*360);
        let hourAngle: Double = Degrees2Radians(Double(h)/12.0*60.0*360);
        print(secAngle)
        print(minAngle)
        //reflect the rotations + 180 degres since CALayers coordinate system is inverted
        secHand.transform = CATransform3DMakeRotation (CGFloat(secAngle), 0, 0, 1);
        minHand.transform = CATransform3DMakeRotation (CGFloat(m*0.1*M_PI/180), 0, 0, 1);
        hourHand.transform = CATransform3DMakeRotation (CGFloat(h*0.5*M_PI/180), 0, 0, 1);
        print("updated!")
    }
    
    //  MARK: - Private methods
    private func Degrees2Radians(degrees: Double) -> Double {
        return degrees * M_PI / 180;
    }

}
