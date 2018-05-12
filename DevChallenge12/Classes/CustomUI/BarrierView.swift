//
//  BarrierView.swift
//  DevChallenge12
//
//  Created by " " on 5/10/18.
//  Copyright © 2018 " ". All rights reserved.
//

import UIKit

class BarrierView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func borderPosition(sView: UIView) {
        let borderWidth: Int = 5
        let bothBorderWidth: Int = borderWidth * 2
        let mealWidth: Int = 20
        let mealHeight: Int = 10
        let superViewWidth: Int = Int(sView.bounds.width)
        let superViewHeight: Int = Int(sView.bounds.height)
        let maxCountOfPartsXline = (superViewWidth - bothBorderWidth - (superViewWidth % mealWidth)) / mealWidth
        let maxCountOfPartsYline = (superViewHeight - bothBorderWidth - (superViewHeight % mealHeight)) / mealHeight
        let xPosition = Int(arc4random_uniform(UInt32(maxCountOfPartsXline))) * mealWidth + borderWidth
        let yPosition = Int(arc4random_uniform(UInt32(maxCountOfPartsYline))) * mealHeight + borderWidth
        self.layer.backgroundColor = UIColor.purple.cgColor
        self.frame = CGRect(x: xPosition, y: yPosition, width: mealWidth, height: mealHeight)
        self.setNeedsDisplay()

    }
    

}
