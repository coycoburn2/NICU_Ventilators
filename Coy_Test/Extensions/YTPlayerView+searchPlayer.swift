//
//  YTPlayer+searchYTPlayer.swift
//  Coy_Test
//
//  Created by Coy Coburn on 12/5/22.
//

import Foundation
import UIKit
import youtube_ios_player_helper

@MainActor
func fetchPlayer(_ foundPlayer: inout YTPlayerView, _ player: YTPlayerView)
{
    foundPlayer = player
    return
}


func searchPlayer(playerText: String, subviewArray: Array<UIView>) -> YTPlayerView
{
    /*
    do
    {
        let foundPlayer: YTPlayerView
        var flag: Bool = false
        let temp: String
        for view in subviewArray
        {
            if let player = view as? YTPlayerView
            {
                //let group = DispatchGroup()
                
                //group.enter()
                /*
                 fetchPlayer(playerText: playerText, player: player) { (Bool) in
                 if Bool == true
                 {
                 foundPlayer = player
                 print("Found the YTPlayer", foundPlayer)
                 flag = true
                 }
                 //group.leave()
                 }
                 //group.leave()
                 
                 group.wait()
                 */
                temp = try await player.videoUrl().absoluteString.youtubeID
                await MainActor.run
                {
                    if playerText == temp
                    {
                        //await store.assignYTView(fp: &foundPlayer, player: player)
                        //return temp ?? ""
                        //fetchPlayer(foundPlayer, player)
                        return player
                    }
                }
                /*if playerText == player{
                 //scrollStackView.removeArrangedSubview(label)
                 //label.removeFromSuperview()
                 //print("Index: ", buttonIndex)
                 foundPlayer = player
                 }*/
            }
        }
        return
    }
    catch
    {
        //foundPlayer = await YTPlayerView()
        return await YTPlayerView()
    }
    */
    return YTPlayerView()
}
