//
//  VarGlobalsIphone.swift
//  KeepTalkingAndNobodyExplodes
//
//  Created by David Fournier on 11/01/2018.
//  Copyright © 2018 Salomé Russier. All rights reserved.
//

import Foundation

class VarGlobalsIphone {
    
    var nbrEssaie = 0
    var nbrReussie = 0
    
    static let shared = VarGlobalsIphone()
    
    func updateNbrEssaie() {
        nbrEssaie += 1
    }
    func updateNbrReussi() {
        nbrReussie += 1
    }
    
    func resetVar(){
        nbrEssaie = 0
        nbrReussie = 0
        timerLeft=120000
        myTimer.invalidate()

    }
    
    private init() {}
}
