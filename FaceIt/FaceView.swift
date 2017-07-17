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
    var eyesOpen: Bool = true

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

    // Ratios of size of face element to size of face radius
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

        // This is ok given we are about to initialize it and only once
        let path: UIBezierPath

        if eyesOpen {
            path = UIBezierPath(
                arcCenter: eyeCenter, radius: eyeRadius, startAngle: 0,
                endAngle: CGFloat.pi * 2, clockwise: true)
        } else {
            path = UIBezierPath()
            path.move(to: CGPoint(x: eyeCenter.x - eyeRadius, y: eyeCenter.y))
            path.addLine(to: CGPoint(x: eyeCenter.x + eyeRadius, y: eyeCenter.y))
        }

        path.lineWidth = 5.0
        return path
    }

    private func mouthPath() -> UIBezierPath {
        let mouthWidth = faceRadius * Ratios.mouthWidth
        let mouthHeight = faceRadius * Ratios.mouthHeight
        let mouthOffset = faceRadius * Ratios.mouthOffset

        let mouthRect = CGRect(x: faceCenter.x - mouthWidth / 2,
                               y: faceCenter.y + mouthOffset,
                               width: mouthWidth,
                               height: mouthHeight)
        let path = UIBezierPath(rect: mouthRect)
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
        mouthPath().stroke()
    }
}
