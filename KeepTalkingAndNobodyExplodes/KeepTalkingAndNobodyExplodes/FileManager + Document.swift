//
//  FileManager + Document.swift
//  KeepTalkingAndNobodyExplodes
//
//  Created by Salomé Russier on 07/01/2018.
//  Copyright © 2018 Salomé Russier. All rights reserved.
//

import Foundation


extension FileManager {
    
    public static func documentURL() -> URL? {
        return FileManager.documentURL(childPath: nil)
    }
    
    public static func documentURL(childPath: String?) -> URL? {
        if let documentURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            // si childPath non null créer la variable path init avec childpath
            if let path = childPath {
                return documentURL.appendingPathComponent(path)
            }
            return documentURL
        }
        return nil
    }
    
    
}
