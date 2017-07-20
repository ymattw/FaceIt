//
//  ViewController.swift
//  FaceIt
//
//  Created by Matt Wang on 7/17/17.
//  Copyright © 2017 Joyus Studio. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var faceView: FaceView! {
        didSet {
            // selector must be ClassName.methodName(external_arg:), the syntax
            // is just to identify the method name
            let pinchHandler = #selector(FaceView.changeScale(recognizer:))
            let pinchRecognizer = UIPinchGestureRecognizer(target: faceView, action: pinchHandler)
            faceView.addGestureRecognizer(pinchRecognizer)

            let tapHandler = #selector(toggleEyes(recognizer:))
            let tapRecognizer = UITapGestureRecognizer(target: self, action: tapHandler)
            tapRecognizer.numberOfTapsRequired = 1  // default
            faceView.addGestureRecognizer(tapRecognizer)

            updateUI()  // Update UI once view is connected, only once
        }
    }

    var face: FaceModel = FaceModel(eyesAreOpen: true, mouthShape: .grin) {
        didSet { updateUI() }  // Update UI whenever this model changes
    }

    func toggleEyes(recognizer r: UITapGestureRecognizer) {
        if r.state == .ended {
            // Reset faceModel with new attributes
            face = FaceModel(eyesAreOpen: !face.eyesAreOpen,
                             mouthShape: face.mouthShape)
        }
    }

    private func updateUI() {
        // faceView can be nil before UI is completed initialized, to avoid
        // accessing .eyesOpen before that, we use `faceView?' notation - the
        // access operation will be ignored if faceView is nil
        //
        faceView?.eyesOpen = face.eyesAreOpen

        // Looking up a dictiondary returns an optional value
        faceView?.mouthCurvature = face.mouthCurvatures[face.mouthShape] ?? 0.0
    }
}
