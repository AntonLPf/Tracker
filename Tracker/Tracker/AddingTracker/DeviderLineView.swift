//
//  DeviderLineView.swift
//  Tracker
//
//  Created by Антон Шишкин on 21.04.24.
//

import UIKit

class DividerLineView: UIView {
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        context.setLineWidth(1.0)
        context.setStrokeColor(UIColor.ypGray.cgColor)
        context.move(to: CGPoint(x: 0, y: bounds.height / 2))
        context.addLine(to: CGPoint(x: bounds.width, y: bounds.height / 2))
        context.strokePath()
    }
}
