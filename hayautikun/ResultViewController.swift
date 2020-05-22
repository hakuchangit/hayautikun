//
//  ResultViewController.swift
//  hayautikun
//
//  Created by hakuchan on 2019/11/14.
//  Copyright © 2019 izumi kiuchi. All rights reserved.
//

import UIKit
import AVFoundation

class ResultViewController: UIViewController {
    @IBOutlet weak var ansnumber: UILabel!
    var seikainum = 0
    @IBOutlet weak var homebutton: UIButton!
    @IBOutlet weak var mouitibutton: UIButton!
    var speak:AVSpeechSynthesizer = AVSpeechSynthesizer()
    
    
    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        
        ansnumber.adjustsFontSizeToFitWidth = true
        ansnumber.font = ansnumber.font.withSize(160)
        let resulabe = String(seikainum) + "問"
        let resu = String(seikainum) + "問正解"
        let content = AVSpeechUtterance(string: resu)
        content.voice = AVSpeechSynthesisVoice(language: "ja-JP")
       // content.volume = 0
        self.speak.speak(content)
        
        
        ansnumber.text = resulabe
        
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func gohomebutton(_ sender: Any) {
        let viewControllerStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = viewControllerStoryboard.instantiateInitialViewController() as! ViewController
          viewController.modalPresentationStyle = .fullScreen
          self.present(viewController, animated: true)
    }
    
    @IBAction func gomouitibutton(_ sender: Any) {
       let viewControllerStoryboard = UIStoryboard(name: "PlayViewController", bundle: nil)
       let viewController = viewControllerStoryboard.instantiateInitialViewController() as! PlayViewController
         viewController.modalPresentationStyle = .fullScreen
         self.present(viewController, animated: true)
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
