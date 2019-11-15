//
//  ModelManager.swift
//  AVSoft_TestTask
//
//  Created by Tianid on 14.11.2019.
//  Copyright © 2019 Tianid. All rights reserved.
//

import Foundation


class ModelManager {
    
    static let shared = ModelManager()
    
    var personesArray: [Persone]? = []
    var cellIndex: Int?
    
    
    func startSaving() {
        do {
            let data = try JSONEncoder().encode(personesArray)
            saveToFile(data: data)
        } catch {
            print(error)
        }
        
    }
    
    
    private func saveToFile(data: Data) {
        
        let path = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first
        if path == nil { return }
        
        let dirUrl = path?.appendingPathComponent("AVSoft_testTask_Persones")
        var isDir:ObjCBool = false
        if FileManager.default.fileExists(atPath: (dirUrl?.path)!, isDirectory: &isDir) == false, isDir.boolValue == false{
            do {
                try FileManager.default.createDirectory(at: dirUrl!, withIntermediateDirectories: true, attributes: nil)
            } catch {}
        }
        
        let filename = dirUrl?.appendingPathComponent("Persones")
        
        print(FileManager.default.createFile(atPath: filename!.path, contents: data, attributes: nil) , " - RESULT OF CREATING LOCAL FILE")
        print("absolute savepath - ",filename?.absoluteURL.absoluteString ?? "")
    }
    
    
     func loadFromFile() {
        let path = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first
        if path == nil { return }
        
        let dirUrl = path?.appendingPathComponent("AVSoft_testTask_Persones/Persones")
        var isFile = false
        isFile = FileManager.default.fileExists(atPath: dirUrl!.path)
        if isFile {
            do {
                let data = try Data(contentsOf: dirUrl!)
                let persone = try JSONDecoder().decode([Persone].self, from: data)
                personesArray = persone
            } catch {
                print(error)
            }
        }
    }
}
