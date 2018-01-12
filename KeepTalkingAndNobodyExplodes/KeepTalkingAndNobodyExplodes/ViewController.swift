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

    
    override func viewDidLoad() {
        super.viewDidLoad()
        if WCSession.isSupported(){
            let session = WCSession.default
            session().delegate = self
            session().activate()
            
        }
        // en attendant d'avoir les vrai score
        bouchon()
        self.scoreList = Score.shared.GetScoreOrdred()
        
        scoreTableView.delegate = self
        scoreTableView.dataSource = self
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
    
    
    func bouchon(){
        Score.shared.DeleteAllScore()
        Score.shared.InsertScore(name: "first", point: 50)
        Score.shared.InsertScore(name: "second", point: 60)
        Score.shared.InsertScore(name: "third", point: 42)
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
        
        if (name == "perdu"){
            let alertBox = UIAlertController(title: "Game Over",
                                             message: "Votre ami(e) a péri... Honte sur vous ",
                                             preferredStyle: .alert)
            //valisation
            let confirmAction = UIAlertAction(title: "J'ai honte", style: .cancel) {(_)in}
            
            
            
            //annuler
            
            
            alertBox.addAction(confirmAction)
            
            self.present(alertBox, animated: true, completion: nil)
            
        }
        
        
    }
    
    
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
    

}
