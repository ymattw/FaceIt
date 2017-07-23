//
//  EmotionsViewController.swift
//  FaceIt
//
//  Created by Matt Wang on 7/23/17.
//  Copyright © 2017 Joyus Studio. All rights reserved.
//

import UIKit

class EmotionsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let dest = segue.destination
        if let faceViewController = dest as? FaceViewController {
            if let face = emotionFaces[segue.identifier!] {
                faceViewController.face = face
            }
        }
    }

    private let emotionFaces: Dictionary<String,FaceModel> = [
        "sad": FaceModel(eyesAreOpen: false, mouthShape: .frown),
        "happy": FaceModel(eyesAreOpen: true, mouthShape: .smile),
        "worried": FaceModel(eyesAreOpen: true, mouthShape: .smirk),
    ]
}
