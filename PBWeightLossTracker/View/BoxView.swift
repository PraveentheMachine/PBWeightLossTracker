//
//  BoxView.swift
//  PBWeightLossTracker
//
//  Created by Praveen Bandarage on 4/02/21.
//

import UIKit

class RectangleView: UIView {
    var xPosition: Int?
    var yPosition: Int?
    var rectangleHeight: Int?
    let peep = UIScreen.main.bounds

    
    init(xPosition: Int, yPosition: Int, rectangleHeight: Int) {
        self.xPosition = xPosition
        self.yPosition = yPosition

        self.rectangleHeight = rectangleHeight
        let screenWidth = peep.width
        let rectWidth = Double(screenWidth * 0.9)
        let rectHeight = rectangleHeight
                // Create a CGRect object which is used to render a rectangle.
        let rectFrame: CGRect = CGRect(x:CGFloat(xPosition), y:CGFloat(yPosition), width:CGFloat(rectWidth), height:CGFloat(rectHeight))
        super.init(frame: rectFrame);
        self.backgroundColor = UIColor.white;
        self.layer.cornerRadius = 12

    }

       required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented"); }
}
