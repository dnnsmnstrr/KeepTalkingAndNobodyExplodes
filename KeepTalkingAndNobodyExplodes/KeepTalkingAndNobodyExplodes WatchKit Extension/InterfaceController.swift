//
//  InterfaceController.swift
//  KeepTalkingAndNobodyExplodes WatchKit Extension
//
//  Created by Salomé Russier on 13/12/2017.
//  Copyright © 2017 Salomé Russier. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity


class InterfaceController: WKInterfaceController  {

    @IBOutlet var suiteText: WKInterfaceLabel!
    @IBOutlet var text: WKInterfaceLabel!
   
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        if WCSession.isSupported(){
            let session = WCSession.default
            session().delegate = self
            session().activate()
            
        }
        
      
        
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
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
}

extension InterfaceController : WCSessionDelegate {
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {
        if let action = message["action"] as? String {
            if action == "start"{
                text.setText("Début")
                suiteText.setText("Jeu")
            }
        }
    }
    
    
    
}
