//
//  StartInterfaceController.swift
//  KeepTalkingAndNobodyExplodes WatchKit Extension
//
//  Created by David Fournier on 07/01/2018.
//  Copyright © 2018 Salomé Russier. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity

class StartInterfaceController: WKInterfaceController {

    //et si dans un écran une action faite -> update les variables
    //et penser a allumer diode
    //si énigme réussi, bloqué énigme
    //si tout gagné notifié iphone et WIN
    //si un raté, notifié iphone
    //si 3 raté notif iphone et GAME OVER
    
    
    @IBOutlet var textAccueil: WKInterfaceLabel!
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        if WCSession.isSupported(){
            let session = WCSession.default
            session.delegate = self
            session.activate()
            
        }
        // Configure interface objects here.
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
extension StartInterfaceController : WCSessionDelegate {
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {
        //print(message["action"] as? String ?? <#default value#>)
        if let action = message["action"] as? String {
            if action == "start"{
                
                

                let controllers = ["LettreController", "CouleurController","FilController","BoutonController","NomController"]
                presentController(withNames: controllers, contexts: nil)
                

            }
        }
    }
    
    
    
}
