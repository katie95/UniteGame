//
//  RuleViewController.swift
//  Unite
//
//  Created by Katie Ning on 11/30/15.
//  Copyright © 2015 Katie Ning. All rights reserved.
//

import UIKit

class RuleViewController: UIViewController {
    
    var rules: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red:0.65, green:0.97, blue:0.85, alpha:1.0)
        
        let label = UILabel(frame: CGRect(x: view.frame.midX, y: 50, width: 300, height: 500))
        label.text = "UNITE!"
        label.center = CGPoint(x: view.frame.midX, y: 200)
        label.textAlignment = NSTextAlignment.Center
        label.font = UIFont.boldSystemFontOfSize(60)
        label.textColor = UIColor.purpleColor()
        self.view.addSubview(label)
        
        
        rules = UITextView(frame: CGRect(x: 10, y: view.frame.maxY - 300, width: view.frame.maxX-20, height: view.frame.maxY/2))
        rules.font = UIFont.boldSystemFontOfSize(20)
        rules.backgroundColor = UIColor.clearColor()
        rules.text = "Select groups of three where:\n\n1. all shapes are the same or different,\n2. all fill colors are the same or different,\n3. all background colors are the same or different\n\nHit \"no solution\" if no solution left; +50 if true, -20 if false\n\nYou have 2 minutes!"
        rules.alpha = 0
        self.view.addSubview(rules)
        
        let returnButton = UIButton(type: UIButtonType.System) as UIButton
        returnButton.frame = CGRectMake(100, 100, 180, 50)
        returnButton.center = CGPoint(x: view.frame.midX, y: 300)
        returnButton.layer.cornerRadius = 10
        //returnButton.backgroundColor = UIColor.grayColor()
        returnButton.setTitle("Game Start", forState: UIControlState.Normal)
        returnButton.titleLabel?.font = UIFont.boldSystemFontOfSize(24)
        returnButton.addTarget(self, action: "startGame:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(returnButton)
        
        
        let howButton = UIButton(type: UIButtonType.System) as UIButton
        howButton.frame = CGRectMake(100, 100, 180, 50)
        howButton.center = CGPoint(x: view.frame.midX, y: 355)
        howButton.layer.cornerRadius = 10
        //returnButton.backgroundColor = UIColor.grayColor()
        howButton.setTitle("How to play", forState: UIControlState.Normal)
        howButton.titleLabel?.font = UIFont.boldSystemFontOfSize(24)
        howButton.addTarget(self, action: "howToPlay:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(howButton)
        // Do any additional setup after loading the view.
    }
    
    func startGame(sender: UIButton!){
        let vc = ViewController()
        showViewController(vc, sender: self)
    }
    
    func howToPlay(sender: UIButton!){
        UIView.animateWithDuration(1, animations: {
            self.rules.alpha = 1
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
