//
//  UIButton+Shadow.swift
//  MathUp
//
//  Created by Andy Stef on 16.04.2021.
//

import UIKit

extension UIButton {
    func addActionButtonShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 2, height: 2)
        layer.cornerRadius = 5.0
        layer.shadowRadius = 2
        layer.shadowOpacity = 0.3
    }
}
