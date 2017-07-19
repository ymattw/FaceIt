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
}
