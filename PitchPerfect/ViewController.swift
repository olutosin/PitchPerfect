//
//  ViewController.swift
//  PitchPerfect
//
//  Created by Olutosin Oduwole on 07/11/2017.
//  Copyright © 2017 Olutosin Oduwole. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var recordingLabel: UILabel!;
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopRecordingButton: UIButton!
    
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
        //print("recor button was pressed")
        
        //
        recordingLabel.text = "Recording in progress...";
    }
    
    @IBAction func stopRecording(_ sender: UIButton) {
        //
        recordingLabel.text = "Recording stopped.";
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

