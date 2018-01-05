//
//  ViewController.swift
//  KeepTalkingAndNobodyExplodes
//
//  Created by Salomé Russier on 13/12/2017.
//  Copyright © 2017 Salomé Russier. All rights reserved.
//

import UIKit
import WatchConnectivity

class ViewController: UIViewController {

    @IBOutlet weak var btnStart: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if WCSession.isSupported(){
            let session = WCSession.default
            session().delegate = self
            session().activate()
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func StartGame(_ sender: Any) {

        let session = WCSession.default
        guard session().isReachable else {
            return
        }
        session().sendMessage(["action":"start"], replyHandler: { (res) in
            
            guard let result = res["result"] as? String else {
                return
            }
            
            
            
        })
        
        
    }
    
    
    

}

extension ViewController : WCSessionDelegate {
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        
    }
}
