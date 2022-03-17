//
//  BallViewController.swift
//  fortuneTelling
//
//  Created by 方仕賢 on 2022/3/16.
//

import UIKit

class BallViewController: UIViewController {
    
    @IBOutlet weak var gradientView: UIView!
    var gradientLayer = CAGradientLayer()
    var colors = [UIColor.red.cgColor, UIColor.orange.cgColor, UIColor.yellow.cgColor, UIColor.green.cgColor, UIColor.blue.cgColor, UIColor.purple.cgColor, UIColor.brown.cgColor, UIColor.gray.cgColor, UIColor.black.cgColor]
    
    var tempColor = UIColor.red.cgColor

    override func viewDidLoad() {
        super.viewDidLoad()
       gradientAnitmate()
        // Do any additional setup after loading the view.
    }
    
    func gradientAnitmate(){
        let _ = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
            self.tempColor = self.colors.first!
            self.colors.removeFirst()
            self.colors.append(self.tempColor)
            self.makeGradient()
        }
    }
    
    func makeGradient(){
        gradientLayer.frame = CGRect(x: 0, y: 0, width: gradientView.bounds.width, height: gradientView.bounds.height)
        gradientLayer.colors = colors
        gradientLayer.cornerRadius = 107
        gradientView.layer.addSublayer(gradientLayer)
    }
    

   
}
