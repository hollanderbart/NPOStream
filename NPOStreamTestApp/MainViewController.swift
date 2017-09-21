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
        NPOStream.getStream(ChannelStreamTitle.NPO3) { [weak self] (url: URL?, error: NSError?) in
            guard
                let strongSelf = self,
                let streamURL = url,
                error == nil else { return }
            strongSelf.performSegue(withIdentifier: "showPlayer", sender: streamURL)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard
            segue.identifier == "showPlayer",
            let destination = segue.destination as? PlayerViewController,
            let url = sender as? URL else { return }
        destination.url = url
    }
}

