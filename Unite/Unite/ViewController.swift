//
//  ViewController.swift
//  Unite
//
//  Created by Katie Ning on 11/22/15.
//  Copyright © 2015 Katie Ning. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    var SelectedCell = [CustomCollectionViewCell]()
    var allCell = [CustomCollectionViewCell]()
    var label:UILabel!
    var scoreLabel:UILabel!
    var time: UILabel!
    var score: Int!
    var timer: NSTimer!
    var seconds: Int!
    
    
    lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: self.view.bounds, collectionViewLayout: self.flowLayout)
        cv.dataSource = self
        cv.delegate = self
        cv.bounces = true
        cv.alwaysBounceVertical = true
        cv.autoresizingMask = [UIViewAutoresizing.FlexibleHeight, UIViewAutoresizing.FlexibleWidth]
        cv.registerClass(CustomCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        cv.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        return cv
    }()
    
    lazy var flowLayout: UICollectionViewFlowLayout = {
        let flow = UICollectionViewFlowLayout()
        flow.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
        flow.minimumInteritemSpacing = 1
        flow.minimumLineSpacing = 8
        flow.itemSize = CGSize(width: 300, height: 300)
        return flow
    }()
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! CustomCollectionViewCell
        cell.layer.borderWidth = 5
        cell.layer.borderColor = UIColor.clearColor().CGColor
        cell.layer.cornerRadius = 3
        allCell.append(cell)
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! CustomCollectionViewCell
        if (cell.wasSelected == true){
            cell.layer.borderColor = UIColor.clearColor().CGColor
            cell.wasSelected = false
            SelectedCell.removeAtIndex(SelectedCell.indexOf(cell)!)
        }else{
            cell.layer.borderColor = UIColor.yellowColor().CGColor
            cell.wasSelected = true
            SelectedCell.append(cell)
            if (SelectedCell.count == 3){
                let delay = Double(NSEC_PER_SEC)/5
                let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
                dispatch_after(time, dispatch_get_main_queue()){
                    self.checkSelection()
                }
            }
        }
    }
    
    func checkSelection(){
        if (checkShape(SelectedCell) && checkFillColor(SelectedCell) && checkBackgroundColor(SelectedCell)){
            for cells in SelectedCell{
                cells.reload()
            }
            score = score + 10
            scoreLabel.text = "Score: " + String(score)
        }
        for cells in SelectedCell{
            cells.layer.borderColor = UIColor.clearColor().CGColor
            cells.wasSelected = false
        }
        SelectedCell.removeAll()
    }
    
    func checkShape(list: Array<CustomCollectionViewCell>)->Bool{
        let cell0 = list[0].shape
        let cell1 = list[1].shape
        let cell2 = list[2].shape
        if ((cell0 == cell1)&&(cell1 == cell2)){
            return true
        }else if ((cell0 != cell1) && (cell0 != cell2) && (cell1 != cell2)){
            return true
        }else{
            return false
        }
    }
    
    func checkFillColor(list: Array<CustomCollectionViewCell>)->Bool{
        let cell0 = list[0].shapeLayer.fillColor
        let cell1 = list[1].shapeLayer.fillColor
        let cell2 = list[2].shapeLayer.fillColor
        
        if (CGColorEqualToColor(cell0, cell1) && CGColorEqualToColor(cell1, cell2)){
            return true
        }else if ((!CGColorEqualToColor(cell0, cell1)) && (!CGColorEqualToColor(cell0, cell2)) && (!CGColorEqualToColor(cell1, cell2))){
            return true
        }else{
            return false
        }
        
    }
    
    func checkBackgroundColor(list: Array<CustomCollectionViewCell>)->Bool{
        let cell0 = list[0].backgroundColor!.CGColor
        let cell1 = list[1].backgroundColor!.CGColor
        let cell2 = list[2].backgroundColor!.CGColor
        
        if (CGColorEqualToColor(cell0, cell1) && CGColorEqualToColor(cell1, cell2)){
            return true
        }else if ((!CGColorEqualToColor(cell0, cell1)) && (!CGColorEqualToColor(cell0, cell2)) && (!CGColorEqualToColor(cell1, cell2))){
            return true
        }else{
            return false
        }
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let width = view.bounds.width / 3.0 - 5.0
        let height = width;
        return CGSize(width: width, height: height)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Unite!"
        for cells in allCell{
            cells.reload()
        }
        for cells in SelectedCell{
            cells.layer.borderColor = UIColor.clearColor().CGColor
            cells.wasSelected = false
        }
        SelectedCell.removeAll()
        view.addSubview(self.collectionView)
        
        seconds = 120
        score = 0
        let button = UIButton(type: UIButtonType.System) as UIButton
        button.frame = CGRectMake(100, 100, 180, 50)
        button.center = CGPoint(x: view.frame.midX, y: view.frame.maxY-150)
        button.layer.cornerRadius = 10
        button.backgroundColor = UIColor.grayColor()
        button.setTitle("No Solution!", forState: UIControlState.Normal)
        button.titleLabel?.font = UIFont.boldSystemFontOfSize(24)
        button.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        button.setTitleShadowColor(UIColor.blackColor(), forState: UIControlState.Normal)
        button.addTarget(self, action: "buttonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(button)
    
        
        label = UILabel(frame: CGRectMake(0, 0, 400, 21))
        label.center = CGPoint(x: view.frame.midX, y: view.frame.maxY-100)
        label.textAlignment = NSTextAlignment.Center
        label.textColor = UIColor.redColor()
        label.font = UIFont.boldSystemFontOfSize(24)
        label.text = "I'am a test label"
        label.hidden = true
        self.view.addSubview(label)
        
        scoreLabel = UILabel(frame: CGRectMake(0, 0, 400, 21))
        scoreLabel.center = CGPoint(x: 80, y: view.frame.maxY-50)
        scoreLabel.textAlignment = NSTextAlignment.Center
        scoreLabel.textColor = UIColor.blackColor()
        scoreLabel.font = UIFont.boldSystemFontOfSize(24)
        scoreLabel.text = "Score: " + String(score)
        self.view.addSubview(scoreLabel)
        
        time = UILabel(frame: CGRectMake(0, 0, 400, 21))
        time.center = CGPoint(x:view.frame.maxX - 80, y: view.frame.maxY-50)
        time.textAlignment = NSTextAlignment.Center
        time.textColor = UIColor.blackColor()
        time.font = UIFont.boldSystemFontOfSize(24)
        time.text = "Time: \(seconds)"
        self.view.addSubview(time)
        
        timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("subtractTime"), userInfo: nil, repeats: true)
    }
    
    func subtractTime(){
        seconds = seconds - 1
        time.text = "Time: \(seconds)"
        
        if (seconds <= 10){
            time.textColor = UIColor.redColor()
        }
        
        if (seconds == 0){
            timer.invalidate()
            let gameover = UIAlertController(title: "Time's Up", message: "Final Score: \(score)", preferredStyle: UIAlertControllerStyle.Alert)
            let playagain = UIAlertAction(title: "Play Again", style: UIAlertActionStyle.Default, handler: {
                action in self.viewDidLoad()
            })
            gameover.addAction(playagain)
            presentViewController(gameover, animated: true, completion: nil)
        }
    }
    
    
    func buttonAction(sender:UIButton!)
    {
        let combination = self.combinations(allCell, k: 3)
        var solution = false
        for groups in combination{
            if (checkShape(groups) && checkFillColor(groups) && checkBackgroundColor(groups)){
                label.text = "Solutions left! Score - 20"
                label.hidden = false
                solution = true
                score = score - 20
                scoreLabel.text = "Score: " + String(score)
                let delay = Double(NSEC_PER_SEC)/2
                let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
                dispatch_after(time, dispatch_get_main_queue()){
                    self.label.hidden = true
                }
                break
            }
        }
        if (!solution){
            label.text = "No solution! Reload! Score + 50"
            label.hidden = false
            score = score + 50
            scoreLabel.text = "Score: " + String(score)
            for cells in allCell{
                cells.reload()
            }
            let delay = Double(NSEC_PER_SEC)/2
            let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
            dispatch_after(time, dispatch_get_main_queue()){
                self.label.hidden = true
            }
        }
    }
    
    //This function is a helper function for combinations
    func sliceArray<T>(var arr: Array<T>, x1: Int, x2: Int) -> Array<T> {
        var tt: Array<T> = []
        for var ii = x1; ii <= x2; ++ii {
            tt.append(arr[ii])
        }
        return tt
        
    }
    //This combination algorithm is cited from https://swiftlearner.wordpress.com/2014/09/17/6/
    func combinations<T>(arr: Array<T>, k: Int) -> Array<Array<T>> {
        var ret: Array<Array<T>> = []
        var sub: Array<Array<T>> = []
        var next: Array<T> = []
        for (var i = 0; i < arr.count; i++) {
            if(k == 1){
                ret.append([arr[i]])
            }else {
                sub = combinations(sliceArray(arr, x1: i + 1, x2: arr.count-1), k: k-1)
                for (var subI = 0; subI < sub.count; subI++) {
                    next = sub[subI]
                    next.insert(arr[i], atIndex: 0)
                    ret.append(next)
                }
            }
        }
        return ret
        
    }
}

