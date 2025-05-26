//
//  MediaModel.swift
//  MutualFundSDK
//
//  Created by Darshan Mothreja on 20/12/20.
//

import Foundation

struct MediaModel {
    
    var fileName : String?
    var filePath : URL?
    var data     : Data?
    var fileType : String?
    
    // Fetch Media in Data format
    func fetchData() -> Data? {
        
        if let data = data {
            return data
        }
        //Code to retrieve data from url
        if let url = filePath{
            do{
                let dataFile = try Data.init(contentsOf: url)
                return dataFile
            }
            catch let error as NSError{
                print(error)
            }
        }
        return nil
    }

    func fetchFileType() -> String {
        return fileType ?? "image/png"
    }
    
    func fetchFileName() -> String {
        
        return fileName ?? ""
    }
}
