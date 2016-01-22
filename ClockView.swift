//
//  ClockView.swift
//  Tokei
//
//  Created by Jumpei Katayama on 2/10/15.
//  Copyright (c) 2015 Jumpei Katayama. All rights reserved.
//

import UIKit



@IBDesignable class ClockView: UIView {
    private let mutiplierMinHandLength = 0.4//mutiplier to bounds.height
    private let mutiplierSecHandLength = 0.3
    private let mutiplierHourHandLength = 0.2
    
    @IBInspectable var clockViewBorderWidth: CGFloat = 2.0
    @IBInspectable var hoursHandWidth: CGFloat = 8
    @IBInspectable var minHandWidth: CGFloat = 6
    @IBInspectable var secHandWidth: CGFloat = 4
    var centerCircleRadius: CGFloat {
        return bounds.width * 0.06
    }

    private var secHandHeight: CGFloat {
        return bounds.width * CGFloat(mutiplierSecHandLength)
    }
    
    private var hoursHandHeight: CGFloat {
        return bounds.width * CGFloat(mutiplierHourHandLength)
    }
    
    private var minHandHeight: CGFloat {
        return bounds.width * CGFloat(mutiplierMinHandLength)
    }

    var containerLayer: CALayer!
    var hourHand: CAShapeLayer!
    var minHand: CAShapeLayer!
    var secHand: CAShapeLayer!
    var clockFace: CAShapeLayer!
    var centerPointCircle: CAShapeLayer!
    var timeBoard: CALayer!
    
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
        clockFaceSetup()
        print("after drawRect \(bounds)")
    }
    
    
    func clockFaceSetup() {
        layer.cornerRadius = bounds.width/2
        layer.borderColor = UIColor.blackColor().CGColor
        layer.backgroundColor = UIColor.orangeColor().CGColor// Doesn't work!
        layer.borderWidth = 2.0
        
//        let label = CATextLayer()
//        label.font = UIFont(name: "Helvetica", size: 10)
//        label.frame = CGRectMake(0, 0, 50, 50)
//        label.string = "10"
//        label.foregroundColor = UIColor.blackColor().CGColor
//        layer.addSublayer(label)
        
    }
    
//    override func layoutSubviews() {
//    
////     You shouldn't called this method directory
//    }

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
    
//    override func layoutIfNeeded() {
          /// Implement this method causes @IBDesignable related error
//        print("after layoutIfNeeded \(bounds)")
//        layer.cornerRadius = bounds.width/2
//        centerPointCircle.position = CGPointMake(bounds.width/2, bounds.height/2)
//        secHand.position = CGPointMake(bounds.width/2, bounds.height/2)
//        minHand.position = CGPointMake(bounds.width/2, bounds.height/2)
//        hourHand.position = CGPointMake(bounds.width/2, bounds.height/2)
//
//    }
    
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

}
