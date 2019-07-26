//
//  ProgressBarView.swift
//  HolidayReading
//
//  Created by Paula Leite on 18/07/19.
//  Copyright © 2019 Paula Torales Leite. All rights reserved.
//

// Code #11 of CBL Document File (https://paper.dropbox.com/doc/CBL-Document-Paula--Ag8Oeg_7LmUEIWysuJgmYuXEAQ-zck3kpaQYAspQuFvAsOxk)

import UIKit

@IBDesignable
class ProgressBarView: UIView {
    @IBInspectable
    var lineWidth:CGFloat = 9.0 {
        didSet{
            setNeedsDisplay()
        }
    }
    
    @IBInspectable
    var progressValue:CGFloat = 0.0 {
        didSet{
            setNeedsDisplay()
        }
    }
    
    @IBInspectable
    var lineColor:UIColor = #colorLiteral(red: 0.8171664593, green: 0.8280336185, blue: 0.8606350959, alpha: 1) {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable
    var progressColor:UIColor = #colorLiteral(red: 0.8992445469, green: 0.7247573137, blue: 0.2885752916, alpha: 1) {
        didSet {
            setNeedsDisplay()
        }
    }
    
    
    override func draw(_ rect: CGRect) {
        
        //Important constants for line
        let start:CGPoint   = CGPoint(x: rect.minX + lineWidth, y: rect.midY)
        let end:CGPoint     = CGPoint(x: rect.maxX - lineWidth, y: rect.midY)
        
        //Calculating end point of progress bar
        let space:CGFloat       = end.x - start.x
        let endProgress = CGPoint(x: start.x + space * progressValue, y: end.y)
        
        //starting point for all drawing code is getting the context.
        let context = UIGraphicsGetCurrentContext()
        
        //set line attributes
        context?.setLineWidth(lineWidth)
        context?.setLineCap(CGLineCap.round)
        
        // Draw the MAIN line
        context?.setStrokeColor(lineColor.cgColor)
        context?.move(to: CGPoint(x: start.x, y: start.y))
        context?.addLine(to: CGPoint(x: end.x, y: end.y))
        context?.strokePath()
        
        // Draw the PROGRESS line
        context?.setStrokeColor(progressColor.cgColor)
        context?.move(to: CGPoint(x: start.x, y: start.y))
        context?.addLine(to: CGPoint(x: endProgress.x, y: endProgress.y))
        context?.strokePath()
    }
}
