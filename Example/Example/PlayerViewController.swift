//
//  PlayerViewController.swift
//  Example
//
//  Created by Bart den Hollander on 20/07/16.
//  Copyright © 2016 Bart den Hollander. All rights reserved.
//

import UIKit
import AVKit
import MediaPlayer

class PlayerViewController: AVPlayerViewController {
    
    var url: URL = URL(fileURLWithPath: "")
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.player = AVPlayer(url: url)
        self.player?.play()
    }
}
