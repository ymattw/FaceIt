//
//  FaceModel.swift
//  FaceIt
//
//  Created by Matt Wang on 7/19/17.
//  Copyright © 2017 Joyus Studio. All rights reserved.
//

import Foundation

struct FaceModel {

    enum MouthShape: Int {
        case frown
        case smirk
        case neutral
        case grin
        case smile

        // Following trick use the rawValue of the enum case, use '??' to
        // determine if decreased/increased case is in range.  But it use
        // var instead of func..
        //
        var sadder: MouthShape {
            return MouthShape(rawValue: rawValue - 1) ?? .frown
        }

        var happier: MouthShape {
            return MouthShape(rawValue: rawValue + 1) ?? .smile
        }
    }

    let mouthCurvatures: [MouthShape:Double] = [
        .frown: -1,
        .smirk: -0.5,
        .neutral: 0,
        .grin: 0.5,
        .smile: 1,
    ]

    let eyesAreOpen: Bool
    let mouthShape: MouthShape

    // Can also use var but func is more readable
    func sadderFace() -> FaceModel {
        return FaceModel(eyesAreOpen: self.eyesAreOpen,
                         mouthShape: self.mouthShape.sadder)
    }

    func happierFace() -> FaceModel {
        return FaceModel(eyesAreOpen: self.eyesAreOpen,
                         mouthShape: self.mouthShape.happier)
    }
}
