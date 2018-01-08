//
//  RandomChoice.swift
//  KeepTalkingAndNobodyExplodes WatchKit Extension
//
//  Created by David Fournier on 08/01/2018.
//  Copyright © 2018 Salomé Russier. All rights reserved.
//

import Foundation

class RandomChoice {
    static let number = arc4random_uniform(3)+1
        
    private init() {}
    
}
