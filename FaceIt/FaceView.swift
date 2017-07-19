//
//  FaceView.swift
//  FaceIt
//
//  Created by Matt Wang on 7/17/17.
//  Copyright © 2017 Joyus Studio. All rights reserved.
//

import UIKit

@IBDesignable
class FaceView: UIView {

    // Public APIs

    @IBInspectable
    var scale: CGFloat = 0.9 {
        didSet { setNeedsDisplay() }  // redraw, don't call redraw() directly
    }

    @IBInspectable
    var eyesOpen: Bool = true

    @IBInspectable
    var mouthCurvature: Double = -0.5  // 1.0 is full smile, -1.0  is full frown

    @IBInspectable
    var lineWidth: CGFloat = 5.0

    @IBInspectable
    var faceColor: UIColor = UIColor.blue

    func changeScale(recognizer r: UIPinchGestureRecognizer) {
        switch r.state {
        case .changed, .ended:
            self.scale *= r.scale
            r.scale = 1  // reset
        default:
            break
        }
    }

    // Private implementations

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

        path.lineWidth = lineWidth
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

        // Restrict readl mouth Curvature to be within [-1, 1]
        let smileOffset = CGFloat(max(-1, min(mouthCurvature, 1))) * mouthHeight

        // A smiley mouth is a curve shaped by a start point, an end point and
        // two contol points
        let start = CGPoint(x: mouthRect.minX, y: mouthRect.midY)
        let end = CGPoint(x: mouthRect.maxX, y: mouthRect.midY)
        let cp1 = CGPoint(x: start.x + mouthRect.width / 3,
                          y: start.y + smileOffset)
        let cp2 = CGPoint(x: end.x - mouthRect.width / 3,
                          y: start.y + smileOffset)

        let path = UIBezierPath()
        path.move(to: start)
        path.addCurve(to: end, controlPoint1: cp1, controlPoint2: cp2)
        path.lineWidth = lineWidth

        return path
    }

    private func facePath() -> UIBezierPath {
        let path = UIBezierPath(
            arcCenter: faceCenter, radius: faceRadius, startAngle: 0,
            endAngle: CGFloat.pi * 2, clockwise: true)
        path.lineWidth = lineWidth
        return path
    }

    override func draw(_ rect: CGRect) {
        faceColor.set()
        facePath().stroke()
        eyePath(.left).stroke()
        eyePath(.right).stroke()
        mouthPath().stroke()
    }
}
