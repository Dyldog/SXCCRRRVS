//
//  UIView+Embed.swift
//  SexcCurves
//
//  Created by Dylan Elliott on 7/3/22.
//

import Foundation
import UIKit

extension UIView {
    func embed(in view: UIView) {
        view.addSubview(self)
        NSLayoutConstraint.activate([
            self.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            self.topAnchor.constraint(equalTo: view.topAnchor),
            self.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    func pinToBottom(of view: UIView, safeArea: Bool = true, padding: UIEdgeInsets = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(self)
        
        let bottom = safeArea ? view.safeAreaLayoutGuide.bottomAnchor : view.bottomAnchor
        NSLayoutConstraint.activate([
            self.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding.left),
            self.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding.right),
            self.bottomAnchor.constraint(equalTo: bottom, constant: padding.bottom),
        ])
    }
}
