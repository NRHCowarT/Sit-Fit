//
//  ArrowButton.swift
//  Sit Fit
//
//  Created by Nick Cowart on 2/6/15.
//  Copyright (c) 2015 Nick Cowart. All rights reserved.
//

import UIKit

@IBDesignable class ArrowButton: UIButton {
    
    @IBInspectable var strokeSize: CGFloat = 1
    @IBInspectable var strokeColor: UIColor = UIColor.darkGrayColor()
    @IBInspectable var isRounded: Bool = true
    @IBInspectable var isReversed: Bool = false
    
    @IBInspectable var topInset: CGFloat = 0
    @IBInspectable var leftInset: CGFloat = 0
    @IBInspectable var rightInset: CGFloat = 0
    @IBInspectable var bottomInset: CGFloat = 0
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        
        var context = UIGraphicsGetCurrentContext()
        
        strokeColor.set()
        
        CGContextSetLineWidth(context, strokeSize)
        
        if isRounded{
            
            CGContextSetLineJoin(context, kCGLineJoinRound)
            CGContextSetLineCap(context, kCGLineCapRound)
            
        }
        
        if isReversed{
            
            CGContextMoveToPoint(context, rect.width - rightInset, topInset)
            CGContextAddLineToPoint(context, leftInset, rect.height / 2)
            CGContextAddLineToPoint(context, rect.width - rightInset, rect.height - bottomInset)
            
        } else {
            
            CGContextMoveToPoint(context, leftInset, topInset)
            CGContextAddLineToPoint(context, rect.width - rightInset, rect.height / 2)
            CGContextAddLineToPoint(context, leftInset, rect.height - bottomInset)
            
        }
        
        CGContextStrokePath(context)
        
    }


}
