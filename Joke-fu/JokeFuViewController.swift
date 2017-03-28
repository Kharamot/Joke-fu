//
//  JokeFuViewController.swift
//  Joke-fu
//
//  Created by Kameron Haramoto on 3/26/17.
//  Copyright © 2017 Kameron Haramoto. All rights reserved.
//

import UIKit

class JokeFuViewController: UIViewController {

    @IBOutlet weak var PassFailImage: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        PassFailImage.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func TryAgainButtonPressed(_ sender: UIButton) {
        PassFailImage.isHidden = true
    }

    @IBAction func handlePan(recognizer: UIPanGestureRecognizer)
    {
        let dotView = UIView(frame: CGRect(x: point.x, y: point.y, width: 5.0, height:5.0))
        
        dotView.backgroundColor = UIColor.blue
        self.view.addSubview(dotView)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
