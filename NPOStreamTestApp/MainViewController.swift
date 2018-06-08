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
        NPOStream.getStreamURL(for: ChannelStreamTitle.NPO3) { [weak self] result in
            switch result {
            case .error(let error):
                self?.brieflyChangeButtonLabel(error.errorDescription)
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
    
    private func brieflyChangeButtonLabel(_ title: String?, _ titleColor: UIColor? = .red) {
        let backupTitle = viewChannelButton.title(for: UIControl.State.normal)
        let backupTitleColor = viewChannelButton.titleColor(for: UIControl.State.normal)
        self.viewChannelButton.setTitle(title, for: UIControl.State.normal)
        self.viewChannelButton.setTitleColor(titleColor, for: UIControl.State.normal)
        
        let time = DispatchTime.now() + 2
        DispatchQueue.main.asyncAfter(deadline: time, execute: { [weak self] in
            self?.viewChannelButton.setTitle(backupTitle, for: UIControl.State.normal)
            self?.viewChannelButton.setTitleColor(backupTitleColor, for: UIControl.State.normal)
        })
    }
}

