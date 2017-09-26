//
//  ViewController.swift
//  NPOStreamTestApp
//
//  Created by Bart den Hollander on 17/07/16.
//  Copyright © 2016 Bart den Hollander. All rights reserved.
//

import UIKit
import NPOStream

class MainViewController: UIViewController {

    @IBOutlet weak var viewChannelButton: UIButton!
    @IBAction func viewChannelButtonPressed(_ sender: UIButton) {
        NPOStream.getStream(ChannelStreamTitle.NPO3) { [weak self] result in
            switch result {
            case .error(let error):
                print(error)
                self?.brieflyChangeButtonLabel(error.localizedDescription)
            case .success(let url):
                print(url)
                self?.performSegue(withIdentifier: "showPlayer", sender: url)
            }
        }
    }

    // MARK: - Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard
            segue.identifier == "showPlayer",
            let destination = segue.destination as? PlayerViewController,
            let url = sender as? URL else { return }
        destination.url = url
    }
    
    // MARK: - Private
    
    private func brieflyChangeButtonLabel(_ title: String?) {
        let backupTitle = viewChannelButton.title(for: .normal)
        let backupTitleColor = viewChannelButton.titleColor(for: .normal)
        self.viewChannelButton.setTitle(title, for: .normal)
        self.viewChannelButton.setTitleColor(.red, for: .normal)
        
        let time = DispatchTime.now() + 2
        DispatchQueue.main.asyncAfter(deadline: time, execute: { [weak self] in
            self?.viewChannelButton.setTitle(backupTitle, for: .normal)
            self?.viewChannelButton.setTitleColor(backupTitleColor, for: .normal)
        })
    }
}

