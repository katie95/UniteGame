//
//  CustomCollectionViewCell.swift
//  Unite
//
//  Created by Katie Ning on 11/30/15.
//  Copyright © 2015 Katie Ning. All rights reserved.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    
    var wasSelected = false
    var shape = ""
    var shapeLayer: CAShapeLayer!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //Use random number to select which shape to draw
        let randomFunc = [self.drawCircle(), self.drawSquare(), self.drawTriangle()]
        let identifier = ["circle", "square", "triangle"]
        let randomShape = Int(arc4random_uniform(UInt32(randomFunc.count)))
        shapeLayer = randomFunc[randomShape]
        shape = identifier[randomShape]
        
        //Use random number to select fillcolor
        let randomFillColorSet = [UIColor.purpleColor().CGColor, UIColor.orangeColor().CGColor, UIColor.greenColor().CGColor]
        let randomFillColor = Int(arc4random_uniform(UInt32(randomFillColorSet.count)))
        shapeLayer.fillColor = randomFillColorSet[randomFillColor]
        
        //Use random number to select background color
        let randomBackgroundColorSet = [UIColor.whiteColor(), UIColor.blackColor(), UIColor.grayColor()]
        let randomBackgroundColor = Int(arc4random_uniform(UInt32(randomBackgroundColorSet.count)))
        backgroundColor = randomBackgroundColorSet[randomBackgroundColor]
        
        //add the shapelayer
        layer.addSublayer(shapeLayer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
 
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //        self.label.frame = self.bounds
    }
    
    func drawCircle()->CAShapeLayer{
        //draw a circle
        let circlePath = UIBezierPath(arcCenter: CGPointMake(frame.width/2.0, frame.height/2.0), radius: CGFloat(frame.width/2.0-20), startAngle: CGFloat(0), endAngle:CGFloat(M_PI * 2), clockwise: true)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circlePath.CGPath
        return shapeLayer
    }
    
    func drawTriangle()->CAShapeLayer{
        //draw a triangle
        let shapeLayer = CAShapeLayer()
        shapeLayer.frame = self.layer.bounds
        
        let trianglePath = UIBezierPath()
        trianglePath.moveToPoint(CGPoint(x:frame.width/2,y:20))
        trianglePath.addLineToPoint(CGPoint(x:15,y:frame.height-20))
        trianglePath.addLineToPoint(CGPoint(x:frame.width-15, y:frame.height-20))
        
        shapeLayer.path = trianglePath.CGPath
        return shapeLayer
        
    }
    
    func drawSquare()->CAShapeLayer{
        let shapeLayer = CAShapeLayer()
        shapeLayer.frame = self.layer.bounds
        let rect = CGRect(x: 25, y: 25, width: frame.width-50, height: frame.width-50)
        let squarePath = UIBezierPath(rect: rect)
        shapeLayer.path = squarePath.CGPath
        return shapeLayer
    }
    
    func reload(){
        shapeLayer.removeFromSuperlayer()
        let randomFunc = [self.drawCircle(), self.drawSquare(), self.drawTriangle()]
        let identifier = ["circle", "square", "triangle"]
        let randomShape = Int(arc4random_uniform(UInt32(randomFunc.count)))
        shapeLayer = randomFunc[randomShape]
        shape = identifier[randomShape]
        
        //Use random number to select fillcolor
        let randomFillColorSet = [UIColor.purpleColor().CGColor, UIColor.orangeColor().CGColor, UIColor.greenColor().CGColor]
        let randomFillColor = Int(arc4random_uniform(UInt32(randomFillColorSet.count)))
        shapeLayer.fillColor = randomFillColorSet[randomFillColor]
        
        //Use random number to select background color
        let randomBackgroundColorSet = [UIColor.whiteColor(), UIColor.blackColor(), UIColor.grayColor()]
        let randomBackgroundColor = Int(arc4random_uniform(UInt32(randomBackgroundColorSet.count)))
        backgroundColor = randomBackgroundColorSet[randomBackgroundColor]
        
        //add the shapelayer
        layer.addSublayer(shapeLayer)
    }
    
}
