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

    private var faceRadius: CGFloat {
        return min(bounds.size.width, bounds.size.height) / 2 * scale
    }

    private var faceCenter: CGPoint {
        return CGPoint(x: bounds.midX, y: bounds.midY)
    }

    private enum Eye {
        case left
        case right
    }

    // Ratios of size of face element to size of face
    private struct Ratios {
        static let eyeOffset: CGFloat = 1/3
        static let eyeRadius: CGFloat = 0.1
        static let mouthWidth: CGFloat = 1
        static let mouthHeight: CGFloat = 1/3
        static let mouthOffset: CGFloat = 1/3
    }

    private func eyePath(_ eye: Eye) -> UIBezierPath {
        func centerOfEye(_ eye: Eye) -> CGPoint {
            let eyeOffset = faceRadius * Ratios.eyeOffset
            var eyeCenter = faceCenter
            eyeCenter.y -= eyeOffset
            eyeCenter.x += (eye == .left ? -1 : 1) * eyeOffset
            return eyeCenter
        }

        let eyeRadius = faceRadius * Ratios.eyeRadius
        let eyeCenter = centerOfEye(eye)
        let path = UIBezierPath(
            arcCenter: eyeCenter, radius: eyeRadius, startAngle: 0,
            endAngle: CGFloat.pi * 2, clockwise: true)
        path.lineWidth = 5.0
        return path
    }

    private func facePath() -> UIBezierPath {
        let path = UIBezierPath(
            arcCenter: faceCenter, radius: faceRadius, startAngle: 0,
            endAngle: CGFloat.pi * 2, clockwise: true)
        path.lineWidth = 5.0
        return path
    }

    override func draw(_ rect: CGRect) {
        UIColor.blue.set()
        facePath().stroke()
        eyePath(.left).stroke()
        eyePath(.right).stroke()
    }
}
