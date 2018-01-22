//
//  TimerViewController.swift
//  KeepTalkingAndNobodyExplodes
//
//  Created by David Fournier on 21/01/2018.
//  Copyright © 2018 Salomé Russier. All rights reserved.
//

import UIKit
import WatchConnectivity
var timerLeft = 120


class TimerViewController: UIViewController {

    @IBOutlet weak var diode1: UIView!
    @IBOutlet weak var diode2: UIView!
    @IBOutlet weak var diode3: UIView!
    
    @IBOutlet weak var timerLabel: UILabel!
    
    var myTimer: Timer!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        diode1.layer.cornerRadius = 20
        diode2.layer.cornerRadius = 20
        diode3.layer.cornerRadius = 20
        
        
        if WCSession.isSupported(){
            let session = WCSession.default
            session.delegate = self
            session.activate()
            
        }
        
       
        
        myTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.timerRunning), userInfo: nil, repeats: true)
        
        
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
    
    func hmsFrom(seconds: Int, completion: @escaping (_ hours: Int, _ minutes: Int, _ seconds: Int)->()) {
        
        completion(seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
        
    }
    
    func getStringFrom(seconds: Int) -> String {
        
        return seconds < 10 ? "0\(seconds)" : "\(seconds)"
    }
    @objc func timerRunning() {
       
        timerLeft-=1
        
        let seconds = timerLeft % 60
        let minutes = (timerLeft / 60) % 60
        
        self.timerLabel.text = String(format:"%d:%02d", minutes, seconds)
        if timerLeft == 0 {
            gameOver()
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func gameOver(){
        myTimer.invalidate()

        let alertBox = UIAlertController(title: "Game Over",
                                         message: "Votre ami(e) a péri... Honte sur vous ",
                                         preferredStyle: .alert)
        //valisation
        let confirmAction = UIAlertAction(title: "J'ai honte", style: .cancel) {(_)in
            self.dismiss(animated: true, completion: {})
            
        }
        timerLeft=120

        alertBox.addAction(confirmAction)
        
        self.present(alertBox, animated: true, completion: nil)
        
        let session = WCSession.default
        guard session.isReachable else {
            return
        }
        session.sendMessage(["action":"perdu"], replyHandler: { (res) in
            
            
        })
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
extension TimerViewController : WCSessionDelegate {
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
            DispatchQueue.main.async {
                self.diode3.backgroundColor = UIColor.red
            }
            VarGlobalsIphone.shared.updateNbrEssaie()

            
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
             gameOver()
        }
        
        
        if (name == "gagne"){
            myTimer.invalidate()
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
            timerLeft=120
        }
        
        
    }
    
}

