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

    @IBOutlet var screenGame: WKInterfaceGroup!
   // @IBOutlet var screenIntro: WKInterfaceLabel!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        screenGame.setHidden(true)
        if WCSession.isSupported(){
            let session = WCSession.default
            session().delegate = self
            session().activate()
            
        }
        // Configure interface objects here.
    }

    
    @IBAction func up(_ sender: Any) {
        //self.pushController(withName: "NomController", context: nil)
        presentController(withName: "PileController", context: nil)
        
        
    }
    
    @IBAction func right(_ sender: Any) {
        self.pushController(withName: "FilController", context: nil)
        
        
        
    }
    
    @IBAction func left(_ sender: Any) {
        self.pushController(withName: "CouleurController", context: nil)
        
        
    }
    
    @IBAction func down(_ sender: Any) {
        self.pushController(withName: "NomController", context: nil)
        
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
              //  screenIntro.setHidden(true)
                screenGame.setHidden(false)


            }
        }
    }
    
    
    
}
