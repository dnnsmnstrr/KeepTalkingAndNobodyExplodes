//
//  NomInterfaceController.swift
//  KeepTalkingAndNobodyExplodes WatchKit Extension
//
//  Created by David Fournier on 06/01/2018.
//  Copyright © 2018 Salomé Russier. All rights reserved.
//

import WatchKit
import Foundation


class NomInterfaceController: WKInterfaceController {

    @IBOutlet var nom: WKInterfaceLabel!
    var num = VarGlobals.number
    var id : String = ""

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        if num == 1 {
             id = "\(num)M-T"
            
        }else if num == 2{
             id = "\(num)P-A"

        }else{
             id = "\(num)H-X"

        }
        nom.setText(id)
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
