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
            session.delegate = self
            session.activate()
        }
        
        diode1.layer.cornerRadius = 20
        diode2.layer.cornerRadius = 20
        diode3.layer.cornerRadius = 20
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

}
extension LettreInfoViewController : WCSessionDelegate {
    func sessionDidBecomeInactive(_ session: WCSession) {}
    
    func sessionDidDeactivate(_ session: WCSession) {}
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {}
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        
        guard let name = message["Game"] as? String else{
            return
        }
        if (name == "essaie1"){
            
            VarGlobalsIphone.shared.updateNbrEssaie()
            DispatchQueue.main.async {
                self.diode3.backgroundColor = UIColor.red
            }
        }
        
        if (name == "essaie2"){
            DispatchQueue.main.async {
                self.diode2.backgroundColor = UIColor.red
            }
            VarGlobalsIphone.shared.updateNbrEssaie()
        }
        if (name == "essaie3"){
            DispatchQueue.main.async {
                self.diode1.backgroundColor = UIColor.red
            }
            VarGlobalsIphone.shared.updateNbrEssaie()
        }
        
        if (name == "perdu"){
            let alertBox = UIAlertController(title: "Game Over",
                                             message: "Votre ami(e) a péri... Honte sur vous ",
                preferredStyle: .alert)
            //valisation
            let confirmAction = UIAlertAction(title: "J'ai honte", style: .cancel) {(_)in
                self.dismiss(animated: true, completion: {})
            }
    
            alertBox.addAction(confirmAction)
            
            self.present(alertBox, animated: true, completion: nil)
        }
        
        if (name == "gagne"){
            let score = timerLeft
            let alertBox = UIAlertController(title: "Sauvegarder le score",
                                             message: "Votre score est de \(score) \nComment vous appelez vous ? ",
                preferredStyle: .alert)
            alertBox.addTextField{
                (textField: UITextField) in
                textField.placeholder = "Nom"
            }
            
            let confirmAction = UIAlertAction(title: "Valider",
                                              style: .default) { (_) in
                                                let name = alertBox.textFields?[0].text
                                                Score.shared.InsertScore(name: name!, point: Double(score))
                                                //Score.shared.GetScoreOrdred()
                                                self.dismiss(animated: true, completion: nil)
                                                
            }
            alertBox.addAction(confirmAction)
            self.present(alertBox, animated: true, completion: nil)
        }
    }
}

