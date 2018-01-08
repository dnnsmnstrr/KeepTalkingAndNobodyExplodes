//
//  CouleurInterfaceController.swift
//  KeepTalkingAndNobodyExplodes WatchKit Extension
//
//  Created by David Fournier on 06/01/2018.
//  Copyright © 2018 Salomé Russier. All rights reserved.
//

import WatchKit
import Foundation


class CouleurInterfaceController: WKInterfaceController {

    @IBOutlet var voyant: WKInterfaceGroup!
    @IBOutlet var btn1: WKInterfaceButton!
    @IBOutlet var btn2: WKInterfaceButton!
    @IBOutlet var btn3: WKInterfaceButton!
    @IBOutlet var btn4: WKInterfaceButton!
    var num = RandomChoice.number
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        

        if num == 1 {
            btn1.setBackgroundColor(UIColor.red)
            btn2.setBackgroundColor(UIColor.blue)
            btn3.setBackgroundColor(UIColor.yellow)
            btn4.setBackgroundColor(UIColor.green)

        }else if num == 2{
            btn1.setBackgroundColor(UIColor.blue)
            btn2.setBackgroundColor(UIColor.red)
            btn3.setBackgroundColor(UIColor.green)
            btn4.setBackgroundColor(UIColor.yellow)
        }else{
            btn1.setBackgroundColor(UIColor.yellow)
            btn2.setBackgroundColor(UIColor.green)
            btn3.setBackgroundColor(UIColor.red)
            btn4.setBackgroundColor(UIColor.blue)
        }
    
    
    
    }
    
    
    
    
    
    
    
    
    @IBAction func ClickBtn1() {
    }
    
    @IBAction func ClickBtn2() {
    }
    
    @IBAction func ClickBtn3() {
    }
    
    @IBAction func ClickBtn4() {
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
