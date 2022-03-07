//
//  CGRect+Extensions.swift
//  SexcCurves
//
//  Created by Dylan Elliott on 7/3/22.
//

import UIKit

extension CGRect {
    var center: CGPoint {
        return .init(x: minX + width / 2.0, y: minY + height / 2.0)
    }
    
    var trailingCenter: CGPoint {
        return .init(x: maxX, y: center.y)
    }
    
    var leadingCenter: CGPoint {
        return .init(x: minX, y: center.y)
    }
    
    var topCenter: CGPoint {
        return .init(x: center.x, y: minY)
    }
    
    var bottomCenter: CGPoint {
        return .init(x: center.x, y: maxY)
    }
    
    func verticallyContains(_ otherRect: CGRect) -> Bool {
        return (self.minY <= otherRect.minY) && (otherRect.maxY <= self.maxY)
    }
    
    func horizontallyContains(_ otherRect: CGRect) -> Bool {
        return (self.minX <= otherRect.minX) && (otherRect.maxX <= self.maxX)
    }
    
    func verticalIntersection(with otherRect: CGRect) -> Intersection {
        if self.intersects(otherRect) == false {
            return .separated
        } else if self.verticallyContains(otherRect) == false {
            return .partiallyIntersected
        } else {
            return .contained
        }
    }
    
    func horizontalIntersection(with otherRect: CGRect) -> Intersection {
        if self.intersects(otherRect) == false {
            return .separated
        } else if self.horizontallyContains(otherRect) == false {
            return .partiallyIntersected
        } else {
            return .contained
        }
    }
}

enum Intersection {
    case separated
    case partiallyIntersected
    case contained
}
