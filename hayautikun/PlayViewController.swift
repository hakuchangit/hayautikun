//
//  PlayViewController.swift
//  hayautikun
//
//  Created by hakuchan on 2019/11/14.
//  Copyright © 2019 izumi kiuchi. All rights reserved.
//

import UIKit

class PlayViewController: UIViewController {
    
    var count:Int = 60
    
    @IBOutlet weak var timerlabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        var timer: Timer!
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.startTimer), userInfo: nil, repeats: true)

        // Do any additional setup after loading the view.
    }
    
    
    @objc func startTimer() {
    count-=1
    timerlabel.text = String(count)
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
