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

    @IBOutlet var diode: WKInterfaceGroup!
    @IBOutlet var btnLettre1: WKInterfaceButton!
    @IBOutlet var btnLettre2: WKInterfaceButton!
    @IBOutlet var btnLettre3: WKInterfaceButton!
    @IBOutlet var btnLettre4: WKInterfaceButton!
    var num = VarGlobals.number
    
    var essaie = VarGlobals.shared.nbrEssaie
    var letterClick: [Int] = []

    
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

    func upReussi(){
        VarGlobals.shared.updateNbrReussi()
        
            diode.setBackgroundColor(UIColor.green)
            btnLettre1.setEnabled(false)
            btnLettre2.setEnabled(false)
            btnLettre3.setEnabled(false)
            btnLettre4.setEnabled(false)
            
        
        
        if VarGlobals.shared.nbrReussie == 3 {
            //envoie iphone reussi
            
            let h0 = { }
            
            let action = WKAlertAction(title: "Ok", style: .default, handler:h0)
            
            
            presentAlert(withTitle: "Bravo, bombe désamorcer", message: "", preferredStyle: .actionSheet, actions: [action])
        }
    }
 
    func verifyTab(){
        
        if num == 1 {
            if letterClick[0] == 3 {
                if letterClick[1] == 2 {
                    
                            upReussi()
                            return
                }
            }
            
        }else if num == 2{
            if letterClick[0] == 1 {
                if letterClick[1] == 2 {
                    
                    upReussi()
                    return
                    
                    
                }
            
            }
        }else{
            if letterClick[0] == 3 {
                if letterClick[1] == 4 {
    
                    upReussi()
                    return
    
    
    
                }
            }
        }
        letterClick.removeAll()
        
        let h0 = { print("ok")}
        let h1 = { self.popToRootController()}

        
        let action = WKAlertAction(title: "ok", style: .default, handler:h0)
        let action1 = WKAlertAction(title: "ok", style: .default, handler:h1)

        VarGlobals.shared.updateNbrEssaie() //prévenir iphone
        
        if(VarGlobals.shared.nbrEssaie > 2){
            
            presentAlert(withTitle: "Perdu", message: "", preferredStyle: .alert, actions: [action1])
            let session = WCSession.default
            
            session().transferUserInfo(["Game":"perdu"])
        }else{
            presentAlert(withTitle: "Erreur", message: "", preferredStyle: .actionSheet, actions: [action])
            
        }
        //envoie iphone erreur
    }
    
    
    
    @IBAction func ClickLettre1() {
        if letterClick.count < 2 {
            letterClick.append(1)
        }
        if letterClick.count == 2{
            verifyTab()
        }
    }
    
    @IBAction func ClickLettre2() {
        if letterClick.count < 2 {
            letterClick.append(2)
        }
        if letterClick.count == 2{
            verifyTab()
        }
    }
    @IBAction func ClickLettre3() {
        if letterClick.count < 2 {
            letterClick.append(3)
        }
        if letterClick.count == 2{
            verifyTab()
        }
    }
    @IBAction func ClickLettre4() {
        if letterClick.count < 2 {
            letterClick.append(4)
        }
        if letterClick.count == 2{
            verifyTab()
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
