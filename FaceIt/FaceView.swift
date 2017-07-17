//
//  FaceView.swift
//  FaceIt
//
//  Created by Matt Wang on 7/17/17.
//  Copyright © 2017 Joyus Studio. All rights reserved.
//

import UIKit

class FaceView: UIView {
    var scale: CGFloat = 0.9

    override func draw(_ rect: CGRect) {
        let faceRadius = min(bounds.size.width, bounds.size.height) / 2 * scale
        let faceCenter = CGPoint(x: bounds.midX, y: bounds.midY)

        let path = UIBezierPath(
            arcCenter: faceCenter, radius: faceRadius, startAngle: 0,
            endAngle: CGFloat.pi * 2, clockwise: true)
        path.lineWidth = 5.0
        UIColor.blue.set()
        path.stroke()
    }
}
