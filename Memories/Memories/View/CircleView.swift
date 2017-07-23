//
//  CircleView.swift
//  Memories
//
//  Created by Jérémie Pouillon on 23/07/2017.
//  Copyright © 2017 Jérémie Pouillon. All rights reserved.
//

import UIKit

enum InteractiveArea {
    case topArea
    case bottomArea
    case leftArea
    case rightArea
    case centerArea
    
    // Fill the area with the wanted background color
    var backgroundColor: UIColor {
        switch self {
        case .topArea:
            return UIColor.red
        case .bottomArea:
            return UIColor.cyan
        case .leftArea:
            return UIColor.yellow
        case .rightArea:
            return UIColor.brown
        case .centerArea:
            return UIColor.green
        }
    }
    
    var shouldDrawAreaClockwise: Bool {
        switch self {
        case .topArea, .rightArea:
            return false
        default:
            return true
        }
    }
    
    // An area needs 4 points to be built. Each points are on a circle so they're defined by (x,y) = (Radius * cos(theta), Radius * sin(theta))
    // We need to know each angle for each points. Radius is known.
    var angleBounds: [CGFloat] {
        switch self {
        case .topArea:
            return [CGFloat(5 * Double.pi / 4), CGFloat(5 * Double.pi / 4), CGFloat(7 * Double.pi / 4), CGFloat(7 * Double.pi / 4)]
        case .bottomArea:
            return [CGFloat(3 * Double.pi / 4), CGFloat(3 * Double.pi / 4), CGFloat(Double.pi / 4), CGFloat(Double.pi / 4)]
        case .leftArea:
            return [CGFloat(5 * Double.pi / 4), CGFloat(5 * Double.pi / 4), CGFloat(3 * Double.pi / 4), CGFloat(3 * Double.pi / 4)]
        case .rightArea:
            return [CGFloat(7 * Double.pi / 4), CGFloat(7 * Double.pi / 4), CGFloat(Double.pi / 4), CGFloat(Double.pi / 4)]
        case .centerArea:
            return [CGFloat(5 * Double.pi / 4), CGFloat(7 * Double.pi / 4), CGFloat(Double.pi / 4), CGFloat(3 * Double.pi / 4)]
        }
    }
}

class CircleView: UIView {
    
    // Private variables
    private let delta: CGFloat = 1.0
    private let circleLineWidth: CGFloat = 2
    private var circleRadius: CGFloat {
        return (frame.size.width / 2) - delta // substract delta to have a full circle
    }
    private var circleCenteredAt: CGPoint {
        return CGPoint(x: bounds.midX, y: bounds.midY)
    }
    
    // Variables
    var topArea: UIBezierPath!
    var bottomArea: UIBezierPath!
    var leftArea: UIBezierPath!
    var rightArea: UIBezierPath!
    var centerArea: UIBezierPath!
    
    override func draw(_ rect: CGRect) {
        UIColor.black.set()
        drawCircle(centeredAt: circleCenteredAt, withRadius: circleRadius).stroke()
        drawEdges(ofArea: .topArea).stroke()
        drawEdges(ofArea: .bottomArea).stroke()
        drawEdges(ofArea: .leftArea).stroke()
        drawEdges(ofArea: .rightArea).stroke()
        drawEdges(ofArea: .centerArea).stroke()
    }
    
    // MARK: - Private function
    
    private func drawCircle(centeredAt: CGPoint, withRadius radius: CGFloat) -> UIBezierPath {
        let circlePath = UIBezierPath(arcCenter: centeredAt,
                                      radius: radius,
                                      startAngle: 0.0,
                                      endAngle: CGFloat(Double.pi * 2),
                                      clockwise: false)
        
        circlePath.lineWidth = circleLineWidth
        return circlePath
    }
    
    private func getPointOnCircle(withRadius radius: CGFloat, atCenter center: CGPoint, atAngle angle: CGFloat) -> CGPoint {
        return CGPoint(x: radius * cos(angle) + center.x, y: radius * sin(angle) + center.y)
    }

    private func drawEdges(ofArea area: InteractiveArea) -> UIBezierPath {
        let tmpBezierPath = UIBezierPath()
        
        // Starting point
        tmpBezierPath.move(to: getPointOnCircle(withRadius: area == .centerArea ? circleRadius / 2 : circleRadius,
                                                atCenter: circleCenteredAt,
                                                atAngle: area.angleBounds.first!)) // there's always a value in angleBounds
        
        // Build area
        area.angleBounds.enumerated().forEach { index, angle in
            if index == 0 {
                return  // No need to draw a line for the first angle value because it is our starting point.
            }
            
            tmpBezierPath.addLine(to: getPointOnCircle(withRadius: circleRadius / 2, atCenter: circleCenteredAt, atAngle: angle))
            
            if index == area.angleBounds.count - 1 {
                if area == .centerArea {
                    return  // If we are building the center area, we just need 3 points. See the `close()` method description
                 }
                tmpBezierPath.addArc(withCenter: circleCenteredAt,
                                     radius: circleRadius,
                                     startAngle: angle,
                                     endAngle: area.angleBounds.first!,
                                     clockwise: area.shouldDrawAreaClockwise)
            }
        }

        tmpBezierPath.close()
        area.backgroundColor.set()
        tmpBezierPath.fill()
        
        configureBezierPath(with: area, and: tmpBezierPath)
        
        return tmpBezierPath
    }
    
    private func configureBezierPath(with area: InteractiveArea, and bezierPath: UIBezierPath) {
        switch area {
        case .topArea:
            topArea = bezierPath
        case .bottomArea:
            bottomArea = bezierPath
        case .leftArea:
            leftArea = bezierPath
        case .rightArea:
            rightArea = bezierPath
        case .centerArea:
            centerArea = bezierPath
        }
    }
}
