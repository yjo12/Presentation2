//
//  ViewController.swift
//  SwuMuck
//
//  Created by SWUCOMPUTER on 2018. 5. 26..
//  Copyright © 2018년 SWUCOMPUTER. All rights reserved.
//

import UIKit

class ViewController: UIViewController{
   
    @IBOutlet var UserWelcomelabel: UILabel!
    var info: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        if let name = appDelegate.userName {
            self.UserWelcomelabel.text = name + "님 환영합니다"
        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

