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
        NPOStream.getStream(channelTitle: ChannelTitle.NPO3) { (url: URL?, error: NSError?) in
            if error != nil {
                print(error)
                return
            }
            guard let streamURL = url else { return }
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

