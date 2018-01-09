//
//  ScoreTableViewController.swift
//  KeepTalkingAndNobodyExplodes
//
//  Created by Salomé Russier on 07/01/2018.
//  Copyright © 2018 Salomé Russier. All rights reserved.
//

import Foundation
import UIKit

class ScoreTableViewController: UITableViewController{

    var textCellIdentifier: String = "idCell"
    var scoreList: [Score]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scoreList = Score.shared.GetScoreOrdred()

        
        
    }

    
    private func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Score.shared.getCount()
    }
    
    override func tableView( _ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: textCellIdentifier, for: indexPath as IndexPath) as! ScoreTableViewCell
        
        let score = scoreList[indexPath.row]
        cell.nameLabel.text = score.name
        cell.pointLabel.text = "\(score.point)"
        
        
        return cell
    }

    
}

