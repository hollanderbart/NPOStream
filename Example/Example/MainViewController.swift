//
//  ViewController.swift
//  Example
//
//  Created by Bart den Hollander on 17/07/16.
//  Copyright © 2016 Bart den Hollander. All rights reserved.
//

import UIKit
import NPOStream

class MainViewController: UIViewController {

    @IBAction func viewChannelButtonPressed(_ sender: UIButton) {
        NPOStream.getStream(url: "http://livestreams.omroep.nl/live/npo/tvlive/ned3/ned3.isml/ned3.m3u8") { (url: URL?) in
            guard let streamURL = url else {
                return
            }
            self.performSegue(withIdentifier: "player", sender: streamURL)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "player" {
            if let destination = segue.destinationViewController as? PlayerViewController {
                destination.url = sender as! URL
            }
        }
    }
}

