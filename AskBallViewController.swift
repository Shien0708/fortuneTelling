//
//  AskBallViewController.swift
//  fortuneTelling
//
//  Created by 方仕賢 on 2022/3/16.
//

import UIKit

class AskBallViewController: UIViewController {
    
    @IBOutlet weak var gradientView: UIView!
    @IBOutlet weak var questionTextField: UITextField!
    @IBOutlet weak var answerTextView: UITextView!
    var colors = [UIColor.red.cgColor, UIColor.orange.cgColor, UIColor.yellow.cgColor, UIColor.green.cgColor, UIColor.blue.cgColor, UIColor.purple.cgColor, UIColor.brown.cgColor, UIColor.gray.cgColor, UIColor.black.cgColor]
    var currentColor = UIColor.red.cgColor
    var question = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gradientView.alpha = 0.5
        makeGradientView()
        changeColor()
        // Do any additional setup after loading the view.
    }
    
    func makeGradientView(){
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors
        gradientLayer.frame = CGRect(x: 0, y: 0, width: gradientView.bounds.width, height: gradientView.bounds.height)
        gradientView.layer.addSublayer(gradientLayer)
    }
    
    func changeColor(){
        let timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            self.currentColor = self.colors.first!
            self.colors.removeFirst()
            self.colors.append(self.currentColor)
            self.makeGradientView()
        }
    }
    
    func detectSentence(){
        if question.hasSuffix("love me?") {
            answerTextView.text = "Once you show your love, that person might love you. However, that person will never love you if you don't try to confess"
        } else if question.hasSuffix("look like?") {
            answerTextView.text = "You will love that person's heart whatever that person looks like !"
        } else if question.hasPrefix("do you think") {
            answerTextView.text = "Follow your heart, this is the most perfect way to solve any problems. "
        } else if question.hasPrefix("when") {
            answerTextView.text = "Always be patient ! If you keep your faith while waiting what you're pursuing, it will come at the right time :)"
        }
        
    }
    
    @IBAction func enter(_ sender: Any) {
        if questionTextField.text != "" {
            question = questionTextField.text!.lowercased()
            
            detectSentence()
        } else {
            let alert = UIAlertController(title: "Make a Question", message: "Don't be shy! Tell the ball your worries.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
    
}

extension AskBallViewController: UITextViewDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}


