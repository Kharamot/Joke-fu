//
//  JokeFuViewController.swift
//  Joke-fu
//
//  Created by Kameron Haramoto on 3/26/17.
//  Copyright © 2017 Kameron Haramoto. All rights reserved.
//

import UIKit

class JokeFuViewController: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var PassFailImage: UIImageView!
    
    @IBOutlet weak var StartLabel: UILabel!
    @IBOutlet weak var EndLabel: UILabel!
    
    let threshold: CGFloat = 15.0
    var startPoint: CGPoint!
    var endPoint: CGPoint!
    var dotView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        PassFailImage.isHidden = true
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector (handlePan))
        panGestureRecognizer.delegate = self
        self.view.addGestureRecognizer(panGestureRecognizer)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func TryAgainButtonPressed(_ sender: UIButton) {
        PassFailImage.isHidden = true
        for view in self.view.subviews
        {
            if(view.backgroundColor == UIColor.blue)
            {
                view.removeFromSuperview()
            }
        }
        PassFailImage.image = #imageLiteral(resourceName: "pass.png")
    }

    @IBAction func handlePan(recognizer: UIPanGestureRecognizer)
    {
        let point = recognizer.location(in: self.view)
        dotView = UIView(frame: CGRect(x: point.x, y: point.y, width: 5.0, height:5.0))
        
        dotView.backgroundColor = UIColor.blue
        self.view.addSubview(dotView)
        
        if(recognizer.state == .began)
        {
            self.startPoint = point
        }
        if(recognizer.state == .changed)
        {
            if(point.y > startPoint.y + threshold || point.y < startPoint.y - threshold)
            {
                self.PassFailImage.image = #imageLiteral(resourceName: "Fail.png")
                return
            }
        }
        if(recognizer.state == .ended)
        {
            self.endPoint = point
            passFail()
            PassFailImage.isHidden = false
        }
    }
    
    func passFail()
    {
        if(!self.StartLabel.frame.contains(self.startPoint))
        {
            self.PassFailImage.image = #imageLiteral(resourceName: "Fail.png")
        }
        else if(!self.EndLabel.frame.contains(self.endPoint))
        {
            self.PassFailImage.image = #imageLiteral(resourceName: "Fail.png")
        }
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
