//
//  MusicPlayerViewController.swift
//  TheSongs
//
//  Created by PikaDot on 4/2/17.
//  Copyright © 2017 Midhun P Mathew. All rights reserved.
//

import UIKit
import AVFoundation
class MusicPlayerViewController: UIViewController {
    public var songTrackId = 0;
    var audioPlayer:AVAudioPlayer!
    var isShuffle = false
    var progressTimer:Timer?
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var songTitleLabel: UILabel!
    @IBOutlet weak var writerLabel: UILabel!
    @IBOutlet weak var currentTimeLabel: UILabel!
    @IBOutlet weak var totalTimeLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var stopAndPlayToggleButton: UIButton!
    @IBOutlet weak var shuffleButton: UIButton!
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playSong()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        stopAudioPlayer()
        if progressTimer != nil {
            progressTimer?.invalidate()
        }
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
     // MARK: - Utility methods
    func updateProgressView(){
        if audioPlayer.isPlaying {
            DispatchQueue.main.async {
                self.currentTimeLabel.text = self.stringFromTimeInterval(interval: self.audioPlayer.currentTime)
                self.progressView.setProgress(Float(self.audioPlayer.currentTime / self.audioPlayer.duration), animated: true)
            }
        }
        
    }
    
    func updateUIWithSongInfo(songInfo:SongInfoModel) {
        DispatchQueue.main.async {
            self.coverImageView.image = songInfo.coverImage
            self.songTitleLabel.text = songInfo.titel
            self.writerLabel.text = songInfo.writer
        }
    }
    
    func loadAudioPlayerWithSong(songUrl:URL) {
        do {
            audioPlayer =  try AVAudioPlayer(contentsOf: songUrl)
            let audioSession = AVAudioSession.sharedInstance()
            do {
                try audioSession.setCategory(AVAudioSessionCategoryPlayback)
            }catch{
                print(error)
            }
            if (audioPlayer.prepareToPlay()) {
                totalTimeLabel.text = stringFromTimeInterval(interval: audioPlayer.duration)
                currentTimeLabel.text = stringFromTimeInterval(interval: audioPlayer.currentTime)
                audioPlayer.play()
                progressTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(MusicPlayerViewController.updateProgressView), userInfo: nil, repeats: true)
                progressView.setProgress(Float(audioPlayer.currentTime / audioPlayer.duration), animated: false)
                stopAndPlayToggleButton.setBackgroundImage(UIImage(named: "stop_btn"), for: UIControlState.normal)
            }
            
        } catch {
            print(error)
        }
    }
    
    func stringFromTimeInterval(interval: TimeInterval) -> String {
        let time = NSInteger(interval)
        let seconds = Int(time % 60)
        let minutes = Int((time / 60) % 60)
        return String(format: "%0.2d.%0.2d",minutes,seconds)
    }

    func stopAudioPlayer() {
        guard (audioPlayer) != nil else {
            return
        }
         audioPlayer.stop()
         audioPlayer.currentTime = 0.0
         progressView.setProgress(0.0, animated: false)
         stopAndPlayToggleButton.setBackgroundImage(UIImage(named: "play_green_btn"), for: UIControlState.normal)
    }
    
    func playAudioPlayer() {
         audioPlayer.play()
         stopAndPlayToggleButton.setBackgroundImage(UIImage(named: "stop_btn"), for: UIControlState.normal)
    }
    
    func pauseAudioPlayer() {
         audioPlayer.pause()
         stopAndPlayToggleButton.setBackgroundImage(UIImage(named: "play_green_btn"), for: UIControlState.normal)
    }
    
    func playSong(){
        let songAsset = MusicLibrary.shared.songAssets[songTrackId]
        if progressTimer != nil {
            progressTimer?.invalidate()
        }
        stopAudioPlayer()
        if let url = songAsset.songURL {
            loadAudioPlayerWithSong(songUrl: url)
        }
        updateUIWithSongInfo(songInfo: songAsset)
    }
  // MARK: - IBAction methods
    @IBAction func suffleButtonAction(_ sender: UIButton) {
        isShuffle = !isShuffle
        if isShuffle {
           shuffleButton.setBackgroundImage(UIImage(named: "shuffle_on"), for: UIControlState.normal)
            let songCount =  MusicLibrary.shared.songAssets.count - 1
            songTrackId = Int(arc4random_uniform(UInt32(songCount)))
            playSong()
        }else {
           shuffleButton.setBackgroundImage(UIImage(named: "shuffle_off"), for: UIControlState.normal)
        }
    }
    
    @IBAction func repeatButtonAction(_ sender: Any) {
        stopAudioPlayer()
        playAudioPlayer()
    }
    
    @IBAction func nextButtonAction(_ sender: Any) {
        let songCount =  MusicLibrary.shared.songAssets.count - 1
        if songTrackId >= 0 && songTrackId < songCount {
            if isShuffle {
              songTrackId = Int(arc4random_uniform(UInt32(songCount)))
            }else{
              songTrackId += 1
            }
            playSong()
        }
    }
    
    @IBAction func previousAction(_ sender: Any) {
        let songCount =  MusicLibrary.shared.songAssets.count - 1
        if songTrackId != 0  {
            if isShuffle {
              songTrackId = Int(arc4random_uniform(UInt32(songCount)))
            }else{
              songTrackId -= 1
            }
            playSong()
        }
    }
    
    @IBAction func forwardButtonAction(_ sender: Any) {
        var time : TimeInterval = audioPlayer.currentTime
        time += 5
        if time > audioPlayer.duration {
            stopAudioPlayer()
        }else {
            audioPlayer.currentTime = time
        }
        
    }
    
    @IBAction func playAndStopAction(_ sender: Any) {
        if audioPlayer.isPlaying {
           pauseAudioPlayer()
        }else {
           playAudioPlayer()
        }
    }
    
    @IBAction func rewindAction(_ sender: Any) {
        var time : TimeInterval = audioPlayer.currentTime
        time -= 5
        if time < 0 {
            stopAudioPlayer()
        }else {
            audioPlayer.currentTime = time
        }
    }
    
}
