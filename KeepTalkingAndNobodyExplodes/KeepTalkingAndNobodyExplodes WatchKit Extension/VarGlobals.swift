//
//  RandomChoice.swift
//  KeepTalkingAndNobodyExplodes WatchKit Extension
//
//  Created by David Fournier on 08/01/2018.
//  Copyright © 2018 Salomé Russier. All rights reserved.
//

import Foundation

class VarGlobals {
    static let number = arc4random_uniform(3)+1
    
    var nbrEssaie = 0
    var nbrReussie = 0
    
    static let shared = VarGlobals()

    func updateNbrEssaie() {
        nbrEssaie += 1
    }
    func updateNbrReussi() {
        nbrReussie += 1
    }
    
    func resetVar(){
        nbrEssaie = 0
        nbrReussie = 0
    }
    
    private init() {}
}
