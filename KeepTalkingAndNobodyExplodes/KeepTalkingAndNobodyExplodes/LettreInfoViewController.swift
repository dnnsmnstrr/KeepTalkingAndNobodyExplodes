//
//  LettreInfoViewController.swift
//  KeepTalkingAndNobodyExplodes
//
//  Created by David Fournier on 11/01/2018.
//  Copyright © 2018 Salomé Russier. All rights reserved.
//

import UIKit
import WatchConnectivity


class LettreInfoViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var diode1: UIView!
    @IBOutlet weak var diode2: UIView!
    @IBOutlet weak var diode3: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if WCSession.isSupported(){
            let session = WCSession.default
            session().delegate = self
            session().activate()
            
        }
        
        diode1.layer.cornerRadius = 20
        diode2.layer.cornerRadius = 20
        diode3.layer.cornerRadius = 20
        
       

        // Do any additional setup after loading the view.
    }

    
    override func endAppearanceTransition() {
        if  VarGlobalsIphone.shared.nbrEssaie > 0 {
            diode3.backgroundColor = .red
        }
        if  VarGlobalsIphone.shared.nbrEssaie > 1 {
            diode2.backgroundColor = .red
        }
        if  VarGlobalsIphone.shared.nbrEssaie > 2 {
            diode1.backgroundColor = .red
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
extension LettreInfoViewController : WCSessionDelegate {
    func sessionDidBecomeInactive(_ session: WCSession) {
        
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    
    func session(_ session: WCSession, didReceiveUserInfo userInfo: [String : Any] = [:]) {
        
        guard let name = userInfo["Game"] as? String else{
            return
        }
        if (name == "essaie1"){
            diode3.backgroundColor = UIColor.red
            VarGlobalsIphone.shared.updateNbrEssaie()
        }
        if (name == "essaie2"){
            diode2.backgroundColor = UIColor.red
            VarGlobalsIphone.shared.updateNbrEssaie()

        }
        if (name == "essaie3"){
            diode1.backgroundColor = UIColor.red
            VarGlobalsIphone.shared.updateNbrEssaie()

        }
        
        if (name == "perdu"){
            let alertBox = UIAlertController(title: "Game Over",
                                             message: "Votre ami(e) a péri... Honte sur vous ",
                preferredStyle: .alert)
            //valisation
            let confirmAction = UIAlertAction(title: "J'ai honte", style: .cancel) {(_)in
                self.popoverPresentationController
            }
    
            alertBox.addAction(confirmAction)
            
            self.present(alertBox, animated: true, completion: nil)
        }
   
    }

}

