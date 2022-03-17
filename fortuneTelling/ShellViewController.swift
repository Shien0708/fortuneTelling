//
//  ShellViewController.swift
//  fortuneTelling
//
//  Created by 方仕賢 on 2022/3/16.
//

import UIKit
import AVFoundation

class ShellViewController: UIViewController {
    @IBOutlet weak var bubbleImageView: UIImageView!
    @IBOutlet weak var conclusionLabel: UILabel!
    @IBOutlet weak var questionTextField: UITextField!
    
    @IBOutlet weak var askButton: UIButton!
    var sythesizer = AVSpeechSynthesizer()
    var response = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func speak(string: String){
        let utterance = AVSpeechUtterance(string: string)
        utterance.volume = 1
        utterance.rate = 0.4
        utterance.pitchMultiplier = 0.9
        sythesizer.speak(utterance)
    }
    
    func bubblePopOut(){
        var animator = UIViewPropertyAnimator(duration: 1, curve: .easeOut) {
            self.bubbleImageView.frame = self.bubbleImageView.frame.offsetBy(dx: 0, dy: -50)
            self.bubbleImageView.alpha = 1
            self.conclusionLabel.frame = self.conclusionLabel.frame.offsetBy(dx: 0, dy: -50)
            self.conclusionLabel.alpha = 1
        }
        animator.startAnimation()
        
        let timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { timer in
            
            animator = UIViewPropertyAnimator(duration: 1, curve: .easeIn, animations: {
                self.conclusionLabel.alpha = 0
                self.bubbleImageView.alpha = 0
                self.conclusionLabel.frame = self.conclusionLabel.frame.offsetBy(dx: 0, dy: 50)
                self.bubbleImageView.frame = self.bubbleImageView.frame.offsetBy(dx: 0, dy: 50)
                self.askButton.isEnabled = true
            })
            animator.startAnimation()
            
        }
    }

    @IBAction func ask(_ sender: Any) {
        
        if questionTextField.text != "" {
            askButton.isEnabled = false
            let random = Int.random(in: 0...1)
            if random == 0 {
                speak(string: "yes")
                conclusionLabel.text = "Yes"
            } else {
                speak(string: "no")
                conclusionLabel.text = "No"
            }
            bubblePopOut()
            questionTextField.text = ""
        } else {
            let alert = UIAlertController(title: "Make a Question", message: "The shell didn't hear you!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
        
    }
    
}

extension ShellViewController: UITextViewDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
