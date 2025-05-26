//
//  MultipartParameterEncoding.swift
//  MutualFundSDK
//
//  Created by Darshan Mothreja on 20/12/20.
//

import Foundation

struct MultipartParameterEncoding: ParameterEncoder {
    func encode(urlRequest: inout URLRequest, with parameters: HTTPParameters) throws {
        
    }
    
    func encode(urlRequest: inout URLRequest, with parameters: HTTPParameters, media: [MediaModel]?) throws {
        
        guard urlRequest.url != nil else { throw NetworkError.missingURL }
        
        //Generate Boundary and set Content Type
        let boundary = "\(UUID().uuidString)"
        let data = createBodyWithMedieFiles(parameters, media: media, boundary: boundary)
        urlRequest.httpBody = data
        urlRequest.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        print("Request Created : URL - \(urlRequest.url?.absoluteString ?? "") , Post Data - \(parameters.description)")
    }
    
    private func createBodyWithMedieFiles(_ parameters: HTTPParameters?,
                                           media: [MediaModel]?,
                                           boundary: String) -> Data {

        let body = NSMutableData();

        //Append all http parameters here
        if parameters != nil, parameters!.count > 0 {
            for (key, value) in parameters! {
                
                body.append("--\(boundary)\r\n".data(using: .utf8)!)
                body.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".data(using: .utf8)!)
                body.append("\(value)\r\n".data(using: .utf8)!)
            }
        }

        //Append multiple or single media files here as form data
        if let attachments = media {
            for attachment in attachments {
                var fileExtension = ""
                if attachment.fileType == "application/pdf" {
                    fileExtension = ".pdf"
                } else {
                    fileExtension = ".jpeg"
                }
                
                body.append("--\(boundary)\r\n".data(using: .utf8)!)
                body.append("Content-Disposition: form-data; name=\"\(attachment.fetchFileName())\"; filename=\"\(attachment.fetchFileName())\(fileExtension)\"\r\n".data(using: .utf8)!)
                body.append("Content-Type: \(attachment.fetchFileType())\r\n\r\n".data(using: .utf8)!)
                body.append(attachment.fetchData() ?? Data())
                body.append("\r\n".data(using: .utf8)!)
            }
        }

        // This indicates end of data
        body.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
        
        //print((body as Data).base64EncodedString())
        return body as Data
    }
}

