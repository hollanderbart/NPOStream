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
        NPOStream.getStream(ChannelTitle.NPO3) { (url: URL?, error: NSError?) in
            guard let streamURL = url, error == nil else { return }
            self.performSegue(withIdentifier: "player", sender: streamURL)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "player" {
            if let destination = segue.destination as? PlayerViewController {
                destination.url = sender as! URL
            }
        }
    }
}

