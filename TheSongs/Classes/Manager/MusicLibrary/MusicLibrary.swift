//
//  MusicLibrary.swift
//  TheSongs
//
//  Created by PikaDot on 4/2/17.
//  Copyright © 2017 Midhun P Mathew. All rights reserved.
//

import Foundation
import UIKit
class MusicLibrary {
    static var shared = MusicLibrary()
    var songAssets = [SongInfoModel]()
    private var songInfos = [["titel":"Hallelujah holy holy",
                      "writer":"Michael W. Smith",
                      "trackId":"0",
                      "coverImage":"image-0",
                      "songPath":"song_0"],
                    ["titel":"Break Every Chain",
                      "writer":"Jesus Culture",
                      "trackId":"1",
                      "coverImage":"image-1",
                      "songPath":"song_1"],
                    ["titel":"God Will Make A Way",
                      "writer":"Don Moen",
                      "trackId":"2",
                      "coverImage":"image-2",
                      "songPath":"song_2"],
                    ["titel":"God Here I am to Worship",
                      "writer":"Hillsong Worship",
                      "trackId":"3",
                      "coverImage":"image-3",
                      "songPath":"song_3"],
                    ["titel":"How Great is Our God!",
                      "writer":"Chris Tomlin",
                      "trackId":"4",
                      "coverImage":"image-4",
                      "songPath":"song_4"],
                    ["titel":"In Christ Alone",
                       "writer":"Natalie Grant",
                       "trackId":"5",
                       "coverImage":"image-5",
                       "songPath":"song_5"],
                    ["titel":"Our God is an Awesome God!",
                      "writer":"Rich Mullins",
                      "trackId":"6",
                      "coverImage":"image-6",
                      "songPath":"song_6"],
                    ["titel":"Thank You Lord",
                       "writer":"Don Moen",
                       "trackId":"7",
                       "coverImage":"image-7",
                       "songPath":"song_7"],
                    ["titel":"Who Am I",
                       "writer":"Casting Crowns",
                       "trackId":"8",
                       "coverImage":"image-8",
                       "songPath":"song_8"],
                    ["titel":"With All I Am",
                        "writer":"Hillsong",
                        "trackId":"9",
                        "coverImage":"image-9",
                        "songPath":"song_9"]]
    
    private init(){
        
    }
    
    func createSongAssets() {
        songAssets = []
        for song in songInfos {
            let songAsset =  SongInfoModel()
            if let songTitle = song["titel"] {
                songAsset.titel  = songTitle
            }
            if let songWriter = song["writer"] {
                 songAsset.writer = songWriter
            }
            if let coverImageName = song["coverImage"] {
                songAsset.coverImage = UIImage(named: coverImageName)
            }
            
            if let trackId = song["trackId"] {
                songAsset.trackId = Int(trackId)!
            }
            if let songPath = song["songPath"] {
                let path = Bundle.main.path(forResource: songPath, ofType: "mp3")
                let songUrl = URL.init(fileURLWithPath: path!)
                songAsset.songURL = songUrl
            }
            songAssets.append(songAsset)
        }
    }
    
}
