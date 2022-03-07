//
//  UIView+Centering.swift
//  SexcCurves
//
//  Created by Dylan Elliott on 7/3/22.
//

import UIKit

extension UIView {
    var leadingCenter: CGPoint {
        get {
            return frame.leadingCenter
        }
        set {
            center = CGPoint(x: newValue.x + frame.width / 2.0, y: newValue.y)
        }
    }
    
    var trailingCenter: CGPoint {
        get {
            return frame.trailingCenter
        }
        set {
            center = CGPoint(x: newValue.x - frame.width / 2.0, y: newValue.y)
        }
    }
    
    var topCenter: CGPoint {
        get {
            return frame.topCenter
        }
        set {
            center = CGPoint(x: newValue.x, y: newValue.y + frame.height / 2.0)
        }
    }
    
    var bottomCenter: CGPoint {
        get {
            return frame.bottomCenter
        }
        set {
            center = CGPoint(x: newValue.x, y: newValue.y - frame.height / 2.0)
        }
    }
}
