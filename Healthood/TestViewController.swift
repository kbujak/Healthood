//
//  TestViewController.swift
//  Healthood
//
//  Created by Krystian Bujak on 05/12/2017.
//  Copyright © 2017 Krystian Bujak. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {

    @IBOutlet weak var recordsCountTextField: UITextField!
    
    var dataBaseDelegate: DataBaseProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataBaseDelegate = (UIApplication.shared.delegate as! AppDelegate).dataBaseDelegate
    }
    
    @IBAction func testButtonAct(_ sender: Any) {
        if let recordCountText = recordsCountTextField.text, let recordCount = Int(recordCountText){
            var ingridientArray = [Ingridient]()
            for _ in 0..<recordCount{
                ingridientArray.append(Ingridient())
            }
            if let db = self.dataBaseDelegate{
                let results = try! db.test(with: ingridientArray)
                var resultsString = "\(db.dataBaseType.rawValue): \(recordCount)\n"
                for (key,value) in results{
                    resultsString += "\(key): \(value) s\n"
                }
                
                do {
                    let dirURL = URL(fileURLWithPath: "/Users/Booyac/Documents/Studia/Semestr 7/Praca Inzynierska")
                    let fileURL = dirURL.appendingPathComponent("\(db.dataBaseType.rawValue)-\(recordCount)-\(Date())").appendingPathExtension("txt")
                    print(fileURL.absoluteString)
                    try resultsString.write(to: fileURL, atomically: false, encoding: .utf8)
                } catch {
                    print(error)
                }
            }
        }
    }
}
