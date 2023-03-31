//
//  LettoreMultimediale.swift
//  audio
//
//  Created by Gaetano Martedì on 30/06/18.
//  Copyright © 2018 iOS Foundation. All rights reserved.
//

import UIKit
import AVFoundation
var urlAudio = String()
var titolo = String()

class LettoreMultimediale: UIViewController {
    var timeService: TimeServiceManager! = TimeServiceManager()

    
    var normal = UIControlState()
    var audioPlayer = AVAudioPlayer()
    
    @IBOutlet weak var connectionsLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var inizio: UILabel!
    @IBOutlet weak var fine: UILabel!
    @IBOutlet weak var pulsanteP: UIButton!
    
    var tempoEsecuzione = String(0.0)
    
    @IBAction func sincronizza(_ sender: Any) {
        if tempoEsecuzione != "0.0"{
            audioPlayer.currentTime = Double(tempoEsecuzione)! + 0.1
            timer = DispatchSource.makeTimerSource(flags: [], queue: DispatchQueue.main)
            audioPlayer.play()
            pulsanteP.setImage(#imageLiteral(resourceName: "pause"), for: normal)
            stato = 1
            timer?.schedule(deadline: DispatchTime.now(), repeating: DispatchTimeInterval.seconds(Int(0.5)), leeway: .milliseconds(5))
            timer?.setEventHandler(qos: .userInitiated, flags: [], handler: aggiornaSlider)
            timer?.resume()
        }
        
    }
    
    
    @IBAction func manuale(_ sender: Any) {
        audioPlayer.currentTime = Double(slider.value)
        let tempoCorrente = (((Int(slider.value) % 3600) / 60 ), ((Int(slider.value) % 3600) % 60))
        if tempoCorrente.1 <= 9{
        inizio.text = "\(tempoCorrente.0).0\(tempoCorrente.1)"
        } else {
            inizio.text = "\(tempoCorrente.0).\(tempoCorrente.1)"
        }
    }
    
    var stato = 0
    
    var timer: DispatchSourceTimer?
    func aggiornaSlider() {
        let tempo = Float(audioPlayer.currentTime)
        slider.setValue(tempo, animated: false)
        let tempoCorrente = (((Int(audioPlayer.currentTime) % 3600) / 60 ), ((Int(audioPlayer.currentTime) % 3600) % 60))
        if tempoCorrente.1 <= 9{
            inizio.text = "\(tempoCorrente.0).0\(tempoCorrente.1)"
        } else {
            inizio.text = "\(tempoCorrente.0).\(tempoCorrente.1)"
        }
        
    }
    
    @IBAction func play(_ sender: Any) {
        if stato == 0 {
            print(audioPlayer.currentTime)
            pulsanteP.setImage(#imageLiteral(resourceName: "pause"), for: normal)
            audioPlayer.prepareToPlay()
            
            timer = DispatchSource.makeTimerSource(flags: [], queue: DispatchQueue.main)
            audioPlayer.play()
            timer?.schedule(deadline: DispatchTime.now(), repeating: DispatchTimeInterval.seconds(Int(0.5)), leeway: .milliseconds(5))
            timer?.setEventHandler(qos: .userInitiated, flags: [], handler: aggiornaSlider)
            timer?.resume()
            
            
            
            stato = 1
        } else {
            pulsanteP.setImage(#imageLiteral(resourceName: "play-button"), for: normal)
            audioPlayer.pause()
            stato = 0
        }
        
    }
    
    @IBAction func reset(_ sender: Any) {
        timer?.cancel()
        timer = nil
        audioPlayer.stop()
        audioPlayer.currentTime = 0
        stato = 0
        inizio.text = String(format:"%.2f", 0.0)
        slider.setValue(0.0, animated: false)
        pulsanteP.setImage(#imageLiteral(resourceName: "play-button"), for: normal)
        timeService = nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = titolo
        pulsanteP.setImage(#imageLiteral(resourceName: "play-button"), for: normal)
        
        let audioSourceURL: URL!
        audioSourceURL = Bundle.main.url(forResource: urlAudio, withExtension: "mp3")
        
        if audioSourceURL == nil {
            print("file non trovato")
        } else {
            do {
                try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback, with: .mixWithOthers)
                try AVAudioSession.sharedInstance().setActive(true)
                audioPlayer = try AVAudioPlayer.init(contentsOf: audioSourceURL!)
                
            } catch {
                print(error)
            }
        }
        let audioDuration = (((Int(audioPlayer.duration) % 3600) / 60), ((Int(audioPlayer.duration) % 3600) % 60))
        if audioDuration.1 <= 9 {
            fine.text = "\(audioDuration.0).0\(audioDuration.1)"
            
        } else{
            fine.text = "\(audioDuration.0).\(audioDuration.1)"
        }
        slider.maximumValue = Float(audioPlayer.duration)
        timeService.delegate = self as TimeServiceManagerDelegate
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    override func viewWillDisappear(_ animated: Bool) {
        reset(1)
    }
}



extension LettoreMultimediale : TimeServiceManagerDelegate {
    func connectedDevicesChanged(manager: TimeServiceManager, connectedDevices: [String]) {
        OperationQueue.main.addOperation {
            self.connectionsLabel.text = "Connections: \(connectedDevices)"
        }
    }
    
    
    func timeSend(manager: TimeServiceManager, timeString: String) {
        OperationQueue.main.addOperation {
            
            self.tempoEsecuzione = timeString
            
        }
    }
    
}
