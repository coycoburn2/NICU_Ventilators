//
//  Videotesting.swift
//  Coy_Test
//
//  Created by Coy Coburn on 11/4/22.
//

import Foundation
import UIKit
import youtube_ios_player_helper

class videoTesting: UIViewController {
    
    
    @IBOutlet weak var buttonOne: UIButton!
    @IBOutlet weak var buttonTwo: UIButton!
    @IBOutlet weak var buttonThree: UIButton!
    @IBOutlet weak var buttonFour: UIButton!
    @IBOutlet weak var videoView: YTPlayerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        buttonOne.setTitle("Video 1", for: .normal)
        buttonTwo.setTitle("Vieo 2", for: .normal)
        buttonThree.setTitle("Video 3", for: .normal)
        buttonFour.setTitle("Video 4", for: .normal)
        videoView.load(withVideoId: "haW_ruZ_Be8", playerVars: ["playsinLine": "1"])
    }
    
    @IBAction func buttonOnePressed(_ sender: UIButton) {
        videoView.load(withVideoId: "q5CHHrE7pqY", playerVars: ["playsinLine": "1"])
    }
    
    @IBAction func buttonTwoPressed(_ sender: UIButton) {
        videoView.load(withVideoId: "k63y5YWIcZo", playerVars: ["playsinLine": "1"])
    }
    
    @IBAction func buttonThreePressed(_ sender: UIButton) {
        videoView.load(withVideoId: "hyRs3F6fwLA", playerVars: ["playsinLine": "1"])
    }
    
    @IBAction func buttonFourPressed(_ sender: UIButton) {
        videoView.load(withVideoId: "9VvPVm-yVLQ", playerVars: ["playsinLine": "1"])
    }
    
}
