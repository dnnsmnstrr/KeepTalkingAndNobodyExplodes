//
//  NomInterfaceController.swift
//  KeepTalkingAndNobodyExplodes WatchKit Extension
//
//  Created by David Fournier on 06/01/2018.
//  Copyright © 2018 Salomé Russier. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity

class NomInterfaceController: WKInterfaceController {

    @IBOutlet var nom: WKInterfaceLabel!
    var num = VarGlobals.number
    var id : String = ""

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
       
        
        if num == 2 {
             id = "\(num)M-T"
        }else if num == 1{
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
extension NomInterfaceController : WCSessionDelegate {
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {}
    func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {
        if let action = message["action"] as? String {
            print(action)
            if action == "perdu"{
                let h0 = {
                    self.dismiss()
                }
                
                let action = WKAlertAction(title: "Ok", style: .default, handler:h0)
                
                presentAlert(withTitle: "Game Over", message: "", preferredStyle: .actionSheet, actions: [action])
            }
        }else{
            print("game over not working")
        }
    }
}
