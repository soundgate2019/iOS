//
//  HowToUseViewController.swift
//  Sound Gate
//
//  Created by Matheus Martins on 14/09/19.
//  Copyright © 2019 Matheus Martins. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class HowToUseViewController: UIViewController {

    @IBOutlet weak var watchButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        watchButton.layer.cornerRadius = 8
    }
    
    @IBAction func playVideo(_ sender: Any) {
        guard let path = Bundle.main.path(forResource: "how_to_use", ofType:"mp4") else {
            debugPrint("how_to_use.mp4 not found")
            return
        }
        let player = AVPlayer(url: URL(fileURLWithPath: path))
        let playerController = AVPlayerViewController()
        playerController.player = player
        present(playerController, animated: true) {
            player.play()
        }
    }
    
}
