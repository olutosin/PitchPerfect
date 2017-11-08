//
//  RecordSoundsViewController.swift
//  PitchPerfect
//
//  Created by Olutosin Oduwole on 07/11/2017.
//  Copyright © 2017 Olutosin Oduwole. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {

    // MARK: Properties
    @IBOutlet weak var recordingLabel: UILabel!;
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopRecordingButton: UIButton!
    
    var audioRecorder: AVAudioRecorder!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        
        print(getDateNow());
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        print(getDateNow());
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func recordAudio(_ sender: UIButton) {
        recordButton.isEnabled = false;
        stopRecordingButton.isEnabled = true;
        recordingLabel.text = "Recording in progress...";
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"));
        
        //print(filePath);
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord, with:AVAudioSessionCategoryOptions.defaultToSpeaker)
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self;
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    @IBAction func stopRecording(_ sender: UIButton) {
        //recordingLabel.text = "Recording stopped.\nTap to Record";
        recordingLabel.text = "Tap to Record";
        recordButton.isEnabled = true;
        stopRecordingButton.isEnabled = false;
        
        audioRecorder.stop();
        let audioSession = AVAudioSession.sharedInstance();
        try! audioSession.setActive(false);
        
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        //print("Finished recording");
        if flag {
            performSegue(withIdentifier: "stopRecordingSegue", sender: audioRecorder.url)
        } else {
            print("recording was not successful")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        //
        if segue.identifier == "stopRecordingSegue" {
            let playSoundsVC = segue.destination as! PlaySoundsViewController;
            let recordedAudioURL = sender as! URL;
            playSoundsVC.recordedAudioURL = recordedAudioURL;
        }
    }
    
    private func getDateNow() -> String {
        
        let date = Date();
        let calendar = Calendar.current;
        
        let components = calendar.dateComponents([.year, .month, .day,.hour, .minute,.second, .nanosecond], from: date);
        
        let year = components.year
        let month = components.month
        let day = components.day
        let hour = components.hour
        let minute = components.minute
        let second = components.second
        let nSecond = components.nanosecond
        
        let dateNow = String(year!) + "-" + String(month!) + "-" + String(day!) + " [" + String(hour!)  + ":" + String(minute!) + ":" +  String(second!) +  ":" +  String(nSecond!) + "]";
        
        return dateNow;
    }
}

