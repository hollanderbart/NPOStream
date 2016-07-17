//
//  ViewController.swift
//  Example
//
//  Created by Bart den Hollander on 17/07/16.
//  Copyright © 2016 Bart den Hollander. All rights reserved.
//

import UIKit
import NPOStream

class ViewController: UIViewController {

    @IBAction func viewChannelButtonPressed(_ sender: UIButton) {
        print("knopje gedrukt")
        NPOStream.getStream(url: "http://livestreams.omroep.nl/live/npo/tvlive/ned3/ned3.isml/ned3.m3u8") { (url: URL) in
            print(url)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

