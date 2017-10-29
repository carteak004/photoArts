//
//  ViewController.swift
//  KC_PhotoArts+
//
//  Created by Kartheek chintalapati on 24/10/17.
//  Copyright © 2017 Northern Illinois University. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - User defined function for JSON data
    func fetchJsonData()
    {
        
        let api_url = URL(string: "http://faculty.cs.niu.edu/%7Ekrush/ios/client_list_json.txt") //create URL variable
        let urlRequest = URLRequest(url: api_url!) //create URL request
        
        //submit a request to JSON Data
        let task = URLSession.shared.dataTask(with: urlRequest)
        {
            (data,response,error) in
            //if there is an error, print it and do not continue
            if error != nil {
                print(error!)
                return
            }
            
            //if there is no error, fetch json content
            if let content = data {
                do {
                    let jsonObject = try JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                    
                    //fetch only client data
                    if let clientJson = jsonObject["clients"] as? [[String:AnyObject]] {
                        for item in clientJson
                        {
                            if let name = item["name"] as? String, let profession = item["profession"] as? String, let dob = item["dob"] as? String, let children = item["children"] as? [String]
                            {
                               /* let singlePerson = Person()
                                singlePerson.name = name
                                singlePerson.dob = dob
                                singlePerson.profession = profession
                                singlePerson.children = children
                                
                                self.personData.append(singlePerson)*/
                            }
                        }
                    }
                    //self.tableView.reloadData()
                }
                catch {
                    print(error)
                }
            }
        }
        task.resume()
    }



}

