//
//  ViewController.swift
//  hayautikun
//
//  Created by hakuchan on 2019/11/14.
//  Copyright © 2019 izumi kiuchi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func startbutton(_ sender: Any) {

        
      let viewControllerStoryboard = UIStoryboard(name: "PlayViewController", bundle: nil)
      let viewController = viewControllerStoryboard.instantiateInitialViewController() as! PlayViewController
        viewController.modalPresentationStyle = .fullScreen
        self.present(viewController, animated: true)
    }
    
    

}

