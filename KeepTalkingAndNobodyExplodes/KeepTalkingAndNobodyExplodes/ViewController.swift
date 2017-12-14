//
//  ViewController.swift
//  KeepTalkingAndNobodyExplodes
//
//  Created by Salomé Russier on 13/12/2017.
//  Copyright © 2017 Salomé Russier. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var btnStart: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func StartGame(_ sender: Any) {
        print("start")
        self.present(ManuelViewController.newInstance(), animated: true, completion: nil)

    }
    
    
    

}

