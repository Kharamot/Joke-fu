//
//  ViewController.swift
//  Joke-fu
//
//  Created by Kameron Haramoto on 3/26/17.
//  Copyright © 2017 Kameron Haramoto. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var Line1Label: UILabel!
    @IBOutlet weak var Line2Label: UILabel!
    @IBOutlet weak var Line3Label: UILabel!
    @IBOutlet weak var AnswerLabel: UILabel!
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        Line1Label.isHidden = true
        Line2Label.isHidden = true
        Line3Label.isHidden = true
        AnswerLabel.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func FindBarButtonPressed(_ sender: UIButton) {
    }

    @IBAction func CheckJokeFuButtonPressed(_ sender: UIButton) {
    }
    
    @IBAction func GetJokeButtonPressed(_ sender: UIButton) {
        Line1Label.isHidden = true
        Line2Label.isHidden = true
        Line3Label.isHidden = true
        AnswerLabel.isHidden = true
        
        let url = URL(string: "http://www.eecs.wsu.edu/~holder/courses/MAD/hw9/getjoke.php")
        let dataTask = URLSession.shared.dataTask(with: url!,completionHandler: handleResponse)
        dataTask.resume()
    }
    
    
    
    func handleResponse (data: Data?, response: URLResponse?, error: Error?) {
        if (error != nil) {
            print("error: \(error!.localizedDescription)") }
        else {
        let httpResponse = response as! HTTPURLResponse
        let statusCode = httpResponse.statusCode
        if statusCode != 200 {
            let msg = HTTPURLResponse.localizedString(forStatusCode: statusCode)
            print("HTTP \(statusCode) error: \(msg)")
        } else {
            // respsonse okay, do something with data
            let dataStr = String(data: data!, encoding: .utf8)
            print("data = \(dataStr)")
            }
        
        }
        if let jsonObj = try? JSONSerialization.jsonObject(with: data!, options: []) {
            let jsonDict = jsonObj as! [String: AnyObject]
            let joke = jsonDict["joke"] as! [String: AnyObject]
            DispatchQueue.main.async {
                self.Line1Label.text = joke["line1"] as! String?
                self.Line2Label.text = joke["line2"] as! String?
                self.Line3Label.text = joke["line3"] as! String?
                self.AnswerLabel.text = joke["answer"] as! String?
                
                self.Line1Label.isHidden = false
                self.Line2Label.isHidden = false
                self.Line3Label.isHidden = false
                self.AnswerLabel.isHidden = false
            }
        } else {
            print("error: invalid JSON data")
        }
    }
    
    
}

