//
//  MealView.swift
//  DevChallenge12
//
//  Created by Serhii on 5/9/18.
//  Copyright © 2018 Serhii. All rights reserved.
//

import UIKit

class MealView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupFrame(superView: UIView) {
        let borderWidth: Int = 5
        let mealSize: Int = 10
        let superViewSize = superView.bounds.size
        let superViewWidth: Int = Int(superViewSize.width)
        let superViewHeight: Int = Int(superViewSize.height)
        let maxCountOfPartsXline = (superViewWidth - borderWidth - superViewWidth % 10) / mealSize
        let maxCountOfPartsYline = (superViewHeight - borderWidth - superViewHeight % 10) / mealSize
        let xPosition = Int(arc4random_uniform(UInt32(maxCountOfPartsXline))) * mealSize + 5
        let yPosition = Int(arc4random_uniform(UInt32(maxCountOfPartsYline))) * mealSize + 5
        self.layer.backgroundColor = UIColor.black.cgColor
        self.frame = CGRect(x: xPosition, y: yPosition, width: mealSize, height: mealSize)
        self.setNeedsDisplay()
    }
}
