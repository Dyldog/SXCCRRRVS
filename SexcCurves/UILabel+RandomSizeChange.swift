//
//  UILabel+RandomSizeChange.swift
//  SexcCurves
//
//  Created by Dylan Elliott on 7/3/22.
//

import UIKit

extension UILabel {
    func randomlyAdjustSize(increase: Bool, max: Int = 10) {
        // Save previous vertical position so we can reset it after we change the size
        let previousCenterY = center.y
        
        let amount = CGFloat((1...max).randomElement()!)
        let change: CGFloat = amount * (increase ? 1 : -1)
        font = .systemFont(ofSize: font.pointSize + change)
        sizeToFit()
        
        center.y = previousCenterY
    }
}
