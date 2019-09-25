//
//  ViewController.swift
//  screenie
//
//  Created by camilo andres ibarra yepes on 9/24/19.
//  Copyright © 2019 camilo andres ibarra yepes. All rights reserved.
//

import UIKit
//import ReplayKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var imagePicker: UISegmentedControl!
    @IBOutlet weak var selectedImageView: UIImageView!
    @IBOutlet weak var miceToggle: UISwitch!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var TextView: UITextView!
    
    //var recorder = RPScreenRecorder.shared()
    private var isRecording = false
    
    @IBAction func imagePicked(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
            case 0:
                selectedImageView.image = UIImage(named: "end_game")!
                TextView.contentOffset = .zero
                TextView.text = """
            Avengers: Endgame is a 2019 American superhero film based on the Marvel Comics superhero team the Avengers, produced by Marvel Studios and distributed by Walt Disney Studios Motion Pictures. It is the sequel to 2012's The Avengers, 2015's Avengers: Age of Ultron, and 2018's Avengers: Infinity War, and the twenty-second film in the Marvel Cinematic Universe (MCU). It was directed by Anthony and Joe Russo and written by Christopher Markus and Stephen McFeely, and features an ensemble cast including Robert Downey Jr., Chris Evans, Mark Ruffalo, Chris Hemsworth, Scarlett Johansson, Jeremy Renner, Don Cheadle, Paul Rudd, Brie Larson, Karen Gillan, Danai Gurira, Benedict Wong, Jon Favreau, Bradley Cooper, Gwyneth Paltrow, and Josh Brolin. In the film, the surviving members of the Avengers and their allies attempt to reverse the damage caused by Thanos in Infinity War
            """
            case 1:
                selectedImageView.image = UIImage(named: "joker")!
                TextView.contentOffset = .zero
                TextView.text = """
            Joker is a 2019 American psychological thriller film directed by Todd Phillips, who co-wrote the screenplay with Scott Silver. The film, based on DC Comics characters, stars Joaquin Phoenix as the Joker. Distributed by Warner Bros. Pictures, it is intended to launch DC Black, a series of DC-based standalone films. The film, which acts as an origin story for the Joker, is set in 1981 and follows Arthur Fleck, a failed stand-up comedian who turns to a life of crime and chaos in Gotham City. Robert De Niro, Zazie Beetz, and Frances Conroy appear in supporting roles. Phillips conceived Joker in 2016 and wrote the script with Silver throughout 2017. The two were inspired by 1970s character studies and the works of Martin Scorsese (who was initially attached to the project as a producer); the graphic novel Batman: The Killing Joke (1988) served as the basis for the film's premise, but Phillips and Silver otherwise did not look to specific comics for inspiration. Phoenix became attached to the project in February 2018 and was cast that July, while the majority of the cast signed on by August. Principal photography lasted from September to December 2018 and took place in New York City, Jersey City, and Newark. Joker was the first live-action Batman franchise film to receive an R-rating from the Motion Picture Association of America, due to its violent and disturbing content.
            """
            case 2:
                selectedImageView.image = UIImage(named: "lion_king")!
                TextView.contentOffset = .zero
                TextView.text = """
                The Lion King is a Disney media franchise comprising a film series and additional media. The success of the original 1994 American animated feature, The Lion King, directed by Roger Allers and Rob Minkoff, led to two direct-to-video sequel films, a 2019 film remake, a television film sequel, two spin-off television series, three educational shorts, several video games, merchandise, and the third-longest-running musical in Broadway history, which garnered six Tony Awards including Best Musical.[1] The franchise, lead by the musical's box office at $8.1 billion (as of December 2017), is the highest-grossing entertainment property.[2] The franchise as a whole has EGOT-ed, meaning it has won the four biggest awards of American show business.

                The franchise mainly revolves about a pride of lions who oversee a large swath of African savanna as their "kingdom" known as the Pride Lands, with their leader Simba watching over it as "king". The first three animated films are widely known for being influenced by the works of William Shakespeare,[3][4] as well as other works based on his material.
            """
            
            
            case 3:
                selectedImageView.image = UIImage(named: "yesterday")!
                TextView.contentOffset = .zero
                TextView.text = """
                Yesterday is a 2019 romantic comedy film directed by Danny Boyle and written by Richard Curtis, based on a story by Jack Barth and Curtis.[2][3] It stars Himesh Patel as struggling musician Jack Malik, who, after an accident, finds himself the only person who remembers the Beatles and becomes famous after taking credit for their songs. The film also stars Lily James as the protagonist's childhood friend and love interest, Kate McKinnon as his manager, and Ed Sheeran as a fictionalised version of himself.

                The project was announced in March 2018. Filming began the following month around England, particularly Suffolk. Photography also took place at Wembley Stadium, Principality Stadium and in Los Angeles. The filmmakers paid $10 million for the rights to use the Beatles' music; although none of the Beatles were involved, Boyle received blessings from them and their families.
                """
            default:
                selectedImageView.image = UIImage(named: "skate")!
        }
    }
    @IBAction func recordButtonPressed(_ sender: Any) {
        if !isRecording {
            //startRecording()
        }else{
            //stopRecording()
        }
    }
    
    /*func startRecording(){
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
    */
    func viewReset(){
        miceToggle.isEnabled = true
        statusLabel.text = "Ready to record"
        statusLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        recordButton.setTitle("Record", for: .normal)
        recordButton.setTitleColor(#colorLiteral(red: 0.1927001459, green: 0.417473033, blue: 0.2043559011, alpha: 1), for: .normal)
    }
    
    /*func previewControllerDidFinish(_ previewController: RPPreviewViewController) {
        dismiss(animated: true, completion: nil)
    }*/
}

