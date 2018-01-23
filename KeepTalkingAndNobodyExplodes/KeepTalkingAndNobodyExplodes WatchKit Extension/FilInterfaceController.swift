//
//  FilInterfaceController.swift
//  KeepTalkingAndNobodyExplodes WatchKit Extension
//
//  Created by David Fournier on 06/01/2018.
//  Copyright © 2018 Salomé Russier. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity

class FilInterfaceController: WKInterfaceController {

    @IBOutlet var voyant: WKInterfaceGroup!
    @IBOutlet var fil1: WKInterfaceButton!
    @IBOutlet var fil2: WKInterfaceButton!
    @IBOutlet var fil3: WKInterfaceButton!
    var num = VarGlobals.number
    var enigmeEnd = false
    
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
    
    func fail(){
        
        voyant.setBackgroundColor(UIColor.red)
        fil1.setEnabled(false)
        fil2.setEnabled(false)
        fil3.setEnabled(false)
        
        let action = WKAlertAction(title: "Ok", style: .default, handler: {
            self.dismiss()
            
            let session = WCSession.default
            guard session.isReachable else {
                return
            }
            session.sendMessage(["Game":"perdu"], replyHandler: nil, errorHandler: nil)
            VarGlobals.shared.resetVar()
            
            DispatchQueue.main.async {
                self.presentController(withName: "StartInterfaceController", context: nil)
            }
        })
        
        presentAlert(withTitle: "Game Over", message: "", preferredStyle: .actionSheet, actions: [action])
        
        
    }
    
    func upReussi(){
        enigmeEnd = true
        VarGlobals.shared.updateNbrReussi()
            voyant.setBackgroundColor(UIColor.green)
            fil1.setEnabled(false)
            fil2.setEnabled(false)
            fil3.setEnabled(false)
        
        if VarGlobals.shared.nbrReussie == 3 {
            //envoie iphone reussi
            
            let h0 = {
                self.dismiss()
            }
            
            let action = WKAlertAction(title: "Ok", style: .default, handler:h0)
            
            presentAlert(withTitle: "Bravo, bombe désamorcer", message: "", preferredStyle: .actionSheet, actions: [action])
            
            let session = WCSession.default
            guard session.isReachable else {
                return
            }
            session.sendMessage(["Game":"gagne"], replyHandler: nil, errorHandler: nil)
            VarGlobals.shared.resetVar()
        }
    }
    
    @IBAction func ClickFil1() {
        if enigmeEnd == false {
            if num == 3 {
                let image = UIImage(named: "red") as UIImage?
                fil1.setBackgroundImage(image)
                upReussi()
            }else{
                    let image = UIImage(named: "blue") as UIImage?
                    fil1.setBackgroundImage(image)
                fail()
            }
        }
    }
    
    @IBAction func ClickFil2() {
        if enigmeEnd == false {
            if num == 2{
                let image = UIImage(named: "red") as UIImage?
                fil2.setBackgroundImage(image)
                upReussi()
            }else{
                if num == 1{
                    let image = UIImage(named: "red") as UIImage?
                    fil2.setBackgroundImage(image)
                    
                }
                else {
                    let image = UIImage(named: "yellow") as UIImage?
                    fil2.setBackgroundImage(image)
                }
                fail()
            }
        }
    }
    
    @IBAction func ClickFil3() {
        if enigmeEnd == false {
            if num == 1 {
                let image = UIImage(named: "blue") as UIImage?
                fil3.setBackgroundImage(image)
                upReussi()
            }else{
                if num == 2{
                    let image = UIImage(named: "yellow") as UIImage?
                    fil3.setBackgroundImage(image)
                }
                else {
                    let image = UIImage(named: "blue") as UIImage?
                    fil3.setBackgroundImage(image)
                }
                fail()
            }
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
extension FilInterfaceController : WCSessionDelegate {
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {}
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {
        if let action = message["action"] as? String {
            print(action)
            if action == "perdu"{
               fail()
            }
        }else{
            print("game over not working")
        }
    }
}

