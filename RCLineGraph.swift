//
//  RCLineGraph.swift
//  RCLineGraph
//
//  Created by Ryan Cortez on 7/12/16.
//  Copyright © 2016 Ryan Cortez. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class RCLineGraph: UIView {
    
    var yValues: Array<CGFloat> = [100, 20, 60, 20, 50]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func drawRect(rect: CGRect) {
        // Create margin so the chart looks nicer
        let circleDiameter: CGFloat = frame.width / 50
        let margin:CGFloat = frame.width / 20
        
        // Get the width of the graph without the margins on the sides
        let chartDrawingSize: CGSize = CGSizeMake(frame.width - (margin * 2), frame.height)

        // Divide that width by the amount of points in the array
        let distanceBetweenEachPoint = chartDrawingSize.width / CGFloat(yValues.count - 1)
        
        // Add a point that starts at the left of the view plus the margin and circle diamete
        let lineStartingY = self.frame.height - margin - yValues.first! + (circleDiameter / 2)
        let lineStartingX = margin
        let line = UIBezierPath()
        UIColor.yellowColor().setStroke()
        line.moveToPoint(CGPointMake(lineStartingX, lineStartingY))
        line.stroke()
        
        for (index, y) in yValues.enumerate() {
            if (index != 0) {
                extendGraphLine(withLine: line, andPoint:CGPointMake(lineStartingX + (distanceBetweenEachPoint * CGFloat(index)), self.frame.height - margin - y + (circleDiameter / 2) ))
            }
        }

        for (index, y) in yValues.enumerate() {
            let circleX = margin + (CGFloat(index) * distanceBetweenEachPoint) - (circleDiameter/2)
            let circleY = self.frame.height - margin - y
            let circlePoint = CGPointMake(circleX, circleY)
            
            drawGraphPoint(atPoint: circlePoint, withCircleDiameter: circleDiameter)
        }
    }
    
    func drawGraphPoint(atPoint point: CGPoint, withCircleDiameter circleDiameter: CGFloat) {
        let circle = UIBezierPath(ovalInRect: CGRect(x: point.x, y: point.y, width: circleDiameter, height: circleDiameter))
        UIColor.redColor().setFill()
        circle.fill()
        circle.closePath()
    }
    
    func extendGraphLine(withLine line: UIBezierPath, andPoint point: CGPoint) {
            line.addLineToPoint(point)
            line.stroke()
    }
}