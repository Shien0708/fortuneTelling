//
//  AskFlowerViewController.swift
//  fortuneTelling
//
//  Created by 方仕賢 on 2022/3/16.
//

import UIKit

class AskFlowerViewController: UIViewController {

    @IBOutlet weak var conclusionLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var flowerImageView: UIImageView!
    
    @IBOutlet weak var dropingPetalImageView: UIImageView!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var startButton: UIButton!
    
    @IBOutlet weak var againButton: UIButton!
    var petal = 0
    var name = ""
    var like = true
    var timer : Timer?
    var dropTimer : Timer?
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Do any additional setup after loading the view.
    }
    
    func drop() {
         timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            self.petal += 1
            self.flowerImageView.image = UIImage(named: "flower-\(self.petal)")
            self.dropPetal()
            self.displayLike()
            
            if self.petal == 21 {
                self.timer?.invalidate()
                self.stopButton.isHidden = true
                self.againButton.isHidden = false
            }
        }
    }
    
    func displayLike(){
        if self.like {
            self.conclusionLabel.text = "\(self.name) likes you"
            self.like = false
        } else {
            self.conclusionLabel.text = "\(self.name) doesn't like you"
            self.like = true
        }
    }
    
    func dropPetal(){
        let animator = UIViewPropertyAnimator(duration: 1, curve: .easeOut) {
            self.dropingPetalImageView.frame = self.dropingPetalImageView.frame.offsetBy(dx: 0, dy: 200)
            
            self.dropTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { timer in
                self.dropingPetalImageView.frame = self.dropingPetalImageView.frame.offsetBy(dx: 0, dy: -200)
                if self.petal == 21 {
                    self.dropTimer?.invalidate()
                    self.dropingPetalImageView.isHidden = true
                }
            }
        }
        animator.startAnimation()
    }
    
    @IBAction func start(_ sender: Any) {
        
        if nameTextField.text != "" {
            nameTextField.isHidden = true
            stopButton.isHidden = false
            petal = Int.random(in: 0...19)
            flowerImageView.image = UIImage(named: "flower-\(petal)")
            dropingPetalImageView.isHidden = false
            drop()
            name = nameTextField.text!
            nameTextField.text = ""
            displayLike()
        } else {
            let alert = UIAlertController(title: "Enter the name", message: "Don't be shy, please enter the name.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func stop(_ sender: Any) {
        nameTextField.isHidden = false
        conclusionLabel.text = "Tell me who do you like?"
        nameTextField.text = ""
        stopButton.isHidden = true
        flowerImageView.image = UIImage(named: "flower-0")
        dropingPetalImageView.isHidden = true
        timer?.invalidate()
        dropTimer?.invalidate()
        dropingPetalImageView.frame = dropingPetalImageView.frame.offsetBy(dx: 0, dy: -200)
    }
    
    
    @IBAction func again(_ sender: Any) {
        againButton.isHidden = true
        stop(stopButton)
    }
}

extension AskFlowerViewController: UITextViewDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
