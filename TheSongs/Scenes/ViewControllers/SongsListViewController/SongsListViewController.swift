//
//  SongsListViewController.swift
//  TheSongs
//
//  Created by PikaDot on 4/2/17.
//  Copyright © 2017 Midhun P Mathew. All rights reserved.
//

import UIKit

class SongsListViewController: UIViewController {
    var selecetedSongId = 0;
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Songs"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if "play_music" == segue.identifier {
            let musicPlayer = segue.destination as! MusicPlayerViewController
            musicPlayer.songTrackId = selecetedSongId
        }
    }
    @IBAction func unwindToSongsList(segue: UIStoryboardSegue) {
        
    }

}
extension SongsListViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MusicLibrary.shared.songAssets.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "song_cell", for: indexPath) as! SongTableViewCell
        let songAsset = MusicLibrary.shared.songAssets[indexPath.row]
        cell.coverImageView.image = songAsset.coverImage
        cell.songTitleLabel.text = songAsset.titel
        cell.songWriterLabel.text = songAsset.writer
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         selecetedSongId = indexPath.row;
         performSegue(withIdentifier: "play_music", sender: self);
    }
    
    
}
