//
//  LettreInterfaceController.swift
//  KeepTalkingAndNobodyExplodes
//
//  Created by David Fournier on 06/01/2018.
//  Copyright © 2018 Salomé Russier. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity



class LettreInterfaceController: WKInterfaceController {

    @IBOutlet var voyant: WKInterfaceGroup!
    @IBOutlet var btnLettre1: WKInterfaceButton!
    @IBOutlet var btnLettre2: WKInterfaceButton!
    @IBOutlet var btnLettre3: WKInterfaceButton!
    @IBOutlet var btnLettre4: WKInterfaceButton!
    var num = VarGlobals.number
    
    var essaie = VarGlobals.shared.nbrEssaie
    
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        if WCSession.isSupported(){
            let session = WCSession.default
            session().delegate = self
            session().activate()
            
        }
        
        if num == 1 {
            btnLettre1.setTitle("£")
            btnLettre2.setTitle("§")
            btnLettre4.setTitle("ζ")
            btnLettre3.setTitle("ξ")
        }else if num == 2{
            btnLettre2.setTitle("£")
            btnLettre3.setTitle("§")
            btnLettre1.setTitle("ζ")
            btnLettre4.setTitle("ξ")
        }else{
            btnLettre2.setTitle("£")
            btnLettre3.setTitle("§")
            btnLettre1.setTitle("ζ")
            btnLettre4.setTitle("ξ")
        }
    }

 
    @IBAction func ClickLettre1() {
    }
    
    @IBAction func ClickLettre2() {
    }
    @IBAction func ClickLettre3() {
    }
    @IBAction func ClickLettre4() {
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
extension LettreInterfaceController : WCSessionDelegate {
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {
        if let action = message["action"] as? String {
            if action == "start"{


            }
        }
    }
    
    
    
}
