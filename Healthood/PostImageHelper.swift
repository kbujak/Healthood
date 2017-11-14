//
//  PostImageHelper.swift
//  Healthood
//
//  Created by Krystian Bujak on 11/11/2017.
//  Copyright © 2017 Krystian Bujak. All rights reserved.
//

import Foundation
import UIKit

class PostImageHelper{

    let serverPath: String!
    
    init(){
        self.serverPath = (UIApplication.shared.delegate as! AppDelegate).dataBaseDelegate.serverPath
    }
    
    func myImageUploadRequest(with image: UIImage, for name: String, using dbType: DataBaseType, imgType: ImageType) -> String?
    {
        let serverURL = URL(string: "http://" + self.serverPath + "/postImage.php")
        var request = URLRequest(url: serverURL!)
        request.httpMethod = "POST"
        
        let param = [
            "name"  : String.SHA256(name + String.randomString(length: 15))! + ".jpg",
            "dbType"    : dbType.rawValue,
            "imgType"   : imgType.rawValue
        ]
        let boundary = generateBoundaryString()        
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        let imageData = UIImageJPEGRepresentation(image, 0.8)
        
        if(imageData==nil)  { return nil }
        request.httpBody = createBodyWithParameters(parameters: param, filePathKey: "file", imageDataKey: imageData! as NSData, boundary: boundary) as Data

        let task = URLSession.shared.dataTask(with: request){
            data, response, error in
            if error != nil{
                print("error = \(error!)")
            }
            
            print("*****response = \(response!)")
            let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            print("****** response data = \(responseString!)")
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary
                print(json)
            }catch
            {
                print(error)
            }
        }
        task.resume()
        return param["name"]
    }
    
    
    func createBodyWithParameters(parameters: [String: String]?, filePathKey: String?, imageDataKey: NSData, boundary: String) -> NSData {
        let body = NSMutableData();
        
        if parameters != nil {
            for (key, value) in parameters! {
                body.appendString(string: "--\(boundary)\r\n")
                body.appendString(string: "Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                body.appendString(string: "\(value)\r\n")
            }
        }
        
        let filename = "user-profile.jpg"
        let mimetype = "image/jpg"
        
        body.appendString(string: "--\(boundary)\r\n")
        body.appendString(string: "Content-Disposition: form-data; name=\"\(filePathKey!)\"; filename=\"\(filename)\"\r\n")
        body.appendString(string: "Content-Type: \(mimetype)\r\n\r\n")
        body.append(imageDataKey as Data)
        body.appendString(string: "\r\n")

        body.appendString(string: "--\(boundary)--\r\n")
        
        return body
    }
    
    func generateBoundaryString() -> String {
        return "Boundary-\(NSUUID().uuidString)"
    }
    
    
}
extension NSMutableData {
    
    func appendString(string: String) {
        let data = string.data(using: String.Encoding.utf8, allowLossyConversion: true)
        append(data!)
    }
}

