//
//  UITouch+Extensions.swift
//  SexcCurves
//
//  Created by Dylan Elliott on 7/3/22.
//

import UIKit

extension UITouch {
    func verticalChange(in view: UIView) -> CGFloat {
        let lastTouchPosition = previousLocation(in: view).y
        let newTouchPosition = location(in: view).y
        return newTouchPosition - lastTouchPosition
    }
}
