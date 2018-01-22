//
//  Score.swift
//  KeepTalkingAndNobodyExplodes
//
//  Created by Salomé Russier on 07/01/2018.
//  Copyright © 2018 Salomé Russier. All rights reserved.
//

import Foundation
import CoreData

extension Score{
    
    public static let shared = Score()
    
    public func InsertScore(name: String, point: Double){
        if let ctx = DataManager.shared.objectContext{
            if let s = NSEntityDescription.insertNewObject(forEntityName: "Score", into: ctx) as? Score{
                s.name = name
                s.point = point
                s.date = NSDate() as Date
                
            }
            try? ctx.save()
        }

        
    }
    
    public func getCount() -> Int {
        let fetchRequest: NSFetchRequest<Score> = Score.fetchRequest()
        if let ctx = DataManager.shared.objectContext{
            if let rows = try? ctx.fetch(fetchRequest) {
                return rows.count
            }
        }
        return -1
    }

    
    public func GetScoreOrdred()-> [Score]{
        var result:[Score] = []
        let fetchRequest: NSFetchRequest<Score> = Score.fetchRequest()
        if let ctx = DataManager.shared.objectContext{
            if let rows = try? ctx.fetch(fetchRequest) {
                for row in rows{
                    result.append(row)
                }
            }
        }
        return result.sorted(by: {$0.point > $1.point})
        
    }
    
    public func DeleteAllScore(){
        let fetchRequest: NSFetchRequest<Score> = Score.fetchRequest()
        if let ctx = DataManager.shared.objectContext{
            if let data = try? ctx.fetch(fetchRequest){
                for item in data{
                    ctx.delete(item)
                }
            }
        }
    }
    
    
    
    public func DeleteOneScore(_ name: String){
        let fetchRequest: NSFetchRequest<Score> = Score.fetchRequest()
        //fetchRequest.predicate = NSPredicate(format:"name ==@", name!)
        if let ctx = DataManager.shared.objectContext{
            if let data = try? ctx.fetch(fetchRequest){
                for item in data{
                    if item.name == name{
                        ctx.delete(item)
                        if let result = try? ctx.save(){
                            
                        }
                    }
                }
            }
           
        }
    }
}
