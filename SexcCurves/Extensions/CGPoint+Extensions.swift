//
//  CGPoint+Extensions.swift
//  SexcCurves
//
//  Created by Dylan Elliott on 7/3/22.
//

import UIKit

func +(lhs: CGPoint, rhs: (x: CGFloat, y: CGFloat)) -> CGPoint {
    return .init(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
}
