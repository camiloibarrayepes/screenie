//
//  ViewController.swift
//  screenie
//
//  Created by camilo andres ibarra yepes on 9/24/19.
//  Copyright © 2019 camilo andres ibarra yepes. All rights reserved.
//

import UIKit
import ReplayKit

class ViewController: UIViewController, RPPreviewViewControllerDelegate {
    
    
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var imagePicker: UISegmentedControl!
    @IBOutlet weak var selectedImageView: UIImageView!
    @IBOutlet weak var miceToggle: UISwitch!
    @IBOutlet weak var recordButton: UIButton!
    
    var recorder = RPScreenRecorder.shared()
    private var isRecording = false
    
    @IBAction func imagePicked(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
            case 0:
                selectedImageView.image = UIImage(named: "skate")!
            case 1:
                selectedImageView.image = UIImage(named: "food")!
            case 2:
                selectedImageView.image = UIImage(named: "cat")!
            case 3:
                selectedImageView.image = UIImage(named: "nature")!
            default:
                selectedImageView.image = UIImage(named: "skate")!
        }
    }
    @IBAction func recordButtonPressed(_ sender: Any) {
        if !isRecording {
            startRecording()
        }else{
            stopRecording()
        }
    }
    
    func startRecording(){
        guard recorder.isAvailable else {
            print("Recording is not available at this time")
            return
        }
        
        if miceToggle.isOn {
            recorder.isMicrophoneEnabled = true
        }else {
            recorder.isMicrophoneEnabled = false
        }
        
        recorder.startRecording { (error) in
            guard error == nil else {
                print("There was an error \(error)")
                return
            }
            
            print("Started recording Successfully")
            
            DispatchQueue.main.async {
                self.miceToggle.isEnabled = false
                self.recordButton.setTitleColor(#colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1), for: .normal)
                self.recordButton.setTitle("Stop", for: .normal)
                self.statusLabel.text = "Recording...."
                self.statusLabel.textColor = #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1)
                self.isRecording = true
            }
            
        }
    }
    
    func stopRecording(){
        recorder.stopRecording { (preview, error) in
            guard preview != nil else {
                print("Preview controller is not available")
                return
            }
            
            let alert = UIAlertController(title: "Recording Finished", message: "Would you like to edit or delete your recording", preferredStyle: .alert)
            
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: { (action) in
                self.recorder.discardRecording {
                    print("Recording successfully deleted")
                }
            })
            
            let editAction = UIAlertAction(title: "Edit", style: .default, handler: { (action) in
                preview?.previewControllerDelegate = self
                self.present(preview!, animated: true, completion: nil)
            })
            
            alert.addAction(deleteAction)
            alert.addAction(editAction)
            self.present(alert, animated: true, completion: nil)
            
            self.isRecording = false
            self.viewReset()
        }
    }
    
    func viewReset(){
        miceToggle.isEnabled = true
        statusLabel.text = "Ready to record"
        statusLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        recordButton.setTitle("Record", for: .normal)
        recordButton.setTitleColor(#colorLiteral(red: 0.1927001459, green: 0.417473033, blue: 0.2043559011, alpha: 1), for: .normal)
    }
    
    func previewControllerDidFinish(_ previewController: RPPreviewViewController) {
        dismiss(animated: true, completion: nil)
    }
}

