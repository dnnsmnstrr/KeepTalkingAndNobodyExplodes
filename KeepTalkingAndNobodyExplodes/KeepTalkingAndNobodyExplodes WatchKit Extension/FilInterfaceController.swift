//
//  FilInterfaceController.swift
//  KeepTalkingAndNobodyExplodes WatchKit Extension
//
//  Created by David Fournier on 06/01/2018.
//  Copyright © 2018 Salomé Russier. All rights reserved.
//

import WatchKit
import Foundation


class FilInterfaceController: WKInterfaceController {

    @IBOutlet var voyant: WKInterfaceGroup!
    @IBOutlet var fil1: WKInterfaceButton!
    @IBOutlet var fil2: WKInterfaceButton!
    @IBOutlet var fil3: WKInterfaceButton!
    var num = RandomChoice.number

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        if num == 1 {
            fil1.setBackgroundColor(UIColor.blue)
            fil2.setBackgroundColor(UIColor.red)
            fil3.setBackgroundColor(UIColor.blue)

        }else if num == 2{
            fil1.setBackgroundColor(UIColor.blue)
            fil2.setBackgroundColor(UIColor.red)
            fil3.setBackgroundColor(UIColor.yellow)
        }else{
            fil1.setBackgroundColor(UIColor.red)
            fil2.setBackgroundColor(UIColor.yellow)
            fil3.setBackgroundColor(UIColor.blue)
        }
    }
    @IBAction func ClickFil1() {
    }
    @IBAction func ClickFil2() {
    }
    @IBAction func ClickFil3() {
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
