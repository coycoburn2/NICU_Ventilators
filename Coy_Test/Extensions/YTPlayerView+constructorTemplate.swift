//
//  YTPlayerView+constructorTemplate.swift
//  Coy_Test
//
//  Created by Coy Coburn on 12/6/22.
//

import Foundation
import UIKit
import youtube_ios_player_helper

//Template for details label during Settings/Management
func stackPlayer(videoID: String) -> YTPlayerView
{
    //NumOfLines wraps content. SetContentComp ensures label shows all of text
    let newPlayer = YTPlayerView()
    newPlayer.translatesAutoresizingMaskIntoConstraints = false
    //newPlayer.topAnchor.constraint(equalTo: parent.bottomAnchor).isActive = true
    //newPlayer.leadingAnchor.constraint(equalTo: parent.leadingAnchor).isActive = true
    //newPlayer.trailingAnchor.constraint(equalTo: parent.trailingAnchor).isActive = true
    //newPlayer.heightAnchor.constraint(equalTo: newPlayer.widthAnchor, multiplier: 9/16).isActive = true
    //newPlayer.load(withVideoId: hfovString.freqOneVideo.localized, playerVars: ["playsinLine": "1"])
    //newPlayer.backgroundColor = .blue
    newPlayer.load(withVideoId: videoID, playerVars: ["playsinLine": "1"])
    return newPlayer
}
