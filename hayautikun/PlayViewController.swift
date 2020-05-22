//
//  PlayViewController.swift
//  hayautikun
//
//  Created by hakuchan on 2019/11/14.
//  Copyright © 2019 izumi kiuchi. All rights reserved.
//

import UIKit
import AVFoundation

class PlayViewController: UIViewController {
    
    var count:Int = 61
    var fcount:Int = 4
    var flag:Bool = false
    var seikai:Int = 0
    @IBOutlet weak var timerlabel: UILabel!
    var timer: Timer!
    var speak:AVSpeechSynthesizer = AVSpeechSynthesizer()
    @IBOutlet weak var textfield: UITextField!
    var audioPlayer: AVAudioPlayer!
    var question:[String] = []
    var dans:String = ""
    var pointer:Int = 0
    var hiraganad = ["あ","い","う","お","か","き","く","け","こ","さ","し","す","せ","そ"]
    
    
    var tango = ["あいす","かお","おはよう","あ","あめ","さんま","ゆき","はれ","まんもす","しいたけ","さる","くまもと","くまもん","きもの","せんせい","ふくおか","うきわ","かめ","めろん","すりる","とうふ","たいいく","さんすう","うしろ","かいこ"]
    
   
   
    

    override func viewDidLoad() {
        
        
        
       
        super.viewDidLoad()
        
       
        self.seikai = 0
            self.textfield.keyboardType = .default
            self.textfield.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        let content = AVSpeechUtterance(string: "あ")
        content.voice = AVSpeechSynthesisVoice(language: "ja-JP")
        content.volume = 0
        self.speak.speak(content)
         
            self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.startTimer), userInfo: nil, repeats: true)
            self.textfield.becomeFirstResponder()
        // Do any additional setup after loading the view.
            self.timerlabel.adjustsFontSizeToFitWidth = true
        
        self.question = self.tango
        
       
        
        
    }
    
    
    
    @objc func startTimer() {
     
        if flag {
            
            timerlabel.font = timerlabel.font.withSize(400)
            if self.count == 61{
                self.playstart()
            }
            self.count-=1
            if(self.count == 0){
                timer.invalidate()
                seni()
            }
            //print(self.count)
        }else{
            DispatchQueue.main.async {
            
                self.fcount-=1
            self.timerlabel.text = String(self.fcount)
            
            
                if self.fcount == 0 {
                Speaker.speech(text: "スタート", country: .Japan,rate: 0.5)
                      
                    self.timerlabel.font = self.timerlabel.font.withSize(160)
                self.timerlabel.text = "スタート"
             
                self.flag = true
            }else{
                
            
                    Speaker.speech(text: String(self.fcount), country: .Japan,rate: 0.5)
                    
                
            }
            }
        }
    
    }
    

    func playstart(){
        
        let soe = Int.random(in: 0..<self.question.count)
        self.dans =  self.question[soe] as! String
        self.pointer = 1
       
        var sspeed:Float = 0.5
        if self.dans.count == 2{
            sspeed = 0.3
        }else if self.dans.count == 3{
            sspeed = 0.4
        }else if self.dans.count == 4{
            sspeed = 0.4
        }
        
        Speaker.speech(text: self.dans, country: .Japan,rate: sspeed)
        timerlabel.text = self.dans
    
    }
    
   
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        let c = textField.text!
        let cc = c.trimmingCharacters(in: .whitespacesAndNewlines)
       
        
        if cc.count == 0{
            let str1 = self.dans.prefix(self.pointer)
            let cow = str1.suffix(1)
            Speaker.speech(text: String(cow ?? ""), country: .Japan,rate: 0.5)
            textfield.text = ""
        }else{
            print(textfield.text)
        if textfield.text == "あ" || textfield.text == "い" || textfield.text == "う" || textfield.text == "え" || textfield.text == "お"{
                Speaker.speech(text: String(textfield.text ?? ""), country: .Japan,rate: 0.5)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.check(inputtext:self.textfield.text!)
            }
        }else{
            if !isMatch(textfield.text ?? "")  {
                print("a")
                print(textfield.text)
                Speaker.speech(text: String(textfield.text  ?? ""), country: .Japan,rate: 0.5)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    self.check(inputtext:self.textfield.text!)
                }
            }else{
               // textfield.text = ""
            }
        }
        }
        
    }
    
    
    func check(inputtext:String){
        let str1 = self.dans.prefix(self.pointer)
        let cow = str1.suffix(1)
        
        if textfield.text! == cow {
            self.pointer += 1
            print(self.pointer)
            print(self.dans.count)
            if self.pointer == self.dans.count + 1{
                self.seikai += 1
                playSound(name: "Correct")
                               textfield.text = ""
                               DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                   self.playstart()
                               }
            }
            textfield.text = ""
        }else{
            playSound(name: "Wrong")
            textfield.text = ""
        }
        
//        if  textfield.text == self.dans{
//                self.seikai += 1
//                    playSound(name: "Correct")
//                textfield.text = ""
//                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//                    self.playstart()
//                }
//            }else{
//            playSound(name: "Wrong")
//                textfield.text = ""
//            }
    }
    
    func seni(){
       let viewControllerStoryboard = UIStoryboard(name: "ResultStoryboard", bundle: nil)
       let viewController = viewControllerStoryboard.instantiateInitialViewController() as! ResultViewController
         viewController.modalPresentationStyle = .fullScreen
        viewController.seikainum = self.seikai
         self.present(viewController, animated: true)
    }
    


}




func isMatch(_ string: String) -> Bool {
   let regex = "[a-z]{1,}"
   let text = NSPredicate(format:"SELF MATCHES %@", regex)
   let result = text.evaluate(with: string)
   return result
}



extension PlayViewController: AVAudioPlayerDelegate {
    func playSound(name: String) {
        guard let path = Bundle.main.path(forResource: name, ofType: "mp3") else {
            print("音源ファイルが見つかりません")
            return
        }
        do {
            // AVAudioPlayerのインスタンス化
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))

            // AVAudioPlayerのデリゲートをセット
            audioPlayer.delegate = self
            // 音声の再生
            audioPlayer.play()
        } catch {
        }
    }
}

/*
// MARK: - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    // Get the new view controller using segue.destination.
    // Pass the selected object to the new view controller.
}
*/
