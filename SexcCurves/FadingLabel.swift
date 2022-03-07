//
//  FadingLabel.swift
//  SexcCurves
//
//  Created by Dylan Elliott on 7/3/22.
//

import UIKit

class FadingLabel: UILabel {
    
    var fadeDuration: CGFloat = 1.0
    var fadeFrames: CGFloat { fadeDuration / TimeInterval.frameRate }
    var fadeStep: CGFloat { 1.0 / fadeFrames }
    var fadeTimer: Timer!
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        start()
    }
    
    func start() {
        fadeTimer = .scheduledTimer(timeInterval: .frameRate, target: self, selector: #selector(fadeOneStep), userInfo: nil, repeats: true)
    }
    
    @objc func fadeOneStep() {
        guard alpha > 0 else { return finish() }
        alpha -= fadeStep
    }
    
    func finish() {
        fadeTimer.invalidate()
        removeFromSuperview()
    }
}
