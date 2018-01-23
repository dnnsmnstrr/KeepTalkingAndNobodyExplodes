//
//  ViewController.swift
//  KeepTalkingAndNobodyExplodes
//
//  Created by Salomé Russier on 13/12/2017.
//  Copyright © 2017 Salomé Russier. All rights reserved.
//

import UIKit
import WatchConnectivity

class ViewController: UIViewController{

    @IBOutlet weak var btnStart: UIButton!
    @IBOutlet weak var scoreTableView: UITableView!
    
    var textCellIdentifier: String = "idCell"
    var scoreList: [Score] = []

    
    override func viewWillAppear(_ animated: Bool) {
        if WCSession.isSupported(){
            let session = WCSession.default
            session.delegate = self
            session.activate()
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // en attendant d'avoir les vrai score
        self.scoreList = Score.shared.GetScoreOrdred()
        
        scoreTableView.delegate = self
        scoreTableView.dataSource = self
    }
    override func endAppearanceTransition() {
        self.ReloadData()
    }

    @IBAction func StartGame(_ sender: Any) {
        let session = WCSession.default
        guard session.isReachable else {
            return
        }
        session.sendMessage(["action":"start"], replyHandler: { (res) in
        })
    }
    
    func showSaveScoreDialogue(score: Double){
        let alertBox = UIAlertController(title: "Sauvegarder le score",
                                        message: "Votre score est de \(score) \nComment vous appelez vous ? ",
                                        preferredStyle: .alert)
        
        alertBox.addTextField{
            (textField: UITextField) in
            textField.placeholder = "Nom"
        }
        
        //valisation
        let confirmAction = UIAlertAction(title: "Valider",
                                          style: .default) { (_) in
                                            let name = alertBox.textFields?[0].text
                                            Score.shared.InsertScore(name: name!, point: score)
                                            self.ReloadData()
        }
        
        //annuler
        let cancelAction = UIAlertAction(title: "Annuler", style: .cancel) {(_)in}
        
        alertBox.addAction(confirmAction)
        alertBox.addAction(cancelAction)
        
        self.present(alertBox, animated: true, completion: nil)
        
    }
    
    func ReloadData(){
        self.scoreList = Score.shared.GetScoreOrdred()
        self.scoreTableView.reloadData()
    }

}


extension ViewController : WCSessionDelegate {
    func sessionDidBecomeInactive(_ session: WCSession) {}
    
    func sessionDidDeactivate(_ session: WCSession) {}
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {}
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {}
}

extension ViewController : UITableViewDelegate, UITableViewDataSource {
    private func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Score.shared.getCount()
    }
    
    func tableView( _ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: textCellIdentifier, for: indexPath as IndexPath) as! ScoreTableViewCell
        
        let score = scoreList[indexPath.row]
        cell.nameLabel.text = score.name
        cell.pointLabel.text = "\(score.point)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let cell = tableView.cellForRow(at: indexPath) as! ScoreTableViewCell
            
            //reste a supprimer le score de la BDD
            Score.shared.DeleteOneScore(cell.nameLabel.text!)
            
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }

}
